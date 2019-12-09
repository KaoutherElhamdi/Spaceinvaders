`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:04 12/05/2019 
// Design Name: 
// Module Name:    alienscolor 
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
module AliensColor(
    hPos,
    yPos,
    xAlien,
    yAlien,
    alive,
    colorAlien
    );
parameter NB_COL=6;
parameter NB_LIN=4;

function integer Length(input integer x);
		for ( Length =0 ; x >0 ; Length = Length + 1) x = x >> 1 ;
endfunction
	// cette fonction permet de determiner le nombre de bits necessaire a sa presentation binaire ( page 46 du cours)


localparam Length_I =Length(NB_LIN);
localparam Length_J =Length(NB_COL);

input [9:0] hPos;
input [9:0] yPos;
input signed [9:0] xAlien;
input [9:0] yAlien;
input [NB_LIN*NB_COL - 1:0] alive;
output [2:0] colorAlien;

reg [Length_I:0] i;
reg [Length_J:0] j;

localparam ALIENS_WIDTH=20;
localparam ALIENS_HEIGHT=10;

localparam BACKGROUND=0;
localparam ALIENS0= 2;
localparam ALIENS1= 3;
localparam ALIENS2= 4;
localparam ALIENS3= 5;

parameter STEP_H = 20;
parameter STEP_V = 10;

reg [2:0] couleur;
// alive[NB_COL*i+j] && 
	always @(hPos or yPos or xAlien or yAlien or alive) begin
		couleur = BACKGROUND;
		for (i=0; i<NB_LIN;i=i+1) begin
			for (j=0; j<NB_COL; j=j+1) begin
				if ((alive[NB_COL*i+j]==1) && hPos>=(xAlien-(ALIENS_WIDTH)/2 + (ALIENS_WIDTH)*(2*j))&& hPos<=(xAlien+(ALIENS_WIDTH)/2 + (ALIENS_WIDTH)*(2*j))
				&& yPos>=(yAlien-(ALIENS_HEIGHT)/2 +(ALIENS_HEIGHT)*(2*i))&& yPos<=(yAlien +(ALIENS_HEIGHT)/2 +(ALIENS_HEIGHT)*(2*i)))
				begin
				
				 
// on evalue si on est sur un alien ou pas. Si toutes les conditions sont verifiees: present sur un alien alive, ou dans les dimensions predefinies,
//on peut changer la couleur, sinon on reste sur le background.
						//couleur = ALIENS0;
						
						case ((i*NB_COL + j)%4)
							0: couleur = ALIENS0;
							1: couleur = ALIENS1;
							2: couleur = ALIENS2;
							3: couleur = ALIENS3;
						endcase
				end
			end
		end
		end
	
assign colorAlien= couleur;
endmodule
