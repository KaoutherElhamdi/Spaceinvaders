`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:41:07 12/04/2019
// Design Name:   SpaceShip
// Module Name:   /export/homes/mfahes/Bureau/spaceinv/spaceTestcouleur.v
// Project Name:  spaceinv
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SpaceShip
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module spaceTestcouleur;

	// Inputs
	reg clk;
	reg reset;
	reg left;
	reg right;
	reg [9:0] hPos;
	reg [9:0] vPos;

	// Outputs
	wire [9:0] gunPosition;
	wire [2:0] color;

	// Instantiate the Unit Under Test (UUT)
	SpaceShip uut (
		.clk(clk), 
		.reset(reset), 
		.left(left), 
		.right(right), 
		.hPos(hPos), 
		.vPos(vPos), 
		.gunPosition(gunPosition), 
		.color(color)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		left = 0;
		right = 0;
		hPos = 0;
		vPos = 435;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
      reset=1;
		clk=1;
		#100;
      reset=0;
	end
	
	always #10 begin
		
		clk= ~clk ;
		
		end
	
	always #1 begin
	
		if (hPos >= 640) hPos = 0; //Une ligne
		else hPos = hPos+1;
	
	end
	
	always #640 begin
		
		if (vPos >= 480) vPos = 0; //chaque fois qu'une ligne est franchie, nous changeons de ligne
		else vPos = vPos + 5;
		
	end
      
endmodule

