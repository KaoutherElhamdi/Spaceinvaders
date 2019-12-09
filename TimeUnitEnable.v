`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:31 07/02/2018 
// Design Name: 
// Module Name:    timeUnit 
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
module TimeUnitEnable(
    input clk,
	 input reset,
	 input enable,
    output pulse
    );
	
	function integer Size(input integer in);
		for (Size =0 ; in >0 ; Size = Size + 1) in = in >> 1 ;
	endfunction


	parameter FREQ_CLK = 50000000 ;
	parameter FREQ_WANTED = 20000 ;
	
	localparam NB_TIC = FREQ_CLK/FREQ_WANTED ; // Division entiere
	localparam SIZE_CPT = Size(NB_TIC) ;
	
	reg[SIZE_CPT-1:0] cpt ; 
	
	always @(posedge clk) begin
		if (reset) cpt <= 0 ;
		else if (enable) begin 
			if (cpt == NB_TIC - 1) cpt <= 0 ;
			else cpt <= cpt + 1 ;
		end
	end
	
	assign pulse = enable && (cpt == NB_TIC - 1) ;
	
endmodule
