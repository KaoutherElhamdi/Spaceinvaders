`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:35:17 12/02/2019
// Design Name:   SpaceShip
// Module Name:   /export/homes/kelhamdi/Space_Invaders/SpaceShipTest.v
// Project Name:  Space_Invaders
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

module SpaceShipTest;

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
		vPos = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset=1;
		clk=1;
		right=1;
		#100;
      reset=0;

	end
	
	always #10 begin
		
		clk= ~clk ;
		
	end
	
	always #500 begin
	
		left = ~left; //chaque fois que l'horloge clk passe à 1, le spaceship se déplace de 20 à gauche
	
	end
   
	always #500	begin
	
		right = ~right ; //chaque fois que l'horloge clk passe à 1, le spaceship se déplace de 20 à droite
				    //comme nous avons initialisé "right" à 1, il n'y aura jamais de "right" et de "left" à 1 en même temps
	end
	

      
endmodule

