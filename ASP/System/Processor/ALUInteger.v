`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:36 07/30/2015 
// Design Name: 
// Module Name:    ALUInteger 
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
// ExtensionI = 1 implica estándar RV32M completo
// ExtensionI = 2 Solo multiplicaciones del estándar RV32M 
// ExtensionI = 0 Sin estándar multiplicación
//////////////////////////////////////////////////////////////////////////////////
module ALUInteger #(parameter Width = 32, ExtensionI = 0) (RS1,RS2,SEL,RD);
	
	input [Width-1:0] RS1,RS2;
	input [4:0] SEL;
	
	output  [Width-1:0] RD;
	

	generate
		 if (ExtensionI == 1) begin // Incorpora operaciones estándar M
		 
		 
			 parameter ADD=5'd0, SLL=5'd1, SLT=5'd2, SLTU=5'd3, XOR=5'd4, SRL=5'd5, OR=5'd6, AND=5'd7, SUB=5'd8, SRA=5'd13, BEQ=5'd12, //BLT=5'd14, BLTU=5'd15,
			 IDLE=5'd16, MUL=5'd24, 
			  MULH=5'd25, MULHSU=5'd26, MULHU=5'd27,  DIV=5'd28, DIVU=5'd29, REM=5'd30, REMU=5'd31;
			 reg [2*Width-1:0] Aux = 0;
			 always @* begin
						case(SEL)
							 ADD: begin  
								 Aux[Width-1:0] <= RS1+RS2;
								 Aux[2*Width-1:Width] <= 0;
							 end
							 SLL: begin  
								 Aux[Width-1:0] <= RS1 << RS2[4:0]; 
								 Aux[2*Width-1:Width] <= 0;
							 end
							 SLT: begin  
								 if($signed(RS1)<$signed(RS2)) Aux <= 1;
								 else Aux <= 0;
							 end
							 SLTU: begin  
								 if(RS1<RS2) Aux <= 1;
								 else Aux <= 0;
							 end
							 XOR: begin  
								 Aux[Width-1:0] <= RS1 ^ RS2;
								 Aux[2*Width-1:Width] <= 0;						 
							 end
							 SRL: begin  
								 Aux[Width-1:0] <= RS1 >> RS2[4:0]; 
								 Aux[2*Width-1:Width] <= 0;
							 end
							 OR: begin  
								 Aux[Width-1:0] <= RS1 | RS2;
								 Aux[2*Width-1:Width] <= 0;
							 end
							 AND: begin  
								 Aux[Width-1:0] <= RS1 & RS2; 
								 Aux[2*Width-1:Width] <= 0;
							 end
							 SUB: begin  
								 Aux[Width-1:0] <= RS1-RS2;
								 Aux[2*Width-1:Width] <= 0;
							 end
							 SRA: begin  
								 Aux[Width-1:0] <= RS1 >>> RS2[4:0];
								 Aux[2*Width-1:Width] <= 0;						 
							 end
							 BEQ: begin  
								 if(RS1==RS2) Aux <= 1;
								 else Aux <= 0;
							 end
							 IDLE: begin  
								 Aux <= 0;  
							 end
							 MUL: begin  
								 Aux <= $signed(RS1)*$signed(RS2); 
							 end
							 MULH: begin  
								 Aux <= $signed(RS1)*$signed(RS2); 
							 end
							 MULHSU: begin  
								 Aux <= $signed(RS1)*RS2; 
							 end
							 MULHU: begin  
								 Aux <= RS1*RS2; 
							 end
							 DIV: begin  
								 Aux[Width-1:0] <= $signed(RS1)/$signed(RS2); 
								 Aux[2*Width-1:Width] <= 0;
							 end
							 DIVU: begin  
								 Aux[Width-1:0] <= RS1/RS2; 
								 Aux[2*Width-1:Width] <= 0;
							 end
							 REM: begin  
								 Aux[Width-1:0] <= $signed(RS1)%$signed(RS2); 
								 Aux[2*Width-1:Width] <= 0;
							 end
							 REMU: begin  
								 Aux[Width-1:0] <= RS1%RS2;
								 Aux[2*Width-1:Width] <= 0;
							 end
							 default: begin  // ESTADO POR DEFECTO RESET
								 Aux <= 0;
							 end
						endcase
				  end
				  
				assign RD = (SEL==MULH | SEL==MULHU | SEL==MULHSU) ? Aux[2*Width-1:Width] : Aux[Width-1:0];
	
	
	
		 end else if (ExtensionI == 2) begin  // Estándar RV32M solo multiplicación
			
		 
			 parameter ADD=5'd0, SLL=5'd1, SLT=5'd2, SLTU=5'd3, XOR=5'd4, SRL=5'd5, OR=5'd6, AND=5'd7, SUB=5'd8, SRA=5'd13, BEQ=5'd12, //BLT=5'd14, BLTU=5'd15,
			 IDLE=5'd16, MUL=5'd24, 
			  MULH=5'd25, MULHSU=5'd26, MULHU=5'd27; 
			 reg [2*Width-1:0] Aux = 0;
			 always @* begin
						case(SEL)
							 ADD: begin  
								 Aux[Width-1:0] <= RS1+RS2;
								 Aux[2*Width-1:Width] <= 0;
							 end
							 SLL: begin  
								 Aux[Width-1:0] <= RS1 << RS2[4:0]; 
								 Aux[2*Width-1:Width] <= 0;
							 end
							 SLT: begin  
								 if($signed(RS1)<$signed(RS2)) Aux <= 1;
								 else Aux <= 0;
							 end
							 SLTU: begin  
								 if(RS1<RS2) Aux <= 1;
								 else Aux <= 0;
							 end
							 XOR: begin  
								 Aux[Width-1:0] <= RS1 ^ RS2;
								 Aux[2*Width-1:Width] <= 0;
							 end
							 SRL: begin  
								 Aux[Width-1:0] <= RS1 >> RS2[4:0]; 
								 Aux[2*Width-1:Width] <= 0;
							 end
							 OR: begin  
								 Aux[Width-1:0] <= RS1 | RS2;
								 Aux[2*Width-1:Width] <= 0;
							 end
							 AND: begin  
								 Aux[Width-1:0] <= RS1 & RS2; 
								 Aux[2*Width-1:Width] <= 0;
							 end
							 SUB: begin  
								 Aux[Width-1:0] <= RS1-RS2;
								 Aux[2*Width-1:Width] <= 0;
							 end
							 SRA: begin  
								 Aux[Width-1:0] <= RS1 >>> RS2[4:0];
								 Aux[2*Width-1:Width] <= 0;
							 end
							 BEQ: begin  
								 if(RS1==RS2) Aux <= 1;
								 else Aux <= 0;
							 end
							 IDLE: begin  //*********** IDLE  //16
								 Aux <= 0;  
							 end
							 MUL: begin  
								 Aux <= $signed(RS1)*$signed(RS2); 
							 end
							 MULH: begin  
								 Aux <= $signed(RS1)*$signed(RS2); 
							 end
							 MULHSU: begin  
								 Aux <= $signed(RS1)*RS2; 
							 end
							 MULHU: begin  
								 Aux <= RS1*RS2; 
							 end 
							 default: begin  // ESTADO POR DEFECTO RESET
								 Aux <= 0;
							 end
						endcase
				  end
				  
				assign RD = (SEL==MULH | SEL==MULHU | SEL==MULHSU) ? Aux[2*Width-1:Width] : Aux[Width-1:0];
				
			
		 
		 end else  begin  // Sin multiplicación división y residuo
		 
		 
		 
			 parameter ADD=5'd0, SLL=5'd1, SLT=5'd2, SLTU=5'd3, XOR=5'd4, SRL=5'd5, OR=5'd6, AND=5'd7, SUB=5'd8, SRA=5'd13, BEQ=5'd12, //BLT=5'd14, BLTU=5'd15,
			 IDLE=5'd16; 
			 reg [Width-1:0] Aux = 0;
			 always @* begin
						case(SEL)
							 ADD: begin  
								 Aux <= RS1+RS2;
							 end
							 SLL: begin  
								 Aux <= RS1 << RS2[4:0]; 
							 end
							 SLT: begin  
								 if($signed(RS1)<$signed(RS2)) Aux <= 1;
								 else Aux <= 0;
							 end
							 SLTU: begin  
								 if(RS1<RS2) Aux <= 1;
								 else Aux <= 0;
							 end
							 XOR: begin  
								 Aux <= RS1 ^ RS2;
							 end
							 SRL: begin  
								 Aux <= RS1 >> RS2[4:0]; 
							 end
							 OR: begin  
								 Aux <= RS1 | RS2;
							 end
							 AND: begin  
								 Aux <= RS1 & RS2; 
							 end
							 SUB: begin  
								 Aux <= RS1-RS2;
							 end
							 SRA: begin  
								 Aux <= RS1 >>> RS2[4:0];
							 end
							 BEQ: begin  
								 if(RS1==RS2) Aux <= 1;
								 else Aux <= 0;
							 end
							 IDLE: begin  
								 Aux <= 0;  
							 end 
							 default: begin  // ESTADO POR DEFECTO RESET
								 Aux <= 0;
							 end
						endcase
				  end
				  
				assign RD = Aux;
						 
						 
						 
		 end
	 endgenerate 
		
endmodule



