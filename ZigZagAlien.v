`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:00:07 10/23/2019 
// Design Name: 
// Module Name:    ZigZagAlien 
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
 module ZigZagAlien(
    input clk,
    input reset,
    input enable,
    input canLeft,
    input canRight,
    output reg [2:0] motion
    );


	 localparam NO_MOTION = 0;
	 localparam LEFT = 1;
	 localparam RIGHT =2;
	 localparam DOWN = 3;
	 
	 //TimeUnitEnable#(.FREQ_WANTED(100)) tueZZA(.clk(clk), .reset(reset), .enable(1), .pulse(enable));

	 always @(posedge clk) begin
	   if (reset) motion <= RIGHT;
	   
	   
		else if(enable) begin
		
			case(motion) 
		
				NO_MOTION : if (canRight) motion <= RIGHT;
								//else if (canLeft) motion <= LEFT;
								//else if (~canRight & ~canLeft) motion <= DOWN;
								else motion <= DOWN;
				
				LEFT : if (canLeft) motion <= LEFT;
						 else if (~canLeft) motion <= DOWN;
						 else motion <= NO_MOTION;
				
				RIGHT : 	if (canRight) motion <= RIGHT;
							else if (~canRight) motion <= DOWN;
							else motion <= NO_MOTION;
				
				DOWN : 	if (canLeft) motion <= LEFT;
							else if (canRight) motion <= RIGHT;
							else motion <= NO_MOTION;
				
				default : motion <= NO_MOTION;
		  
			endcase
		end
			
	 end


endmodule

