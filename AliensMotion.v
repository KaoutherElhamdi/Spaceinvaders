`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:09 11/12/2019 
// Design Name: 
// Module Name:    AliensMotion 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AliensMotion(
    clk,
    reset,
    xLaser,
    yLaser,
    motion,
    killingAlien,
    canLeft,
    canRight,
    xAlien,
    yAlien,
    alive,
    victory,
    defeat
    );

//Fonction du cours qui permet de renvoyer le nombre de bits d'un paramètre.

function integer Legth(input integer x );
		for (Legth = 0 ; x > 0 ; Legth = Legth + 1) x = x >> 1 ;
endfunction 

// Liste de paramètres	 
parameter NB_LIN = 4;
parameter NB_COL = 9;
parameter OFFSET_H = 10;
parameter OFFSET_V = 5;
parameter ALIENS_WIDTH = 20;
parameter ALIENS_HEIGHT = 10;
parameter STEP_H = 20;
parameter STEP_V = 10;
parameter STEP_H_MOTION = 1;
parameter STEP_V_MOTION = 15;

parameter LEFT = 1;
parameter RIGHT = 2;
parameter DOWN = 3;

parameter SCREEN_HEIGHT = 480;
parameter SCREEN_WIDTH = 640;

parameter NB_ALIENS = NB_LIN*NB_COL; 

parameter Y_SHIP = 15; //A REGLER PLUS PRECISEMENT

// On crée deux paramètre qui nous permetrons de dimensionner nos variable en fontion de NB_COL et NB_LIN

parameter LENGTH_COL = Legth(NB_COL);
parameter LENGTH_LIN = Legth(NB_LIN);

// Déclaration des entrées & sortie 

    input clk;
    input reset;
    input [9:0] xLaser;
    input [9:0] yLaser;
    input [2:0] motion;
    output reg killingAlien;
    output reg canLeft;
    output reg canRight;
    output reg signed [10:0] xAlien;
    output reg [9:0] yAlien;
    output reg [NB_ALIENS-1:0] alive;
    output reg victory;
    output reg defeat;

//Variables de calcul 
	 
	reg[LENGTH_COL -1:0] aliveColLeft; // Représente le numéro de la colonne encore en vie à gauche
	reg[LENGTH_COL -1:0] testAliveLeft; // Artefacte de calcul pour calculer aliveColLeft
	reg[LENGTH_COL -1:0] aliveColRight; // Représente le numéro de la colonne encore en vie à droite
	reg[LENGTH_COL -1:0] testAliveRight; // Artefacte de calcul pour calculer aliveColRight

	reg[LENGTH_LIN -1:0] aliveLowLin; // Représente le numéro de la lige la plus basse encore en vie
	reg[LENGTH_LIN -1:0] testAliveLow; // Artefact de calcul pour calculer aliveLowLin

//Variables utiles pour les boucles

	reg[LENGTH_LIN-1:0] i;
	reg[LENGTH_COL-1:0] j;
	reg[LENGTH_LIN-1:0] k;
	reg[LENGTH_COL-1:0] l;

always @(posedge clk) begin

//On remet nos paramètre de calcul à 0 à chaque itération
	
	killingAlien <= 0;
	testAliveLeft = 0;
	testAliveRight = 0;
   
//Calcul du reset, on remet dans un état connu (état de début d'une partie)
	
	if (reset) begin 
		defeat <= 0;
		victory <= 0;
		killingAlien <= 0;
		xAlien <= 10; //Valeur par défault 
		yAlien <= 5; //Valeur par défault
		alive <= -1; //On force tous les bits de alive à 1
		aliveColLeft <= 0;
		aliveColRight <= NB_COL -1;
		aliveLowLin <= NB_LIN - 1;
		canLeft <= 0;
		canRight <= 1;//On part du principe qu'au début on peut forcémet se déplacer à droite 
	end

// Dans un premier temps on déplace nos Aliens 

   if (~defeat) begin	
		case (motion)
			0: begin
				xAlien <= xAlien;
				yAlien <= yAlien;
			end
			1: xAlien <= xAlien - STEP_V_MOTION; 
			2: xAlien <= xAlien + STEP_V_MOTION; //CODE LEFT/RIGHT/DOWN A VERIFIER AVEC GROUPE ZigZagAlien !!!!
			3: yAlien <= yAlien + STEP_H_MOTION;
			default : begin 
				xAlien <= xAlien;
				yAlien <= yAlien;
			end
		endcase
	end
	
//Puis nous allons chercher à coder la mort d'un alien :

	if (~defeat) begin
	for (k=0 ; k < NB_LIN ; k = k+1) begin       // Commentaire sur la boucle ---->                                                     //On parcoure les différentes lignes
		if ( yLaser > yAlien + k*(ALIENS_HEIGHT + STEP_V) && yLaser < yAlien + ALIENS_HEIGHT + k*(ALIENS_HEIGHT + STEP_V)) begin      // On teste pour chaque ligne si le laser est dans cette ligne
			for (l=0 ; l < NB_COL ; l = l+1) begin                                                                                        // Si oui on parcour les différentes colones 
				if ((alive[l + k*NB_COL] == 1) && xLaser > xAlien + l*(ALIENS_WIDTH + STEP_H) && xLaser < xAlien + ALIENS_WIDTH + l*(ALIENS_WIDTH + STEP_H)) begin    // On teste pour chaque colone si le laser est dans celle-ci					                                                                                     // Si oui on test si l'alien correspondant à la ligne et a la colonne ou les laser ce trouve est encore vivant
					killingAlien <= 1;                                                                                                   // Si il est encore vivant killingAlien passe à 1 et on tue l'alien
					alive[l + k*NB_COL] <= 0;
				end
			end
		end
	end
	end
	
//On va maitenant s'occuper des sorties canRight et canLeft
//Pour cela on va chercher à determiner quel sont les colonnes aux extrémités (plus petite colonne et plus grande colonne encore en vie)
		
	if (~defeat) begin
		for (i = 0 ; i < NB_LIN ; i = i+1 ) begin
        testAliveLeft = testAliveLeft + alive[aliveColLeft + i*NB_COL];
		  testAliveRight = testAliveRight + alive[aliveColRight + i*NB_COL];
		end
	
	aliveColRight <= aliveColRight - (testAliveRight == 0); 
	aliveColLeft <= aliveColLeft + (testAliveLeft == 0);
	
	// Calcul victory
	
	victory <= (alive == 0);	
	end
	
//On s'occupe maintenant de calculer defeat pour cela on cherche à évaluer la position de la première rangée d'alien encore en vie
	
	for (j = 0 ; j < NB_COL ; j = j+1 ) begin
		testAliveLow <= testAliveLow +  alive[((aliveLowLin)*NB_COL +1) + j];
	end
	
	if (testAliveLow == 0) begin
		aliveLowLin <= aliveLowLin - 1;
	end
	
	if (yAlien + aliveLowLin*(STEP_V + ALIENS_HEIGHT) > SCREEN_HEIGHT - Y_SHIP) begin
		defeat <= 1; // CONDITION A VERIFIER!!!!
	end
	
// Calcul de canLeft & canRight

	if (xAlien + aliveColLeft*(STEP_H + ALIENS_WIDTH) > OFFSET_V + STEP_V_MOTION) begin // CONDITION A VERIFIER!!!!!
		canLeft <= 1;
	end
	else begin
		canLeft <= 0;
	end
	
	if (xAlien + aliveColRight*(STEP_H + ALIENS_WIDTH) < SCREEN_WIDTH - OFFSET_V - STEP_V_MOTION) begin // CONDITION A VERIFIER !!!!
		canRight <= 1;
	end
	else begin 
		canRight <= 0;
	end
	
end
	
endmodule
