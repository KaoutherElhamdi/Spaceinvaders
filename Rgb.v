`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:40:29 10/23/2019 
// Design Name: 
// Module Name:    Rgb 
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
module Rgb(
    input [2:0] color,
    output [7:0] rgb
    );
	 
localparam BACKGROUND = 0;
localparam SPACESHIP = 1;
localparam ALIENS0 = 2;
localparam ALIENS1 = 3;
localparam ALIENS2 = 4;
localparam ALIENS3 = 5;
localparam LASER = 6;
localparam NONE = 7;


reg [7:0] rgb_prov; 

always @(color) begin
	case (color)
		BACKGROUND:rgb_prov=8'b1001101;//10011010; // bleu clair
		SPACESHIP:rgb_prov=8'b00110100; // vert
		ALIENS0:rgb_prov=8'b00011110; // vert clair
		ALIENS1:rgb_prov=8'b11010110; // rose
		ALIENS2:rgb_prov=8'b01010110; // bleu turquoiz
		ALIENS3:rgb_prov=8'b10000110; // mauve
		LASER:rgb_prov=8'b10000000; // rouge fonce  11000000 rouge
		NONE:rgb_prov=8'b00000000; // noir
		default:rgb_prov=8'b00000000; // noir
	endcase
end

assign rgb=rgb_prov;

endmodule
