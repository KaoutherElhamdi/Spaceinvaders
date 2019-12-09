`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:13:05 10/23/2019 
// Design Name: 
// Module Name:    SpaceShip 
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
module SpaceShip(
    input clk,
    input reset,
    input left,
    input right,
    input [9:0] hPos,
    input [9:0] vPos,
    output [9:0] gunPosition,
    output reg [2:0] color
    );
	 
	 parameter SCREEN_WIDTH = 640;
	 parameter SCREEN_HEIGHT = 480;
	 parameter SHIP_WIDTH = 60;
	 parameter SHIP_HEIGHT = 30;
	 parameter STEP = 20;
	 
	 // Color parameters
	 parameter NONE = 7;
	 parameter BACKGROUND = 0;
	 parameter SPACESHIP = 1;
	 parameter ALIENS0 = 2;
    parameter ALIENS1 = 3;
	 parameter ALIENS2 = 4;
	 parameter ALIENS3 = 5;
	 parameter LASER = 6;
	 
	 //Spaceship's shape
	 parameter RECT_PERCENT=15;
	 localparam RECT_WIDTH= SHIP_WIDTH*RECT_PERCENT/100;
	 parameter V_OFFSET= 10;
	 parameter H_OFFSET= 10;
	 
	 // left_limit : 10
	 // right_limit : screen_width -10 = 630
	 reg [9:0] positionreg = SCREEN_WIDTH/2;

	 always @(posedge clk) begin
		// Initialiser la position du spaceship au milieu de l'écran
		if(reset==1) begin
			positionreg <= SCREEN_WIDTH/2; end
		// Déplacement du spaceship	
		else begin
			// Si le mouvement sera à droite :
			// Premièrement : on vérifie s'il y a encore de l'espace pour se déplacer à droite 
			if(right && (positionreg < (SCREEN_WIDTH-SHIP_WIDTH/2-H_OFFSET))) begin
				//Deuxièmement : On vérifie si le marge restant est supérieur aux nombre de pas ( càd step ) qu'on va faire
				//Si oui :
				if(SCREEN_WIDTH-H_OFFSET-positionreg-SHIP_WIDTH/2> STEP)
					positionreg <= positionreg+ STEP;
				//Si non : on fait un mouvement égale au nombre du pas résidu
				else
				   positionreg <= SCREEN_WIDTH-H_OFFSET-SHIP_WIDTH/2;
			end
			
			
			// Si le mouvement sera à gauche :
			// Même démarche
			if(left && (positionreg > (H_OFFSET+SHIP_WIDTH/2))) begin
				if (positionreg - (H_OFFSET+SHIP_WIDTH/2) > STEP )
					positionreg <= positionreg- STEP;
				else
					positionreg <= H_OFFSET+SHIP_WIDTH/2;
			end
			
		end
		
	end
		
	always @(hPos or vPos or positionreg) begin
		// Initialiser tous les pixels comme Background
      color <= BACKGROUND;
		
		// Coloration des 2 rectangles
		if ( ((hPos  >= (positionreg - SHIP_WIDTH/2 )) && (hPos  <= (positionreg - SHIP_WIDTH/2 + (15*SHIP_WIDTH/100)))) || ((hPos >= (positionreg + SHIP_WIDTH/2 - (15*SHIP_WIDTH/100))) && (hPos <=  (positionreg + SHIP_WIDTH/2 )))) 
			if ((vPos >= (SCREEN_HEIGHT - SHIP_HEIGHT - V_OFFSET )) && (vPos <= (SCREEN_HEIGHT - V_OFFSET))) 
				color <= SPACESHIP;
		
		
		
		// Coloration du triangle
		if (vPos <= SCREEN_HEIGHT - V_OFFSET) begin
		if  (( hPos >= (positionreg - SHIP_WIDTH/2 + (15*SHIP_WIDTH/100))) && (hPos <= positionreg)) 
			if ((SCREEN_HEIGHT - vPos - V_OFFSET)<= ((2*SHIP_HEIGHT/SHIP_WIDTH)*(hPos - positionreg + SHIP_WIDTH/2)))
		
		    	color <= SPACESHIP;
				
		
		if ((hPos >= positionreg) && (hPos <= (positionreg + SHIP_WIDTH/2 - (15*SHIP_WIDTH/100))))
			if ((SCREEN_HEIGHT - vPos - V_OFFSET)<= ((2*SHIP_HEIGHT/SHIP_WIDTH)*(positionreg + SHIP_WIDTH/2-hPos))) 
				
				color <= SPACESHIP;
				
	
			end
	end
		
	assign gunPosition = positionreg;
	
				
endmodule
