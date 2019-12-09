`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:26:22 10/23/2019 
// Design Name: 
// Module Name:    SpaceInvadersFinal 
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
module SpaceInvadersFinal(
    input clk,
    input reset,
    input fire,
    input left,
    input right,
    output [7:0] rgb,
    output victory,
    output defeat,
    output hSync,
    output vSync
    );
	 
	 parameter NB_COL=6;
	 parameter NB_LIN=4;
	 
	 wire enableVGA ;
	 wire enableZZA ;
	 wire enableLaser ;
	 TimeUnitEnable#(.FREQ_WANTED(25000000)) tueVGA(.clk(clk), .reset(reset), .enable(1), .pulse(enableVGA));
	 TimeUnitEnable#(.FREQ_WANTED(15)) tueZZA(.clk(clk), .reset(reset), .enable(1), .pulse(enableZZA));
	 TimeUnitEnable#(.FREQ_WANTED(400)) tueLaser(.clk(clk), .reset(reset), .enable(1), .pulse(enableLaser));
	 
	 wire leftWire;
	 wire rightWire;
	 Bouton LeftModule(.clk(clk), .reset(reset), .pressed(left),.pulse(leftWire));
    Bouton RightModule(.clk(clk), .reset(reset), .pressed(right),.pulse(rightWire));
	
	 wire [9:0] hPos;
	 wire [9:0] vPos;
	 Vga vga(.clk(clk),.enable(enableVGA), .reset(reset), .hSync(hSync), .vSync(vSync), .hPos(hPos), .vPos(vPos));
	 
	 wire [2:0] color;
	 Rgb rgb1(.color(color), .rgb(rgb));
	 
	 wire [9:0] gunPosition;
	 wire [2:0] colorSpaceShip;
	 SpaceShip spaceShip(.clk(clk), .reset(reset), .left(leftWire), .right(rightWire), .hPos(hPos), .vPos(vPos), .gunPosition(gunPosition), .color(colorSpaceShip));
	 
	 wire [9:0] xLaser;
	 wire [9:0] yLaser;
	 wire [2:0] motion;
	 wire killingAlien;
	 wire canLeft;
	 wire canRight;
	 wire [9:0] xAlien;
	 wire [9:0] yAlien;
	 wire [NB_COL*NB_LIN-1:0] alive;
	 AliensMotion aliensMotion(.clk(clk),.reset(reset),.xLaser(xLaser),.yLaser(yLaser),.motion(motion),.killingAlien(killingAlien),.canLeft(canLeft),.canRight(canRight),.xAlien(xAlien),.yAlien(yAlien),.alive(alive),.victory(victory),.defeat(defeat));
	 
	 wire [2:0] colorAlien;
	 AliensColor  aliensColor(.hPos(hPos),.yPos(vPos),.xAlien(xAlien),.yAlien(yAlien),.alive(alive),.colorAlien(colorAlien));
	 
	 ZigZagAlien zigZagAlien(.clk(clk),.reset(reset),.enable(enableZZA),.canLeft(canLeft),.canRight(canRight),.motion(motion));
	 
	 wire [2:0] colorLaser;
	 Laser laser(.clk(clk),.reset(reset),.enable(enableLaser),.fire(fire),.killingAlien(killingAlien),.gunPosition(gunPosition),.hPos(hPos),.vPos(vPos),.xLaser(xLaser),.yLaser(yLaser),.colorLaser(colorLaser));
	 
	 wire [2:0] colorInput;
	 assign colorInput = colorLaser + colorAlien + colorSpaceShip;
	 FinalColor finalColor(.colorInput(colorInput),.hPos(hPos),.vPos(vPos),.color(color));
	 

endmodule
