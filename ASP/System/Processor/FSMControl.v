`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:32 08/09/2015 
// Design Name: 
// Module Name:    FSMControl 
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
// Sí se descomenta la línea `define TestFSMPlaceRoute lo que se hace es sacar la señal
// Estado, que se utiliza para monitoriar el estado de la máquina de estados, básicamente
// si se descomenta la descripción del hardware tendría una señal más que sería utilizada
// únicamente para verificación. Básicamente lo que se hace es sacar el puerto 
// output [4:0] estado; esa señal es igual a el estado de la máquina de estados
// assign estado = State; y me sirve para en simulaciones place and route y post translate 
// si deseo verificar el correcto funcionamiento, poder saber en que estado esta la máquina de
// de estados.
//////////////////////////////////////////////////////////////////////////////////

// Si no se pone nada, esta pensado para que sea la versión final, si sí se descomenta
// el define es para Test con monitor Place and Route



//`define TestFSMPlaceRoute


module FSMControl    
(CLK, Reset, Opcode, Funct7Bits0, ResetRegisterMicro, EnablePC, EnableInstRegister, WriteRegisterBank, 
TypeOperation, EnableRegisterAB, SELMUXRS2, SELMUXRS1,EnableSignLSBImmediate, EnableRegisterInALU, EnableALUOut, EnableRAM, WriteMeMRAM,SELMUXSignExtend,EnableRegisterBranch,PCWriteCond,SELMUXWriteDataBank,PCWrite,SELMUXWriteDataPC,ResetResultCompare); 
	  
	  
	  input CLK; // reloj de 50 MHZ
	  input Reset; // reset Maestro
	  input [6:0] Opcode; // Opcode of instruction
	  input Funct7Bits0; //Bit LSB del funct7 es decir bit número 25 de la palabra
	  

	  output reg ResetRegisterMicro = 0; // Se resetea todo lo del microprocesador
	  output reg EnablePC = 0;           // Enable del Program Counter
	  output reg EnableInstRegister = 0; // Enable del registro de instrucciones
	  output reg WriteRegisterBank = 0; // Señal para escribir en el banco de registros
	  output reg [2:0] TypeOperation = 0; // Señales que van a ALU COntrol
	  output reg EnableRegisterAB = 0; // Enable de registro A y B
	  output reg [2:0] SELMUXRS2 = 0;       // Enable de mux que selecciona si  RS2 de la ALU viene un imediato, o un shamt o un RS2 del banco de registros, o un immediato de un branch
	  output reg SELMUXRS1 = 0;  // Enable de mux que selecciona si  RS1 viene del PCActual o de RS1 del banco de registro
	  output reg EnableSignLSBImmediate = 0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
	  output reg EnableRegisterInALU = 0; // Enable de registros RS1 y RS2 de entrada en la ALU
	  output reg EnableALUOut = 0; // Enable de registro ALU Out
	  output reg EnableRAM = 0; // Enable de la memoria RAM, perimite leer y habilita escritura
	  output reg WriteMeMRAM = 0; // Habilita la escritura de la memoria RAM
	  output reg SELMUXSignExtend = 0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
	  output reg EnableRegisterBranch = 0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
	  output reg PCWriteCond = 0; //Escritura condiciona en instrucciones branch
	  output reg [1:0] SELMUXWriteDataBank = 0; // Selector del MUX que selecciona los datos que van hacia el Write Data
	  output reg PCWrite = 0; // PCWrite es para los saltos incondicionales
	  output reg SELMUXWriteDataPC = 0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
	  output reg ResetResultCompare = 0; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O

	  
     reg ResetContador = 0; // Reset del contador de espera de los load y store
	  reg EnableContador = 0; //Enable del contador de espera de los load y store
	  reg [3:0] Counter = 0; // COntador de los load y store
	  
	  
	  
	  
	  
		 
	  reg[4:0] State = 0;
	  reg [4:0] NextState = 0;
	  parameter RESETEAR=5'd0, InstructionFetch=5'd1,InstructionDecode=5'd2, InstructionWriteRegisterInALU = 5'd3, Execution=5'd4, R_I_TypeALUCompletion=5'd5, SeleccionLSBinmediato=5'd6,  
	  ExecuteAddEffectiveAddress=5'd7, MeMRead=5'd8, WaitMeMRead=5'd9, MeMReadCompletonStep=5'd10, MeMWrite=5'd11, WaitMeMWrite=5'd12, BranchSumaPC=5'd13,BranchComparaRS1RS2=5'd14,
	  BranchPCWrite=5'd15, BranchWaitForMEM=5'd16, InstructionLUI=5'd17, ExecuteAUIPC=5'd18,ExecuteJAL=5'd19,ExecuteJALPCMas4=5'd20,
	  ExecuteJALR=5'd21,ExecuteJALRPCMas4=5'd22;     

	  // Registro de estado *********************************************************
	  always @(posedge CLK) // or posedge reset)
		  begin
				if(Reset)
					 State<=RESETEAR;
				else
					 State<=NextState;
		  end

	 // Lógica combinacional de estado siguiente ************************************
	 always @*
		  begin
				case(State)
					 RESETEAR: begin  //***********ESTADO DE RESET DEL SISTEMA
						  if (Reset) NextState <= RESETEAR;
						  else NextState <= InstructionFetch;
					 end
					 InstructionFetch: begin  //***********BÚSQUEDA DE LA INSTRUCCIÓN
						  NextState <= InstructionDecode;  
					 end
					 InstructionDecode: begin   // ****************DECODIFICACIÓN DE LA INSTRUCCIÓN
						  if(Opcode == 7'b0010011 || Opcode == 7'b0000011 || Opcode == 7'b0100011 || Opcode == 7'b1100111) // Si es un operando de tipo aritmetico inmediato, load o store o JALR
								NextState <= SeleccionLSBinmediato;
						  else if (Opcode == 7'b0110111) // LUI
							   NextState <= InstructionLUI;
						  else
								NextState <= InstructionWriteRegisterInALU;
					 end
					 SeleccionLSBinmediato: begin  //*********** Selecciona para las instrucciones tipo I o S la parte menos significativa del inmediato
						  NextState <= InstructionWriteRegisterInALU;  
					 end
					 InstructionWriteRegisterInALU: begin   // Se almacena los operandos a la entrada de la ALU para aumentar el tiempo de propagación
						  if(Opcode == 7'b0110011 || Opcode == 7'b0010011) // Operaciones lógicas y aritméticas con y sin inmediatos
								NextState <= Execution;
						  else if (Opcode == 7'b0000011 || Opcode == 7'b0100011) // Operaciones Load and Store
								NextState <= ExecuteAddEffectiveAddress;
						  else if (Opcode == 7'b1100011)//Branch
								NextState <= BranchSumaPC;
						  else if (Opcode == 7'b0010111) //auipc
								NextState <= ExecuteAUIPC;
						  else if (Opcode == 7'b1101111) //JAL
								NextState <= ExecuteJAL;
						  else    //JALR
								NextState <= ExecuteJALR;
					 end
					 Execution: begin   // ****************EJECUCÍÓN DE LA INSTRUCCIÓN TIPO R Y I, ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, SLLI, SRLI, SRAI, ADDI, SLTI, SLTIU, XORI, ORI, ANDI. 
						  NextState <= R_I_TypeALUCompletion;
					 end
					 R_I_TypeALUCompletion: begin   // ****************WRITE IN REGISTER OPERATION TIPO R Y I, ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, SLLI, SRLI, SRAI, ADDI, SLTI, SLTIU, XORI, ORI, ANDI. 
						  NextState <= InstructionFetch;
					 end
					 ExecuteAddEffectiveAddress: begin   // Suma la dirección del registro RS1 y el inmediato para formar la dirección efectiva de load y store
						  if(Opcode == 7'b0000011)  // Load
								NextState <= MeMRead;
							else                     //Store
								NextState <= MeMWrite;
					 end
					 MeMRead: begin   // Envía la señal de que Lea la memoria para las instrucciones LD, LH, LB, LBU, LHU, LW, LWU
						  NextState <= WaitMeMRead;
					 end
					 WaitMeMRead: begin   // Se espera a que se realice la lectura de la memoria para las instrucciones LD, LH, LB, LBU, LHU, LW, LWU
						  if(Counter == 3'd6) NextState <= MeMReadCompletonStep; // Cuando ya paso el tiempo de escritura salta al MeMReadCompletonStep
						  else NextState <= WaitMeMRead; // Se queda esperando a que la memoria sea leída
					 end
					 MeMReadCompletonStep: begin   // Paso final de instrucciones LD, LH, LB, LBU, LHU, LW, LWU, se escribe en registro RD el contenido de memoria
						  NextState <= InstructionFetch;
					 end
					 MeMWrite: begin   // Se envia la orden de escriba la memoria SB, SH, SW, SD se almacena en memoria en dato que proviene del registro RS1
						  NextState <= WaitMeMWrite;
					 end
					 WaitMeMWrite: begin   // Se espera a que se realice la escritura SB, SH, SW, SD se almacena en memoria en dato que proviene del registro RS1
						  if(Counter == 3'd3) NextState <= InstructionFetch; // Cuando ya paso el tiempo de escritura salta al Fetch
						  else NextState <= WaitMeMWrite; // Se queda esperando a que la memoria sea escrita
					 end
					 BranchSumaPC: begin   //Suma immediato con el PC Actual en la ALU
						  NextState <= BranchComparaRS1RS2;
					 end
					 BranchComparaRS1RS2: begin   //Realiza la comparación en la ALU
						  NextState <= BranchPCWrite;
					 end
					 BranchPCWrite: begin   //Pone la señal del PCWriteCOnd en 1,
						  NextState <= BranchWaitForMEM;
					 end
					 BranchWaitForMEM: begin   // Espera un ciclo a que se actualice la memoria para un branch, finaliza la instrucción
						  NextState <= InstructionFetch;
					 end
					 InstructionLUI: begin   // Es solo para la isntrucción LUI se copia en Rd el UpperImmediate
						  NextState <= InstructionFetch;
					 end
					 ExecuteAUIPC: begin   // Suma el PC con el upper immediate
						  NextState <= R_I_TypeALUCompletion;  // Se salta a la última etapa de la instrucción R porque simplemente se almacena en el registro Rd
					 end
					 ExecuteJAL: begin   // Suma el PC Actual con el immediato para formar la nueva dirección efectiva
						  NextState <= ExecuteJALPCMas4;  
					 end
					 ExecuteJALPCMas4: begin   // Suma el PC Actual con 4 para almacenar esto en registro RD
						  NextState <= R_I_TypeALUCompletion;  
					 end
					 ExecuteJALR: begin   // Suma el registro RS1 con el immediato
						  NextState <= ExecuteJALRPCMas4;  
					 end
					 ExecuteJALRPCMas4: begin   // Suma el PC Actual con 4 para almacenar esto en registro RD
						  NextState <= R_I_TypeALUCompletion;  
					 end
					 default: begin  // ESTADO POR DEFECTO RESET
						  NextState <= RESETEAR;
					 end
				endcase
		  end

	 // ******************************+++ LOGICA DE SALIDA**********************************++++
	 always @*
		  begin
				case(State)
					 RESETEAR: begin  //***********ESTADO DE RESET DEL SISTEMA
						  ResetRegisterMicro <= 1'b1; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: IDLE
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 InstructionFetch: begin  //***********BÚSQUEDA DE LA INSTRUCCIÓN
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b1; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner en IDLE
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 InstructionDecode: begin   // ****************DECODIFICACIÓN DE LA INSTRUCCIÓN
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  if (Opcode == 7'b0110011) begin //Tipo R
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
								EnableRegisterAB <= 1'b1; // Enable de registro A y B;
								if (Funct7Bits0 == 1'b0) TypeOperation <= 3'd0; // Señales que van a ALU COntrol: tipo lógica aritmética.   Operación tipo R que no son las del estandar RV32M
								else TypeOperation <= 3'd4; // Operación tipo R de multiplicación MUL, DIV, REM
								SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						      EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  end else if (Opcode == 7'b0010011) begin //tipo I
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
								EnableRegisterAB <= 1'b0; // Enable de registro A y B;
								TypeOperation <= 3'd1; // Señales que van a ALU COntrol: tipo lógica aritmética inmediata
								SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
								EnableSignLSBImmediate <= 1'b1; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  end else if (Opcode == 7'b0000011) begin //Load 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
								EnableRegisterAB <= 1'b0; // Enable de registro A y B;
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma de operandos
								SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						      EnableSignLSBImmediate <= 1'b1; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  end else if (Opcode == 7'b0100011) begin  // Store
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
								EnableRegisterAB <= 1'b0; // Enable de registro A y B;
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma de operandos
								SELMUXSignExtend <= 1'b1; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						      EnableSignLSBImmediate <= 1'b1; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  end else if (Opcode == 7'b1100011) begin  // Branch 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd2; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU, Suma PC
								EnableRegisterAB <= 1'b1; // Enable de registro A y B;
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: Se deja en 2 porque primero hace la suma
								SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						      EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  end else if (Opcode == 7'b0110111) begin // LUI 
								EnablePC <= 1'b1;           // Enable del Program Counter
								SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU, Suma PC
								EnableRegisterAB <= 1'b0; // Enable de registro A y B;
								TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner en IDLE 
								SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						      EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  end else if (Opcode == 7'b0010111) begin  // AUIPC 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd3; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU, Suma PC
								EnableRegisterAB <= 1'b0; // Enable de registro A y B;
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: Suma
								SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						      EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  end else if (Opcode == 7'b1101111) begin  // JAL 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd4; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU, Suma PC
								EnableRegisterAB <= 1'b1; // Enable de registro A y B;
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: Suma
								SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						      EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  end else begin  // JALR 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU, Suma PC
								EnableRegisterAB <= 1'b1; // Enable de registro A y B;
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: Suma
								SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						      EnableSignLSBImmediate <= 1'b1; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  end
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 SeleccionLSBinmediato: begin  //*********** Selecciona para las instrucciones tipo I o S la parte menos significativa del inmediato
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableRegisterAB <= 1'b1; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  if (Opcode == 7'b0010011) begin //tipo I
								TypeOperation <= 3'd1; // Señales que van a ALU COntrol: tipo lógica aritmética inmediata
						  end else  begin// Load Store JALR
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma de operandos
						  end 
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 InstructionWriteRegisterInALU: begin   // Se almacena los operandos a la entrada de la ALU para aumentar el tiempo de propagación
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  if (Opcode == 7'b0110011) begin //Tipo R
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
								if (Funct7Bits0 == 1'b0) TypeOperation <= 3'd0; // Señales que van a ALU COntrol: tipo lógica aritmética.   Operación tipo R que no son las del estandar RV32M
								else TypeOperation <= 3'd4; // Operación tipo R de multiplicación MUL, DIV, REM
						  end else if (Opcode == 7'b0010011) begin //tipo I
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
								TypeOperation <= 3'd1; // Señales que van a ALU COntrol: tipo lógica aritmética inmediata
						  end else if (Opcode == 7'b0000011) begin //Load 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma de operandos
						  end else if (Opcode == 7'b0100011) begin  // Store
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma de operandos
						  end else if (Opcode == 7'b1100011) begin  // Branch 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd2; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU, Suma PC
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: Se deja en 2 porque primero hace la suma
						  end else if (Opcode == 7'b0010111) begin  // AUIPC 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd3; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU, Suma PC
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: Suma
						  end else if (Opcode == 7'b1101111) begin  // JAL 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd4; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU, Suma PC
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: Suma
						  end else begin  // JALR 
								EnablePC <= 1'b0;           // Enable del Program Counter
								SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
								SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU, Suma PC
								TypeOperation <= 3'd2; // Señales que van a ALU COntrol: Suma
						  end
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b1; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 Execution: begin   // ****************EJECUCÍÓN DE LA INSTRUCCIÓN TIPO R Y I, ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, SLLI, SRLI, SRAI, ADDI, SLTI, SLTIU, XORI, ORI, ANDI. 
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b1;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  if (Opcode == 7'b0110011) begin
								SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
								if (Funct7Bits0 == 1'b0) TypeOperation <= 3'd0; // Señales que van a ALU COntrol: tipo lógica aritmética.   Operación tipo R que no son las del estandar RV32M
								else TypeOperation <= 3'd4; // Operación tipo R de multiplicación MUL, DIV, REM
						  end else begin
								SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
								TypeOperation <= 3'd1; // Señales que van a ALU COntrol: tipo lógica aritmética inmediata
						  end
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableALUOut <= 1'b1; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 R_I_TypeALUCompletion: begin   // ****************WRITE IN REGISTER OPERATION TIPO R Y I, ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, SLLI, SRLI, SRAI, ADDI, SLTI, SLTIU, XORI, ORI, ANDI. 
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b1; // Señal para escribir en el banco de registros
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: IDLE
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out;
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 ExecuteAddEffectiveAddress: begin   // Suma la dirección del registro RS1 y el inmediato para formar la dirección efectiva de load y store
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b1;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd1; // Selector del MUX hacia RS2 de la ALU
						  TypeOperation <= 3'd2; // Señales que van a ALU COntrol: Suma
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableALUOut <= 1'b1; // Enable de registro ALU Out
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b0; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 MeMRead: begin    // Envía la señal de que Lea la memoria para las instrucciones LD, LH, LB, LBU, LHU, LW, LWU
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner en IDLE
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b1; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd1; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b0; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 WaitMeMRead: begin   // Se espera a que se realice la lectura de la memoria para las instrucciones LD, LH, LB, LBU, LHU, LW, LWU
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner en IDLE
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd1; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b0; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b1; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b0; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 MeMReadCompletonStep: begin   // Paso final de instrucciones LD, LH, LB, LBU, LHU, LW, LWU, se escribe en registro RD el contenido de memoria
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b1; // Señal para escribir en el banco de registros
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner en IDLE
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out;
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd1; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b0; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 MeMWrite: begin   // Se envia la orden de escriba la memoria SB, SH, SW, SD se almacena en memoria en dato que proviene del registro RS1
					 	  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador	
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner en IDLE
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out;
						  EnableRAM <= 1'b1; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b1; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b0; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 WaitMeMWrite: begin   // Se espera a que se realice la escritura SB, SH, SW, SD se almacena en memoria en dato que proviene del registro RS1
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador	
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner en IDLE
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out;
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b0; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b1; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b0; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 BranchSumaPC: begin   //Suma immediato con el PC Actual en la ALU
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU Selecciona registro RS2
						  TypeOperation <= 3'd3; // Señales que van a ALU COntrol:  COmparación
						  EnableRegisterInALU <= 1'b1; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableALUOut <= 1'b1; // Enable de registro ALU Out
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU Selecciona el registro RS2
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 BranchComparaRS1RS2: begin   //Realiza la comparación en la ALU
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU // Selecciona RS1
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU // Selecciona RS2
						  TypeOperation <= 3'd3; // Señales que van a ALU COntrol:  COmparación
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b1; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 BranchPCWrite: begin   //Pone la señal del PCWriteCOnd en 1,
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b1;           // Enable del Program Counter Para el branch se actualiza el PC hasta aca
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU // Selecciona RS1
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU // Selecciona RS2
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner IDLE
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b1; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 BranchWaitForMEM: begin   // Espera un ciclo a que se actualice la memoria para un branch, finaliza la instrucción
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU // Selecciona RS1
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU // Selecciona RS2
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner IDLE
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 InstructionLUI: begin   // Espera un ciclo a que se actualice la memoria para un branch, finaliza la instrucción
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b1; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU // Selecciona RS1
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU // Selecciona RS2
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner IDLE
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd2; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 ExecuteAUIPC: begin   // Suma el PC con el upper immediate
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b1;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd3; // Selector del MUX hacia RS2 de la ALU Selecciona el upper immediate
						  TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableALUOut <= 1'b1; // Enable de registro ALU Out
						  SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU Selecciona el PC
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 ExecuteJAL: begin   // Suma el PC Actual con el immediato para formar la nueva dirección efectiva
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd5; // Selector del MUX hacia RS2 de la ALU Selecciona el 2
						  TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma
						  EnableRegisterInALU <= 1'b1; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableALUOut <= 1'b1; // Enable de registro ALU Out
						  SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU Selecciona el PC
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data 
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 ExecuteJALPCMas4: begin   // Suma el PC Actual con 4 para almacenar esto en registro RD
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b1;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd5; // Selector del MUX hacia RS2 de la ALU Selecciona el upper immediate
						  TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableALUOut <= 1'b1; // Enable de registro ALU Out
						  SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU Selecciona el PC
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data  
						  PCWrite <= 1'b1; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					  ExecuteJALR: begin   // Suma el registro RS1 con el immediato
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd5; // Selector del MUX hacia RS2 de la ALU Selecciona el upper immediate
						  TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b1; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b1; // Enable de registro ALU Out
						  SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU Selecciona el PC
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data 
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales 
						  SELMUXWriteDataPC <= 1'b1; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR						  
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 ExecuteJALRPCMas4: begin   // Suma el PC Actual con 4 para almacenar esto en registro RD
						  ResetRegisterMicro <= 1'b0; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b1;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd5; // Selector del MUX hacia RS2 de la ALU Selecciona el 2
						  TypeOperation <= 3'd2; // Señales que van a ALU COntrol: suma
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b1; // Enable de registro ALU Out
						  SELMUXRS1  <= 1'd1; // Selector del MUX hacia RS1 de la ALU Selecciona el PC
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data  
						  PCWrite <= 1'b1; // PCWrite es para los saltos incondicionales 
						  SELMUXWriteDataPC <= 1'b1; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
					 default: begin  // ESTADO POR DEFECTO RESET
						  ResetRegisterMicro <= 1'b1; // Se resetea todo lo del microprocesador
						  EnablePC <= 1'b0;           // Enable del Program Counter
						  EnableInstRegister <= 1'b0; // Enable del registro de instrucciones
						  WriteRegisterBank <= 1'b0; // Señal para escribir en el banco de registros
						  TypeOperation <= 3'd7; // Señales que van a ALU COntrol: Poner en IDLE
						  EnableSignLSBImmediate <= 1'b0; // Enable del registro de 5 bits que almacena ya sea el inmediato [24:20] o [11:7]
						  EnableRegisterAB <= 1'b0; // Enable de registro A y B;
						  SELMUXRS2  <= 3'd0; // Selector del MUX hacia RS2 de la ALU
						  SELMUXRS1  <= 1'd0; // Selector del MUX hacia RS1 de la ALU
						  EnableRegisterInALU <= 1'b0; // Enable de registros RS1 y RS2 de entrada en la ALU
						  EnableALUOut <= 1'b0; // Enable de registro ALU Out
						  EnableRAM <= 1'b0; // Enable de la memoria RAM, perimite leer y habilita escritura
						  WriteMeMRAM <= 1'b0; // Habilita la escritura de la memoria RAM
						  SELMUXSignExtend <= 1'b0; // Selecciona si el inmediato es de los bits [31:20] o {[31:25],[11:7]}, con un 0 es igual a [31:20]
						  EnableRegisterBranch <= 1'b0; //Enable de registro de escritura de 1 bit que almacena el resultado de la comparación, instrucciones Branch
						  PCWriteCond <= 1'b0; //Escritura condiciona en instrucciones branch
						  SELMUXWriteDataBank <= 2'd0; // Selector del MUX que selecciona los datos que van hacia el Write Data
						  PCWrite <= 1'b0; // PCWrite es para los saltos incondicionales
						  SELMUXWriteDataPC <= 1'b0; // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
					     ResetContador <= 1'b1; // Reset del contador de espera de los load y store
	                 EnableContador <= 1'b0; //Enable del contador de espera de los load y store
					     ResetResultCompare <= 1'b1; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
					 end
				endcase
		  end
		  
		  
		  
		//****************Contador para Load y Store
		always @(posedge CLK) begin
			if (ResetContador)
				Counter <= 3'd0;
			else if (EnableContador)
					Counter <= Counter + 1'b1;
		end



endmodule





