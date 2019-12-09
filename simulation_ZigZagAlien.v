`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:23:30 10/23/2019
// Design Name:   ZigZagAlien
// Module Name:   /export/homes/tgoessel/ISE/SpaceInvaders/simulation_ZZA.v
// Project Name:  ZigZagAlien
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ZigZagAlien
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module simulation_ZigZagAlien;

	// Inputs
	reg clk;
	reg reset;
	reg enable;
	reg canLeft;
	reg canRight;

	// Outputs
	wire [2:0] motion;

	// Instantiate the Unit Under Test (UUT)
	ZigZagAlien uut (
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.canLeft(canLeft), 
		.canRight(canRight), 
		.motion(motion)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		enable = 0;
		canLeft = 0;
		canRight = 0;

		// Wait 400 ns for global reset to finish
		#400;
		reset = 0;
		enable = 1;
		end
        
		// Add stimulus here
		always #100 begin 
		  clk = ~clk ;
		end
 
      always #80 begin
		  canLeft = ~canLeft;
		end
		
		always #70 begin
		  canRight = ~canRight;
		end
	
      
endmodule

