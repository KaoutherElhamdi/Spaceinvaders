`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:49:50 10/23/2019 
// Design Name: 
// Module Name:    Laser 
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
module Laser(
    input clk,
    input reset,
    input enable,
    input fire,
    input killingAlien,
    input [9:0] gunPosition,
    input [9:0] hPos,
    input [9:0] vPos,
    output [9:0] xLaser,
    output [9:0] yLaser,
    output [2:0] colorLaser
    );

parameter BACKGROUND = 0; // Background color
parameter LASER = 6; // Laser color

parameter RADIUS = 4; 

parameter SCREEN_WIDTH = 640; 
parameter SCREEN_HEIGHT = 480; 

parameter SHIP_WIDTH = 60; // width of the ship
parameter SHIP_HEIGHT = 30; // height of the ship

parameter V_OFFSET = 10; // number of pixels between bottom of the screen and ship
parameter STEP_MOTION = 1; // number of pixels of vertical laser motion

localparam Y_START=((SCREEN_HEIGHT-1)-(SHIP_HEIGHT + V_OFFSET));
localparam Y_COLOR_REGION= (Y_START/2)/5 ;
//triangle
localparam HAUTEUR = 8;
localparam BASE = 8;


//ellipse
localparam GRAND_AXE = 8;
localparam PETIT_AXE = 2;


reg [9:0] y;
reg [9:0] x;
reg [2:0] colorout;
reg fireFlag; // to indicate if fire button is previously pressed




always @(posedge clk) begin
	if (reset==1) begin 
		fireFlag = 0;
		x=gunPosition;
		y=Y_START;
		end
		
	if (fire==1) fireFlag = 1;
	if (fireFlag == 0)  x=gunPosition;
	
	
	if ( enable == 1 && fireFlag == 1) begin
	
		if(killingAlien == 0 && y > 0 ) begin 
			y=y-STEP_MOTION;
		end	
		else begin
			y=Y_START;
			fireFlag = 0;
			x=gunPosition;
		end
		
	end
end

always @(posedge clk) begin
	// for multiple lazers
	//if ( ((hPos - x)*(hPos - x) + (vPos - y)*(vPos - y)) <= RADIUS*RADIUS  || ((hPos - (x - SHIP_WIDTH/2 ))*(hPos - (x - SHIP_WIDTH/2 )) + (vPos - y)*(vPos - y)) <= RADIUS*RADIUS || ((hPos - (x + SHIP_WIDTH/2 ))*(hPos - (x + SHIP_WIDTH/2 )) + (vPos - y)*(vPos - y)) <= RADIUS*RADIUS)
	
	// for triangle && ((hPos - x)<=0)
	//if ((((hPos - x)>= -BASE/2)  &&   (vPos - y) <= (HAUTEUR ) && (vPos - y) >= (-2*HAUTEUR/BASE)*(hPos - x)) ||  (((hPos - x)<= BASE/2) && ((hPos - x)>=0) &&   (vPos - y) <= (HAUTEUR) && (vPos - y) >= (2*HAUTEUR/BASE)*(hPos - x)))// (y + HAUTEUR)
	
	// for ellipse shape 
	// if (( ((hPos - x)*(hPos - x))/(PETIT_AXE* PETIT_AXE) + ((vPos - y)*(vPos - y))/(GRAND_AXE* GRAND_AXE)) <= y/32)
	  
	// three triangles shapes 
/*	if (((((hPos - x)>= -BASE/2)       &&   (vPos - y) <= ((-2*HAUTEUR/BASE)*(hPos - x) + 2 )  && (vPos - y) >= (-2*HAUTEUR/BASE)*(hPos - x))      ||  (((hPos - x)<= BASE/2)     && ((hPos - x)>=0)     &&   (vPos - y) <= ((2*HAUTEUR/BASE)*(hPos - x) + 2 )  && (vPos - y) >= (2*HAUTEUR/BASE)*(hPos - x))       ||   // (y + HAUTEUR) 
	      (((hPos - x)>= -(2*BASE/2))  &&   (vPos - y) <= ((-2*HAUTEUR/BASE)*(hPos - x) + 10 ) && (vPos - y) >= (-2*(HAUTEUR/BASE)*(hPos - x) + 8)) ||  (((hPos - x)<= (2*BASE/2)) && ((hPos - x)>=0)     &&   (vPos - y) <= ((2*HAUTEUR/BASE)*(hPos - x) + 10 ) && (vPos - y) >= (2*(HAUTEUR/BASE)*(hPos - x) + 8)) || 
	      (((hPos - x)>= -(4*BASE/2))  &&   (vPos - y) <= ((-2*HAUTEUR/BASE)*(hPos - x) + 16 ) && (vPos - y) >= (-2*HAUTEUR/BASE)*(hPos - x) + 14)) ||  (((hPos - x)<= (4*BASE/2)) && ((hPos - x)>=0)     &&   (vPos - y) <= ((2*HAUTEUR/BASE)*(hPos - x) + 16 ) && (vPos - y) >= (2*HAUTEUR/BASE)*(hPos - x) + 14)))
*/
//if ( (  (   ((hPos - x)>= -BASE/2)       &&   ((vPos - y) <= ( 10 )) && ((vPos - y) <= (( -2*HAUTEUR/BASE)*(hPos - x) + 2 ))  && ((vPos - y) >= (-2*HAUTEUR/BASE)*(hPos - x)))      ||  (((hPos - x)<= BASE/2)     && ((hPos - x)>=0)     &&   ((vPos - y) <= ((2*HAUTEUR/BASE)*(hPos - x) + 2 ))  && ((vPos - y) >= (2*HAUTEUR/BASE)*(hPos - x)) ) ) ||
//(   (   ((hPos - x)>= -BASE/2)       &&   ((vPos - y) <= ( 18 )) && ((vPos - y) <= (( -2*HAUTEUR/BASE)*(hPos - x) + 10 ))  && ((vPos - y) >= (-2*HAUTEUR/BASE)*(hPos - x) + 8 ))      ||  (((hPos - x)<= BASE/2)     && ((hPos - x)>=0)     &&   ((vPos - y) <= ((2*HAUTEUR/BASE)*(hPos - x) + 10 ))  && ((vPos - y) >= (2*HAUTEUR/BASE)*(hPos - x) + 8) ) ) )    
	      

	
	// for circle shape 
	if ( ((hPos - x)*(hPos - x) + (vPos - y)*(vPos - y)) <= RADIUS*RADIUS  )
		colorout= LASER;
/*		if( y < Y_START/2 )  colorout= LASER;
		else begin
			if( y <= (Y_START/2 + Y_COLOR_REGION))  colorout= LASER - 1;
			else if( y <= (Y_START/2 + 2*Y_COLOR_REGION) )  colorout= LASER - 2;
			else if( y <= (Y_START/2 + 3*Y_COLOR_REGION) )  colorout= LASER - 3;
			else if( y <= (Y_START/2 + 4*Y_COLOR_REGION) )  colorout= LASER - 4;
			else if( y <= (Y_START/2 + 5*Y_COLOR_REGION) )  colorout= LASER - 5;
	*/
	else 
		colorout= BACKGROUND;
		
end

assign colorLaser = colorout;
assign xLaser = x;

assign yLaser = y;



endmodule
