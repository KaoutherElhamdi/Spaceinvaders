`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:32 10/23/2019 
// Design Name: 
// Module Name:    FinalColor 
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
module FinalColor(
    input [2:0] colorInput,
    input [9:0] hPos,
    input [9:0] vPos,
    output[2:0] color
    );
parameter SCREEN_WIDTH=640;
parameter SCREEN_HEIGHT=480;
parameter NONE=7;

reg [2:0]color_prov;

always@(hPos,vPos) begin
	if ( hPos>SCREEN_WIDTH | vPos>SCREEN_HEIGHT ) color_prov=NONE; 
	else color_prov=colorInput;
end

assign color=color_prov;

endmodule
