`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:05:05 08/07/2015 
// Design Name: 
// Module Name:    ALUControl 
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


module ALUControl  #(parameter ExtensionI = 0)(funct3,funct7,Class,SELOperation);

	input [2:0] funct3;
	input  funct7;  // Bit 6 del funct7 es decir, funct[5]
	input [2:0] Class;
	output reg [4:0] SELOperation = 0;
	
	
	// Clase = 0:
	//            Tipo R = Add, Sub, Sll, Slt, Sltu, Xor, Srl, Sra, Or, And.

	
	// Clase = 1:
	//            Tipo I = Addi, Slti, Sltiu, Xori, Ori, Andi
	//            Tipo I = Slli, Srli, Srai 

	// Clase = 2:
	//            Tipo I = LB, LH, LW, LBU
	//            Tipo S = SB, SH, SW 	
	
	// Clase = 3:
	//            Tipo SB = BEQ, BNE, BGE, BGEU, BLT, BLTU
	
	// Clase = 4;
	//            Tipo RV32M MUL, MULH, MULHSU, MULHU, DIV,  DIVU, REM, REMU
	// Clase = 7:
	//            IDLE
	
	
	generate
		 if (ExtensionI == 0) begin // Sin estándar RV32M
		 

			 always @* begin
				case (Class)
					3'b000: SELOperation <= {1'b0,funct7,funct3}; // Clase = 0
					3'b001: begin                                 // Clase = 1
						if(funct3==3'b101) 
							SELOperation <= {1'b0,funct7,funct3};
						else
							SELOperation <= {1'b0,1'b0,funct3};
					end
					3'b010: SELOperation <= 5'b00000; // Clase = 2;
					3'b011: begin                     // Clase = 3;
						if(funct3[2:1]==2'b00)
							SELOperation <= 5'b01100; //  BEQ or BNE
						else
							SELOperation <= {3'b000,funct3[2:1]}; //  BLTU BGE BLTU BGEU
						end
					default : SELOperation <= 5'b10000;  // IDLE es un 16
				endcase
			end			 
			
		 end else begin // Con estándar M

			
			 always @* begin
				case (Class)
					3'b000: SELOperation <= {1'b0,funct7,funct3}; // Clase = 0
					3'b001: begin                                 // Clase = 1
						if(funct3==3'b101) 
							SELOperation <= {1'b0,funct7,funct3};
						else
							SELOperation <= {1'b0,1'b0,funct3};
					end
					3'b010: SELOperation <= 5'b00000; // Clase = 2;
					3'b011: begin                     // Clase = 3;
						if(funct3[2:1]==2'b00)
							SELOperation <= 5'b01100; //  BEQ or BNE
						else
							SELOperation <= {3'b000,funct3[2:1]}; //  BLTU BGE BLTU BGEU
						end
					3'b100: SELOperation <= {2'b11,funct3}; //  Clase = 4  MUL, MULH, MULHSU, MULHU, DIV, DIVU, REM, REMU
					default : SELOperation <= 5'b10000;  // IDLE es un 16
				endcase
			end
	 
		 end
	endgenerate
			 
		 
		 

	
	
	
	
	
	
	
		
	
	
endmodule
