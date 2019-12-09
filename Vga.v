`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:50:54 10/23/2019 
// Design Name: 
// Module Name:    Vga 
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
module Vga(
    input clk,
    input enable,
    input reset,
    output hSync,
    output vSync,
    output [9:0] hPos,
    output [9:0] vPos
    );
	 
	 reg [9:0] hPos_reg;
	 reg [9:0] vPos_reg;

	 
	localparam LARGEUR_ECRAN = 640;
	localparam LARGEUR_FP = 16;
	localparam LARGEUR_BP = 48;
	localparam LARGEUR_PW = 96;
	localparam LARGEUR_FP_V = 10;
	localparam LARGEUR_BP_V = 29;
	localparam LARGEUR_PW_V = 2;
	localparam HAUTEUR_ECRAN = 480;
	
	 always @ (posedge clk) begin
        if (reset)  
        begin
            hPos_reg <= 0;
            vPos_reg <= 0;
        end
        else if (enable)  
        begin
            if (hPos_reg == (LARGEUR_ECRAN + LARGEUR_FP + LARGEUR_BP + LARGEUR_PW-1))// end of line
					if (vPos_reg==HAUTEUR_ECRAN + LARGEUR_FP_V + LARGEUR_BP_V + LARGEUR_PW_V-1)begin
						vPos_reg <=0;
						hPos_reg <=0;
						end
            else begin
                hPos_reg <= 0;
                vPos_reg <= vPos_reg + 1;
            end
            else 
                hPos_reg <= hPos_reg + 1;

            
        end
    end

 
    assign hSync = ~((hPos_reg > (LARGEUR_ECRAN + LARGEUR_FP) ) & (hPos_reg <= (LARGEUR_ECRAN + LARGEUR_FP + LARGEUR_PW)));
    assign vSync = ~((vPos_reg > (HAUTEUR_ECRAN + LARGEUR_FP_V)) & (vPos_reg <= (HAUTEUR_ECRAN + LARGEUR_FP_V + LARGEUR_PW_V)));

    
    assign hPos = hPos_reg;
    assign vPos = vPos_reg;

endmodule
