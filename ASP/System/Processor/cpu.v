`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:45 08/10/2015 
// Design Name: 
// Module Name:    cpu 
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
//  #(parameter WidthData = 32, WidhtAddress = 32, WidthInstruction = 32, `ROM_ADDR_BITS = 8, ROM_WIDTH = 8, `BEGIN_ADDR_ROM_PROGRAM = 0, `END_ADDR_ROM_PROGRAM= 181, `ProgramStartAddressPC = 32'b0, `ROM_ADDR_START_BITS = 0, `RAM_ADDR_BITS = 7, RAM_WIDTH = 8, RAM_ADDR_START_BITS = 0, Extension = 1)
//#(parameter WidthData = 32, WidhtAddress = 32, WidthInstruction = 32, `StackPointer = 32'h00008000, `ROM_ADDR_BITS = 13, ROM_WIDTH = 8, `BEGIN_ADDR_ROM_PROGRAM = 32'h00008000, `END_ADDR_ROM_PROGRAM= 32'h00009FFF, `ProgramStartAddressPC = 32'h000080A4, `ROM_ADDR_START_BITS = 15, `RAM_ADDR_BITS = 16, RAM_WIDTH = 8, RAM_ADDR_START_BITS = 10, InicializarRAM = 0, DIRInicioInicializarRAM = 32'h00000400, DIRFinInicializarRAM = 32'h00002D98, ExtensionI = 1, ExtensionF = 0)
//#(parameter WidthData = 32, WidhtAddress = 32, WidthInstruction = 32, `StackPointer = 32'h00008000, `ROM_ADDR_BITS = 11, ROM_WIDTH = 8, `BEGIN_ADDR_ROM_PROGRAM = 32'h00008000, `END_ADDR_ROM_PROGRAM= 32'h000087FF, `ProgramStartAddressPC = 32'h0000809E, `ROM_ADDR_START_BITS = 15, `RAM_ADDR_BITS = 16, RAM_WIDTH = 8, RAM_ADDR_START_BITS = 10, InicializarRAM = 0, DIRInicioInicializarRAM = 32'h00000400, DIRFinInicializarRAM = 32'h00002D98, ExtensionI = 1, ExtensionF = 0)
//////////////////////////////////////////////////////////////////////////////

 
 

module cpu #(parameter WidthData = 32, WidhtAddress = 32, WidthInstruction = 32, ROM_WIDTH = 8, RAM_WIDTH = 8, RAM_ADDR_START_BITS = 10, InicializarRAM = 0, DIRInicioInicializarRAM = 32'h00000400, DIRFinInicializarRAM = 32'h00002D98, ExtensionI = 1, ExtensionF = 0)
	( CLK, Reset, DataInputTowardMicro, AddressOutIO,DataOutputTowardIO,WritePPI, SalidaDePrueba);
	
	`include "ROMmemoryparam.vh" 
	`include "RAMmemoryparam.vh"

	//******************************************* Declaración de puertos de entrada y salida hacia dispositivos de entrada y salida
	output [8:0] AddressOutIO; // Es el bus de direcciones de la memoria RAM, va hacia los PPI, solo son 9 bits porque los PPI solo requieren 9 bits ya que están mapeados de 0 a 511
	output [WidthData-1:0] DataOutputTowardIO; // Son los datos que se espera escribir en el PPI
	output WritePPI; // Es el write de la máquina de estados índica que se va a realizar una escritura
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	output wire [31:0] SalidaDePrueba;//Salida de prueba
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	input CLK, Reset;
	input [WidthData-1:0] DataInputTowardMicro;  // Datos de 32 bits que provienen del PPI y se van a almacenar en un registro, es cuando se hace una instrucción load cuando la dirección es menor a 512, es decir se esta leyendo un PPI
	wire EnablePC, ResetMicro, EnableInstRegister, WriteRegisterBank, EnableRegisterAB,
	EnableALUOut,EnableRAM, WriteMeMRAM,SELMUXSignExtend;
	
	wire [WidhtAddress-1:0] AddressPCMeMROM;
	
	wire [WidthData-1:0] ReadData1, ReadData2, DataA, DataB, DataALUOut, DataALUOptRegister;
	
	wire [WidthInstruction-1:0] Instruction, InstructionRegisterOutput;
	 
	wire [4:0] SELALU; // Seleccionador ALU
	wire [2:0] TypeOperation;  // Seleccionador del COntrol a ALUCOntrol
	
	wire [WidthData-1:0]  SignExtentedimm, SignExtentedimmOutRegister, RS1ALU; // Extensión de signo de los 12 bits de inmediato, el shamt de slli, srli, srai, se le extiende el signo igual, ya que eso no afecta la operación normal
	reg [WidthData-1:0] RS2ALU = 0; // Registro RS2 de la ALU, es la salida del MUX de los bits que van a la ALU
	wire [2:0] SELMUXRS2InALU;  // Seleccionar del MUX  para RS2, entra a la ALU
	wire SELMUXRS1; // Selector del MUX RS1, que va hacia los datos que entran a la ALU
	wire SELMUXRS1InALU; // Seleccionar del MUX para RS1, entra a la ALU
	
	wire [64-1:0] DataOutputRAM; // Salida de la Memoria RAM
	
	wire [WidthData-1:0] DataRAMSignOrZeroExtension; // Salida del módulo que realiza la extensión de signo o extensión de zero al dato de salida de la RAM, Instrucción LOAD
	reg [WidthData-1:0] WriteDataBankRegister = 0; // Write Data banco de registros
	wire [4:0] immLSB; //Inmediato la parte LSB
	wire [WidthData-1:0] SignExtendedIMMBRanch; // Inmediato de la extensión de signo de los branch
	wire [WidthData-1:0] OutputRegSignExtendedIMMBRanch; // Inmediato de la estensión de signo de los branch, salida registro
	wire FlagBranch;  // Bandera de 1 bit que sale de la ALU, si es un BEQ,BLT o BLTU si es true es un 1 si es false 0
	wire EnableRegisterBranch, FlagBranchOutputMUX; // Enable Register Branch de un 1 bit ,, Salida del MUX es la bandera de los Branch
	wire PCWriteCond, PCWriteBranch, PCWrite, EnableLoadPC; // PC Write para saltos condicionales FSM, PCWriteBranch salida de la AND entre PCWriteCond y el flag de branch
	wire [1:0] SELMUXWriteDataBank; // Selector del MUX que selecciona los datos que van hacia el Write Data
	wire [WidthData-1:0] UpperImmediate,OutputRegUpperImmediate; // Upper immediate que utiliza la instrucción LUI y la instrucción AUIPC, OutputRegUpperImmediate Es la salida del registro
	wire [WidthData-1:0] InmediateJAL, OutputRegInmediateJAL;  // inmediato para la instrucción JAL, y OutputRegInmediateJAL la salida del registro
	wire [WidthData-1:0] LoadDataPC; // Salida del mux que va hacia el LoadDataPC
	wire SELMUXWriteDataPC; // // Selector del mux que multiplexa los datos que van hacia el CPU, siempre es 0 excepto para la instrucción JALR
	wire SELFlagMULOperation; // Bit 25 del Instruction Register almacenado en registro Para las instrucciones MUL, MULH, DIV, ...                
	wire [WidthData-1:0] AddressEfectiveRAM; // Variable que va hacia el módulo InterfazMemoriaRAM es la salida de la ALU dividida entre 2, esto para que la RAM siga el mismo enfoque de las direcciones de 2 en 2 en lugar de 4 en 4, similar a la memoria de programa

	wire funct7Bit5Reg; // Registro que almacena el funct7 específicamente bit 5, Intruction[30] en un registro
	wire [2:0] Funct3Reg; // Registro que almacena el funct3 en un registro, va hacia la ALU COntrol
   wire [WidthData-1:0] RS1ALUREG1, RS2ALUREG2; // Cables que van hacia la ALU, son la salida de los registros de entrada de la ALU
	wire EnableSignLSBImmediate, EnableRegisterInALU; // Enables de los 2 registros de entrada de la ALU y del registro de selección del inmediato [24:20] o [11:7]
	wire [4:0] immLSBReg; // Salida de registro que almacena el valor inmediato que son 5 bits
	wire [4:0] SELALUREG; // Registro del tipo de operación, colabora a que la ruta combinacional no sea tan larga. Es la salida del registro que va hacia el seleccionador de la ALU 
	wire SELFlagBranchh;
	
	wire [31:0] DatosSalidaMicro;  // Variable de 32 bits para evitar error, lo que hace es que se le hace una asignación directa de los datos que entran a la RAM: assign DatosSalidaMicro = DataBInMeMRAM;
	
	reg AccesoPuertos = 0; //Salida del comparador, si es menor que 512 significa que es un dispositivo de entrada y salida, también es un reset para la interfaz de memoria RAM, ya que si es 1, significa que no se desea hacer nada con la memoria RAM por lo que se resetea la misma 
	wire AccesoPuertosReg; // Salida del comparador de Acceso a puertos almacenada en un registro
	wire WriteMeMRAM11Reg; // Señal de la máquina de estados WriteMeMRAM almacenada en registro
	wire [31:0] DataInputTowardMicroReg; // Bus de datos de entrada al micro almacenado en un registro
	
	wire WritePPI11; // Salida de la compuerta AND WriteMeMRAM11Reg y AccesoPuertosReg; la salida del PPI solo se habilita si AddressEfectiveRAM es menor a 512 y además WriteMeMRAM es 1.
	wire ReadPPI11;  // Salida de la compuerta AND EnableRAMReg111 y AccesoPuertosReg; la lectura del PPI solo se habilita si AddressEfectiveRAM es menor a 512 y además EnableRAM es 1.
	wire EnableReadPPI; // Señal que almacena en un registro la salida del módulo ReadPPI11
	wire ResetInterfazRAM; // Señal de reset es una OR entre el acceso a puerto y la memoria RAM 
	wire ResetResultCompare; // Reset del Registro resultado de la comparación si Address es menor a 512 para menejo de I/O
	
	 generate
		if(ExtensionF == 1) begin
			
			wire [63:0] DataBInMeMRAM; // Entrada a la interfaz de memoria
			
			wire [1:0] SELDataWriteMeMRAM; // Selecciona si es un Load con enteros, un flotante o un Double
			wire EnableRegisterABFloat; // Señal de enable de los registros flotantes AB
			wire WriteRegisterBankFloat; // Señal de escritura del banco de registros flotante
			wire EnableRegisterLoadFload; // Enable del registro que almacena si es un load float o un load double 
			wire SELWriteBankFloat; // Selector del MUX de los datos que van hacia el banco de registros
	
			wire [63:0] ReadData1Double, ReadData2Double, ReadData3Double, DataADouble, DataBDouble, DataCDouble; // Signal ReadData1Float, ReadData2Float
			
			wire [31:0] DataBDoubletoFloat; // Se utiliza para la salida del modulo conversor de Double a FLoat
			reg [63:0] OutMUXDataInMEMRAM = 0; // Señal de salida del MUX que controla si entra un entero de 32 bits, un flotante o un double a la memoria RAM
			
			
			wire [63:0] OutputMUXMEMWrite; // Salida del MUX de selección Load FLoat, Load Double
			wire [63:0] DataOutputRAMFloatToDouble; // FLoat to Double 
			wire [63:0] DataOutputRAM1; // Registro que almacena la selección ya sea de del Load Double y Load FLoat
			
			wire [63:0] WriteDataFloat; // Señal que entra al banco de registros 
			wire [63:0] ResultFPU; // Salida de la FPU;
			
			wire  InicioSum, InicioSumReg; // Inicio Suma FPU
			wire InicioMult, InicioMultReg;// Inicio Mult FPU
			wire AcknowledgeAdd_sub, AcknowledgeAdd_subReg;   // Acknowledge del módulo suma y resta FPU
			wire AcknowledgeMult, AcknowledgeMultReg;      // Acknowledge del módulo multiplicación FPU
			wire Add_sub, Add_subReg; // // Si es 0 suma, si es 1 resta. Módulo FPU
			wire ReadyFPU, ReadyFPUReg;  // Ready FPU
			wire [2:0] SELMUXOutputFPU, SELMUXOutputFPUReg; // Selecciona si la salida es de la suma, resta, multiplicación
			wire SELMUXRetroalimentacion, SELMUXRetroalimentacionREG; // Seleccionador del MUX de retroalimentación suma para operaciones compuestas FPU
			wire [4:0] Funct7TypeOperationFloatReg; // Proviene del Instrucción Register: Se utiliza para operaciones con Opcode =  1010011; Operaciones simples
			wire ResetFPU; // Señal de reset del módulo FPU y de los registros sin control de flujo de la parte flotante, se va a resetear para disminuir notablemente el consumo de potencia	
			wire ResetFPUFinal; // Es la OR del ResetMicro y el ResetFPU 
			
			
			wire [63:0] OutputDataInterfazRAM; // Señal de salida de la interfaz RAM 
			
			///////////////////////////////////////////////////////////////////
			assign SalidaDePrueba = AddressPCMeMROM;
			
			/////////////////////
			
			
			FSMControlCPUDoubleFloatFSMControl 
			 FSMControlCPUFloatPoint (
			 .CLK(CLK),              //*****************************************
			 .Reset(Reset),          //*****************************************
			 .Opcode(InstructionRegisterOutput[6:0]),  //************************ Opcode 
			 .Funct7Bits0(SELFlagMULOperation),  //************************ Bit 25 del Instruction Register Para las instrucciones MUL, MULH, DIV, ...                
			 .Funct3(InstructionRegisterOutput[13:12]),  // 2 bits LSB  del funct3
			 .Funct75BitsMSB(Funct7TypeOperationFloatReg), //*********************
			 .ReadyFPU(ReadyFPUReg),             //*************************
			 .ResetRegisterMicro(ResetMicro),  //***************************************** 
			 .EnablePC(EnablePC),           //*****************************************
			 .EnableInstRegister(EnableInstRegister),   //*****************************************
			 .WriteRegisterBank(WriteRegisterBank),  //*****************************************
			 .TypeOperation(TypeOperation),  //*******************************
			 .EnableRegisterAB(EnableRegisterAB),  //************************************
			 .SELMUXRS2(SELMUXRS2InALU),    //************************************
			 .SELMUXRS1(SELMUXRS1InALU),         //************************************
			 .EnableSignLSBImmediate(EnableSignLSBImmediate), //*****************
			 .EnableRegisterInALU(EnableRegisterInALU),   //********************************
			 .EnableALUOut(EnableALUOut),   //*************************************** 
			 .EnableRAM(EnableRAM),   //***************************************
			 .WriteMeMRAM(WriteMeMRAM),   //********************************
			 .SELMUXSignExtend(SELMUXSignExtend),  //***********************
			 .EnableRegisterBranch(EnableRegisterBranch),  //************************************
			 .PCWriteCond(PCWriteCond),               //*********************************    
			 .SELMUXWriteDataBank(SELMUXWriteDataBank),  //*********************************    
			 .PCWrite(PCWrite),	     //*********************************
			 .SELMUXWriteDataPC(SELMUXWriteDataPC),  //********************************
			 .EnableRegisterABFloat(EnableRegisterABFloat), //************************* 
			 .WriteRegisterBankFloat(WriteRegisterBankFloat), //*******************
			 .SELDataWriteMeMRAM(SELDataWriteMeMRAM), //******************
			 .EnableRegisterLoadFload(EnableRegisterLoadFload),  //******************
			 .SELWriteBankFloat(SELWriteBankFloat),                //******************
			 .InicioSum(InicioSum),     //*********************************
			 .InicioMult(InicioMult),   //*******************************
			 .AcknowledgeAdd_sub(AcknowledgeAdd_sub), //*************************
          .AcknowledgeMult(AcknowledgeMult), //************************
          .Add_sub(Add_sub), //********************************
          .SELMUXOutputFPU(SELMUXOutputFPU),  //************************
			 .SELMUXRetroalimentacion(SELMUXRetroalimentacion), //************************
			 .ResetFPU(ResetFPU), //************************
			 .ResetResultCompare(ResetResultCompare) //******************************
			 );
			 
			 assign ResetFPUFinal = ResetFPU | ResetMicro; // Compuerta OR del ResetMicro y el ResetFPU sirve para resetear todos los registros internedios sin control de flujo de las operaciones con flotantes y la unidad FPU
			 
			 //MUX que selecciona lo que va hacia el registro WriteData
			 always @(SELMUXWriteDataBank, UpperImmediate, DataOutputRAM[31:0], DataALUOptRegister, ResultFPU[0])
				 case (SELMUXWriteDataBank)
					 2'b00: WriteDataBankRegister <= DataALUOptRegister; // Registro que proviene de la ALU
					 2'b01: WriteDataBankRegister <= DataOutputRAM[31:0]; // Salida de la memoria RAM
					 2'b10: WriteDataBankRegister <= UpperImmediate;
					 2'b11: WriteDataBankRegister <= {31'd0,ResultFPU[0]};  // Señal que proviene de la FPU para escribir en el banco de registros enteros, solo es un bit y es de las operaciones FEQ.S, FEQ.D FLT.S FLT.D FLE.S FLE.D
				 endcase
		
			
			
			
			BankRegisterFloatingPoint #(.Widht(64)) BankRegisterFloatingPoint1 (
			.CLK(CLK),            //*****************************************
			.Reset(ResetMicro),        //*****************************************
			.WriteData(WriteDataFloat), //******************************   
			.WriteRegister(WriteRegisterBankFloat), //**************************************  // SIgnal allow write bank
			.ReadRegister1(InstructionRegisterOutput[24:20]), //************************RS2
			.ReadRegister2(InstructionRegisterOutput[19:15]),  //************************RS1
			.ReadRegister3(InstructionRegisterOutput[31:27]),  // ********************+***RS3
			.WriteRegisterAddress(InstructionRegisterOutput[11:7]), //**************  RD
			.ReadData1(ReadData1Double),  //***************************************** //RS2
			.ReadData2(ReadData2Double),   //***************************************** //RS1
			.ReadData3(ReadData3Double)   //*********************************************** //RS3
			);
			
			InterfazMemoriaRAM64 #(.WidthData(64), .RAM_ADDR_BITS(`RAM_ADDR_BITS), .RAM_ADDR_START_BITS(RAM_ADDR_START_BITS), .InicializarRAM(InicializarRAM), .DIRInicioInicializarRAM(DIRInicioInicializarRAM), .DIRFinInicializarRAM(DIRFinInicializarRAM))
			 InterfazMemoriaRAM64bits (
			 .CLK(CLK),  //*****************************************
			 .Reset(ResetInterfazRAM),      //**************** Reset de registros internos
			 .WriteMemory(WriteMeMRAM),   //*************** Write Signal
			 .funct3(InstructionRegisterOutput[14:12]),   //***********funct3
			 .EnableReadWrite(EnableRAM),     // *********Habilita la lectura y la escritura de la RAM
			 .AddressRAM(AddressEfectiveRAM),   // ***************Dirección efectiva a la salida de la ALU RS1 + SignExtended Imm, se le concatenan 32 ceros 
			 .DataLoad(DataBInMeMRAM), //*****************RS2
			 .DataOutput(OutputDataInterfazRAM)  //************************* Dato de salida RAM
			 );
			 
			 
			 // Multiplexor que selecciona si los datos a la salida de un load Word, proviene
			 // de la memoria RAM o de un puerto de entrada y de salida del microprocesador
			 
			 assign DataOutputRAM = AccesoPuertosReg ? {32'd0,DataInputTowardMicroReg[31:0]} : OutputDataInterfazRAM; // Si es uno quiere decir que el load va leer un PPI en lugar de la memoria, si es 0 se va leer un dato de la memoria
			 
			
			
			Register #(.Widht(64)) RegisterADouble (  // Registro RS1
			.CLK(CLK),       //*****************************************
			.Reset(ResetMicro),    //*****************************************
			.Enable(EnableRegisterABFloat),   //*****************************************
			.DataInput(ReadData2Double),     //*****************************************
			.DataOutput(DataADouble)    //*****************************************  //RS1
			);
	 
			Register #(.Widht(64)) RegisterBDouble (  // Registro RS2
			.CLK(CLK),     //*****************************************
			.Reset(ResetMicro),   //*****************************************
			.Enable(EnableRegisterABFloat),   //*****************************************
			.DataInput(ReadData1Double),     //*****************************************
			.DataOutput(DataBDouble)    //*****************************************  // RS2
			);
			
			Register #(.Widht(64)) RegisterCDouble (  // Registro RS3
			.CLK(CLK),     //*****************************************
			.Reset(ResetMicro),   //*****************************************
			.Enable(EnableRegisterABFloat),   //*****************************************
			.DataInput(ReadData3Double),     //*****************************************
			.DataOutput(DataCDouble)    //*****************************************  // RS3
			);
			
			
			RegistroSinEnable #(.Widht(5)) RegisterFunct75bitsMSB (  // Registros sin enable 
			.CLK(CLK), //********************
			.Reset(ResetFPUFinal), //********************
			.DataInput(InstructionRegisterOutput[31:27]), //funct7 4 bits MSB
			.DataOutput(Funct7TypeOperationFloatReg)  // funct7 4 bits MSB almacenado en registro
			);
			
			RegisterOneBitSinEnable  RegisterInicioSum (  // Registros sin enable  Inicio Sum
			.CLK(CLK), //********************
			.Reset(ResetFPUFinal), //********************
			.DataInput(InicioSum), //Inicio Sum 
			.DataOutput(InicioSumReg)  // Inicio Sum Reg
			);
			
			RegisterOneBitSinEnable  RegisterInicioMult (  // Registros sin enable  Inicio Mult
			.CLK(CLK), //********************
			.Reset(ResetFPUFinal), //********************
			.DataInput(InicioMult), //Inicio Mult 
			.DataOutput(InicioMultReg)  // Inicio Mult Reg
			);
			
			RegisterOneBitSinEnable  RegisterAcknowledgeAdd_sub (  // Registros sin enable  AcknowledgeAdd_sub
			.CLK(CLK), //********************
			.Reset(ResetFPUFinal), //********************
			.DataInput(AcknowledgeAdd_sub), //AcknowledgeAdd_sub 
			.DataOutput(AcknowledgeAdd_subReg)  // AcknowledgeAdd_sub Reg
			);
			
			RegisterOneBitSinEnable  RegisterAcknowledgeMult (  // Registros sin enable  AcknowledgeMult
			.CLK(CLK), //********************
			.Reset(ResetFPUFinal), //********************
			.DataInput(AcknowledgeMult), //AcknowledgeMult 
			.DataOutput(AcknowledgeMultReg)  // AcknowledgeMult Reg
			);
			
			RegisterOneBitSinEnable  RegisterAdd_sub (  // Registros sin enable  Add_sub
			.CLK(CLK), //********************
			.Reset(ResetFPUFinal), //********************
			.DataInput(Add_sub), //Add_sub 
			.DataOutput(Add_subReg)  // Add_sub Reg
			);
			
			RegisterOneBitSinEnable  RegisterReadyFPU (  // Registros sin enable  ReadyFPU
			.CLK(CLK), //********************
			.Reset(ResetFPUFinal), //********************
			.DataInput(ReadyFPU), //ReadyFPU 
			.DataOutput(ReadyFPUReg)  // ReadyFPU Reg
			);
			
			RegistroSinEnable #(.Widht(3)) RegisterSELMUXOutputFPU (  // Registros sin enable 
			.CLK(CLK), //********************
			.Reset(ResetFPUFinal), //********************
			.DataInput(SELMUXOutputFPU), //SELMUXOutputFPU
			.DataOutput(SELMUXOutputFPUReg)  // SELMUXOutputFPU Reg
			);
			
			RegisterOneBitSinEnable  RegisterSELMUXRetroalimentado (  // Registros sin enable  SELMUXRetroalimentacion  señal que selecciona si es compleja simple o avanzada
			.CLK(CLK), //********************
			.Reset(ResetFPUFinal), //********************
			.DataInput(SELMUXRetroalimentacion), //SELMUXRetroalimentacion 
			.DataOutput(SELMUXRetroalimentacionREG)  // SELMUXRetroalimentacion Reg
			);
			
			
			
			FloatingPointUnit FloatingPointUnit1 (  // FPU
			.CLK(CLK), //***********
			.Reset(ResetFPUFinal), //********************** 
			.InicioSum(InicioSumReg),  //*****************
			.InicioMult(InicioMultReg), //*************
			.AcknowledgeAdd_sub(AcknowledgeAdd_subReg), //************** 
			.AcknowledgeMult(AcknowledgeMultReg), //**********************
			.SELMUXRetroalimentacion(SELMUXRetroalimentacionREG), //***************************
			.Add_sub(Add_subReg),   //***************************
			.funct3(Funct3Reg[1:0]),  //********************* Funct3 almacenado en registro
			.SELMUXOutputFPU(SELMUXOutputFPUReg), //*****************+** 
			.RS1Float(DataADouble), //*****************
			.RS2Float(DataBDouble), //*************************
			.RS3Float(DataCDouble),    //********************
			.ResultFPU(ResultFPU),   //*******************
			.overflow_flag(overflow_flag), 
			.underflow_flag(underflow_flag), 
			.ready(ReadyFPU)  //***************************
			);
			
			DoubletoFloat DoubletoFloat1 ( // Se convierte un Double a FLotante en caso de que se desea realizar un float en memoria
			.Double(DataBDouble),  //**********************
			.Float(DataBDoubletoFloat[31:0])  //*****************************
			);
			
			always @(SELDataWriteMeMRAM, DataB, DataBDoubletoFloat, DataBDouble) begin // Se selecciona el tipo de operando que va hacia la memoria RAM, si es entero de 32 bits, un flotante de 32 bits o un Double de 64 bits
				case (SELDataWriteMeMRAM)
					2'b00: OutMUXDataInMEMRAM <= {32'd0,DataB}; // RS2 de operaciones con enteros, banco de registros enteros
					2'b01: OutMUXDataInMEMRAM <= {32'd0,DataBDoubletoFloat}; // Store data Float
					2'b10: OutMUXDataInMEMRAM <= DataBDouble;  // Store data Double
					default : OutMUXDataInMEMRAM <= 64'd0; // No implementado
				endcase
			end
			
			assign DataBInMeMRAM = OutMUXDataInMEMRAM; // Entrada de la memoria RAM, es la salida del MUX que selecciona si es un DOuble, un float o un entero de 32 bits
			
			
			
			FloatToDouble FloatToDouble1 ( //Se convierte la salida de la memoria RAM de tipo floatnte a Double para guardar después en el banco de registros
			.Float(DataOutputRAM[31:0]), // FLotante a la salida de la memoria
			.Double(DataOutputRAMFloatToDouble) // Se convierte por defecto a double 64 bits
			);
			
			
			
			assign OutputMUXMEMWrite = (Funct3Reg[1:0] == 2'b10) ? DataOutputRAMFloatToDouble : DataOutputRAM;
			
			Register #(.Widht(64)) RegisterLoadFloatDouble11 (
			.CLK(CLK),     //*****************************************
			.Reset(ResetMicro),   //*****************************************
			.Enable(EnableRegisterLoadFload),   //*****************************************
			.DataInput(OutputMUXMEMWrite),     //*****************************************
			.DataOutput(DataOutputRAM1)    //*****************************************  // RS2
			);
			
			
			
			// MUX que selecciona el dato que va hacia el banco de registros, si es uno el dato viene de la memoria
			// Si WriteDataFloat = 1, el dato viene de la memoria, WriteDataFloat = 0 proviene del banco de registros
			assign WriteDataFloat = SELWriteBankFloat ? DataOutputRAM1 : ResultFPU;  
			
			assign DatosSalidaMicro = DataBInMeMRAM[31:0];  // Asignación para evitar error por generate, esto va hacia la salida del microprocesador.
		
		
		end else begin // sin punto flotante
			 
			 wire [31:0] DataBInMeMRAM; // Entrada a la interfaz de memoria
			 wire [31:0] OutputDataInterfazRAM; // Señal de salida de la interfaz RAM 
			 assign DataBInMeMRAM[31:0] = DataB;
		
			 InterfazMemoriaRAM #(.WidthData(32), .RAM_ADDR_BITS(`RAM_ADDR_BITS), .RAM_ADDR_START_BITS(RAM_ADDR_START_BITS), .InicializarRAM(InicializarRAM), .DIRInicioInicializarRAM(DIRInicioInicializarRAM), .DIRFinInicializarRAM(DIRFinInicializarRAM))
			 InterfazMemoriaRAM32bits (
			 .CLK(CLK),  //*****************************************
			 .Reset(ResetInterfazRAM),      //**************** Reset de registros internos
			 .WriteMemory(WriteMeMRAM),   //*************** Write Signal
			 .funct3(InstructionRegisterOutput[14:12]),   //***********funct3
			 .EnableReadWrite(EnableRAM),     // *********Habilita la lectura y la escritura de la RAM
			 .AddressRAM(AddressEfectiveRAM),   // ***************Dirección efectiva a la salida de la ALU RS1 + SignExtended Imm
			 .DataLoad(DataBInMeMRAM[31:0]), //*****************RS2
			 .DataOutput(OutputDataInterfazRAM[31:0])  //************************* Dato de salida RAM
			 );
			 
			 // Multiplexor que selecciona si los datos a la salida de un load Word, proviene
			 // de la memoria RAM o de un puerto de entrada y de salida del microprocesador
			 
			 assign DataOutputRAM[31:0] = AccesoPuertosReg ? DataInputTowardMicroReg[31:0] : OutputDataInterfazRAM[31:0]; // Si es uno quiere decir que el load va leer un PPI en lugar de la memoria, si es 0 se va leer un dato de la memoria
			 
			 
			 FSMControl 
			 FSMControlCPU (
			 .CLK(CLK),              //*****************************************
			 .Reset(Reset),          //*****************************************
			 .Opcode(InstructionRegisterOutput[6:0]),  //************************ Opcode 
			 .Funct7Bits0(SELFlagMULOperation),  //************************ Bit 25 del Instruction Register Para las instrucciones MUL, MULH, DIV, ...                
			 .ResetRegisterMicro(ResetMicro),  //***************************************** 
			 .EnablePC(EnablePC),           //*****************************************
			 .EnableInstRegister(EnableInstRegister),   //*****************************************
			 .WriteRegisterBank(WriteRegisterBank),  //*****************************************
			 .TypeOperation(TypeOperation),  //*******************************
			 .EnableRegisterAB(EnableRegisterAB),  //************************************
			 .SELMUXRS2(SELMUXRS2InALU),    //************************************
			 .SELMUXRS1(SELMUXRS1InALU),         //************************************
			 .EnableSignLSBImmediate(EnableSignLSBImmediate), //*****************
			 .EnableRegisterInALU(EnableRegisterInALU),   //********************************
			 .EnableALUOut(EnableALUOut),   //*************************************** 
			 .EnableRAM(EnableRAM),   //***************************************
			 .WriteMeMRAM(WriteMeMRAM),   //********************************
			 .SELMUXSignExtend(SELMUXSignExtend),  //***********************
			 .EnableRegisterBranch(EnableRegisterBranch),  //************************************
			 .PCWriteCond(PCWriteCond),               //*********************************    
			 .SELMUXWriteDataBank(SELMUXWriteDataBank),  //*********************************    
			 .PCWrite(PCWrite),	     //*********************************
			 .SELMUXWriteDataPC(SELMUXWriteDataPC),  //********************************
			 .ResetResultCompare(ResetResultCompare)
			 );
			 
			 
			 
			 //MUX que selecciona lo que va hacia el registro WriteData
			 always @(SELMUXWriteDataBank, UpperImmediate, DataOutputRAM[31:0], DataALUOptRegister)
				 case (SELMUXWriteDataBank)
					 2'b00: WriteDataBankRegister <= DataALUOptRegister; // Registro que proviene de la ALU
					 2'b01: WriteDataBankRegister <= DataOutputRAM[31:0]; // Salida de la memoria RAM
					 2'b10: WriteDataBankRegister <= UpperImmediate;
					 2'b11: WriteDataBankRegister <= 0;
				 endcase
			 
			 assign DatosSalidaMicro = DataBInMeMRAM[31:0]; // Asignación para evitar error por generate, esto va hacia la salida del microprocesador.
		
			
		end
	 endgenerate
	 
	 
	 
	 
	 
	 RegisterOneBitSinEnable RegisterBitParaMULOperation (
	 .CLK(CLK),  //**************
	 .Reset(ResetMicro),   //******************
	 .DataInput(InstructionRegisterOutput[25]), // Bit 25 del Instruction Register Para las instrucciones MUL, MULH, DIV, ...                
	 .DataOutput(SELFlagMULOperation) //Funct7 almacenado en registro
	 );
	 
	

	  
	 
	 
	 ProgramCounter #(.AddressWidth(WidhtAddress), .ProgramStartAddress(`ProgramStartAddressPC)) ProgramCounter1 (
	 .CLK(CLK),              //*****************************************
	 .Reset(ResetMicro),          //*****************************************
	 .Enable(EnablePC),          //*****************************************
	 .LoadEnable(EnableLoadPC),   //********************************* 
	 .LoadData(LoadDataPC),                 //********************************* 
	 .CounterOutput(AddressPCMeMROM)   //*****************************************
	 );


	 generate
		 if (WidthData == 32) begin
			 //assign LoadDataPC = SELMUXWriteDataPC ? {DataALUOptRegister[31],DataALUOptRegister[31:1]} : DataALUOptRegister; // Si es 1, es para instrucción JALR, si es 0 es para instrucción JAL Antes 
			 assign LoadDataPC = SELMUXWriteDataPC ? {DataALUOptRegister[31:1],1'b0} : DataALUOptRegister; // Si es 1, es para instrucción JALR, si es 0 es para instrucción JAL Ahora
		 end else begin
			 assign LoadDataPC = SELMUXWriteDataPC ? {{32{DataALUOptRegister[31]}},DataALUOptRegister[31:1],1'b0} : DataALUOptRegister; // Si es 1, es para instrucción JALR, si es 0 es para instrucción JAL Ahora
		 end
	 endgenerate
	 

	 
	 InterfazMemoriaROM  #(.WidthAddressInputPortROM(WidhtAddress), .WidthInstruction(WidthInstruction), .ROM_ADDR_BITS(`ROM_ADDR_BITS), .ROM_WIDTH(ROM_WIDTH), .BEGIN_ADDR_PROGRAM(`BEGIN_ADDR_ROM_PROGRAM), .END_ADDR_PROGRAM(`END_ADDR_ROM_PROGRAM), .ROM_ADDR_START_BITS(`ROM_ADDR_START_BITS))
	 InterfazMemoriaROM1 (
	 .CLK(CLK),  //*****************************************
	 .AddressROM(AddressPCMeMROM), //*****************************************
	 .Instruction(Instruction)   //*****************************************
	 );
	 
		
		
	 
	 assign AddressEfectiveRAM = DataALUOptRegister; // Es la salida de la ALU y forma la dirección efectiva para Load y Store
	 
	  
	 
	 
	 
	 
	 Register  InstructionRegister (// No se pone parametrizado porque siempre es de 32 bits
	 .CLK(CLK),             //*****************************************
	 .Reset(ResetMicro),         //*****************************************
	 .Enable(EnableInstRegister),    //*****************************************
	 .DataInput(Instruction),    //*****************************************
	 .DataOutput(InstructionRegisterOutput) //*****************************************
	 );
	 
	 assign immLSB = SELMUXSignExtend ? InstructionRegisterOutput[11:7] : InstructionRegisterOutput[24:20]; // Selecciona si el immediato es de una instrucción tipo I o una instrucction tipo S, es decir selecciona si los 
	 //12 bits del inmediato vienen de la posición [31:20] o de la posición {[31:25],[11:7]}
	 
	 
	 Register #(.Widht(5)) RegistroimmLSB (
	 .CLK(CLK),       //*****************************************
	 .Reset(ResetMicro),    //*****************************************
	 .Enable(EnableSignLSBImmediate),   //*****************************************
	 .DataInput(immLSB),     //*****************************************
	 .DataOutput(immLSBReg)    //*****************************************  
	 );
	 
	 
	 
	 generate
		 if (WidthData == 32) begin
			 assign SignExtentedimm =  {{20{InstructionRegisterOutput[31]}}, InstructionRegisterOutput[31:25], immLSBReg};
		 end else begin
			 assign SignExtentedimm =  {{52{InstructionRegisterOutput[31]}}, InstructionRegisterOutput[31:25], immLSBReg};
		 end
	 endgenerate
	 
	 
	 // *********************Upper Inmmediate para instrucción LUI y AUIPC******************
	 generate
		 if (WidthData == 32) begin
			 assign UpperImmediate = {InstructionRegisterOutput[31:12],12'd0};
		 end else begin
			 assign UpperImmediate = {{32{InstructionRegisterOutput[31]}},InstructionRegisterOutput[31:12],12'd0};
			 
		 end
	 endgenerate
	  
	 
	 // ********************* inmediato instrucción JAL tipo U-J
	 generate
		 if (WidthData == 32) begin
			 assign InmediateJAL = {{12{InstructionRegisterOutput[31]}},InstructionRegisterOutput[31],InstructionRegisterOutput[19:12],InstructionRegisterOutput[20],InstructionRegisterOutput[30:21]};
		 end else begin
			 assign InmediateJAL = {{44{InstructionRegisterOutput[31]}},InstructionRegisterOutput[31],InstructionRegisterOutput[19:12],InstructionRegisterOutput[20],InstructionRegisterOutput[30:21]};		 
		 end
	 endgenerate
	 
	
	 
	
	 BankRegister #(.Widht(WidthData),.StackPointer(`StackPointer)) BankRegisterInteger (
	 .CLK(CLK),            //*****************************************
	 .Reset(ResetMicro),        //*****************************************
	 .WriteData(WriteDataBankRegister), //******************************   
	 .WriteRegister(WriteRegisterBank), //************************************** // SIgnal allow write bank
	 .ReadRegister1(InstructionRegisterOutput[24:20]), //************************RS2
	 .ReadRegister2(InstructionRegisterOutput[19:15]),  //************************RS1
	 .WriteRegisterAddress(InstructionRegisterOutput[11:7]), //**************  RD
	 .ReadData1(ReadData1),  //***************************************** //RS2
	 .ReadData2(ReadData2)   //***************************************** //RS1
	 ); 
	 
	 
	 
	 Register #(.Widht(WidthData)) RegisterA (
	 .CLK(CLK),       //*****************************************
	 .Reset(ResetMicro),    //*****************************************
	 .Enable(EnableRegisterAB),   //*****************************************
	 .DataInput(ReadData2),     //*****************************************
	 .DataOutput(DataA)    //*****************************************  //RS1
	 );
	 
	 Register #(.Widht(WidthData)) RegisterB (
	 .CLK(CLK),     //*****************************************
	 .Reset(ResetMicro),   //*****************************************
	 .Enable(EnableRegisterAB),   //*****************************************
	 .DataInput(ReadData1),     //*****************************************
	 .DataOutput(DataB)    //*****************************************  // RS2
	 );
	 
	 Register #(.Widht(WidthData)) RegisterSignExtendIMM (
	 .CLK(CLK),  //*****************************************
	 .Reset(ResetMicro),   //*****************************************
	 .Enable(EnableRegisterAB), //************************** Mismo enable del Registro A y B
	 .DataInput(SignExtentedimm), //**************************
	 .DataOutput(SignExtentedimmOutRegister)  //**************************
	 );
	 
	 Register #(.Widht(WidthData)) RegisterSignExtendIMMBranch (
	 .CLK(CLK),  //*****************************************
	 .Reset(ResetMicro),  //***************************************** 
	 .Enable(EnableRegisterAB), //*************************************** Mismo Enable que Registro A y B
	 .DataInput(SignExtendedIMMBRanch), //***************************************** 
	 .DataOutput(OutputRegSignExtendedIMMBRanch)    //****************************
	 );
	 
	 Register #(.Widht(WidthData)) RegisterSignExtendIMMJAL (
	 .CLK(CLK),  //*****************************************
	 .Reset(ResetMicro),  //***************************************** 
	 .Enable(EnableRegisterAB), //*************************************** Mismo Enable que Registro A y B
	 .DataInput(InmediateJAL), //***************************************** 
	 .DataOutput(OutputRegInmediateJAL)    //****************************
	 );
	 

	 
	 // Extension de signo de los branch
	 generate
		 if (WidthData == 32) 
			 assign SignExtendedIMMBRanch =  {{20{InstructionRegisterOutput[31]}}, InstructionRegisterOutput[31],InstructionRegisterOutput[7], InstructionRegisterOutput[30:25], InstructionRegisterOutput[11:8]};
		 else 
			 assign SignExtendedIMMBRanch =  {{52{InstructionRegisterOutput[31]}}, InstructionRegisterOutput[31],InstructionRegisterOutput[7], InstructionRegisterOutput[30:25], InstructionRegisterOutput[11:8]};
	 endgenerate
	 
	 
	 
	 
	 assign RS1ALU = SELMUXRS1InALU ? AddressPCMeMROM : DataA; // Selector de Datos que van hacia la ALU por el puerto RS1
	 
	 
	 
	 generate
		 if (WidthData == 32) 
			 always @(SELMUXRS2InALU, SignExtentedimmOutRegister, DataB, OutputRegSignExtendedIMMBRanch,UpperImmediate,OutputRegInmediateJAL)
				 case (SELMUXRS2InALU)
					 3'b000: RS2ALU <= DataB;
					 3'b001: RS2ALU <= SignExtentedimmOutRegister;
					 3'b010: RS2ALU <= OutputRegSignExtendedIMMBRanch;
					 3'b011: RS2ALU <= UpperImmediate;
					 3'b100: RS2ALU <= OutputRegInmediateJAL;
					 3'b101: RS2ALU <= 32'd2; // Se coloca en 2 en lugar de 4 porque el PC va de 2 en 2
					 default : RS2ALU <= 32'd0;
				 endcase   
		 else 
			 always @(SELMUXRS2InALU, SignExtentedimmOutRegister, DataB, OutputRegSignExtendedIMMBRanch,UpperImmediate,OutputRegInmediateJAL)
				 case (SELMUXRS2InALU)
					 3'b000: RS2ALU <= DataB;
					 3'b001: RS2ALU <= SignExtentedimmOutRegister;
					 3'b010: RS2ALU <= OutputRegSignExtendedIMMBRanch;
					 3'b011: RS2ALU <= UpperImmediate;
					 3'b100: RS2ALU <= OutputRegInmediateJAL;
					 3'b101: RS2ALU <= 64'd2; // Se coloca en 2 en lugar de 4 porque el PC va de 2 en 2
					 default : RS2ALU <= 64'd0;
				 endcase
	 endgenerate
	 
	 RegistroSinEnable #(.Widht(3)) RegisterFunct3 (
	 .CLK(CLK), //********************
	 .Reset(ResetMicro), //********************
	 .DataInput(InstructionRegisterOutput[14:12]), //funct3
	 .DataOutput(Funct3Reg)  // Funct3 almacenado en registro
	 );
	 
	 RegisterOneBitSinEnable RegisterFunct7bit6 (
	 .CLK(CLK),  //**************
	 .Reset(ResetMicro),   //******************
	 .DataInput(InstructionRegisterOutput[30]), //funct7[5]
	 .DataOutput(funct7Bit5) //Funct7 almacenado en registro
	 );
	 
	 Register #(.Widht(WidthData)) RegistroEntradaALURS1 (
	 .CLK(CLK), //********************
	 .Reset(ResetMicro), //********************
	 .Enable(EnableRegisterInALU),  //**************
	 .DataInput(RS1ALU), // RS1ALU entrada ALU sin registrar
	 .DataOutput(RS1ALUREG1)  // RS1ALU Salida ALU  registrada
	 );
	 
	 
	 Register #(.Widht(WidthData)) RegistroEntradaALURS2 (
	 .CLK(CLK), //********************
	 .Reset(ResetMicro), //********************
	 .Enable(EnableRegisterInALU),  //***************
	 .DataInput(RS2ALU), // RS2ALU entrada ALU sin registrar
	 .DataOutput(RS2ALUREG2)  // RS2ALU Salida ALU  registrada
	 );
	 
	 
	 
	 ALUControl  #(.ExtensionI(ExtensionI)) ALUControl1 (
	 .funct3(Funct3Reg),   //*****************************************
	 .funct7(funct7Bit5),   //*****************************************
	 .Class(TypeOperation),   //****************************
	 .SELOperation(SELALU)  //**************************
	 );
	 
	 
	 RegistroSinEnable #(.Widht(5)) RegistroTipoOperacionALU (
	 .CLK(CLK), //********************
	 .Reset(ResetMicro), //********************
	 .DataInput(SELALU), //funct3
	 .DataOutput(SELALUREG)  // Funct3 almacenado en registro
	 );
	 
	 
	 
	 ALUInteger #(.Width(WidthData), .ExtensionI(ExtensionI)) ALUIntegers (
	 .RS1(RS1ALUREG1),   //*****************************************  //RS1
	 .RS2(RS2ALUREG2),   //*****************************************  // RS2
	 .SEL(SELALUREG),   //**************************
	 .RD(DataALUOut)   //***************************************** 
	 );
	 
	 RegisterOneBit RegisterFlagBranch (
	 .CLK(CLK),   //*****************************************    
	 .Reset(ResetMicro),    //*****************************************    
	 .Enable(EnableRegisterBranch),    //***************************************** 
	 .DataInput(DataALUOut[0]),   //*****************************************    
	 .DataOutput(FlagBranch)    //*****************************************    
	 );
	 
	 
	 RegisterOneBitSinEnable RegisterSELFLAG (
	 .CLK(CLK),  //**************
	 .Reset(ResetMicro),   //******************
	 .DataInput(InstructionRegisterOutput[12]), //funct7[5]
	 .DataOutput(SELFlagBranchh) //Funct7 almacenado en registro
	 );
	 
	 
	 //MUX de selección de Flag o Flag negada, si es un BEQ, BLT, BLTU compara si es verdadera la salida es un 1
	 // si la salida es falsa y es un BNE, BGE, BGEU y como se usa el mismo hardware que BEQ, BLT, BLTU, significa que
	 // en realidad es verdadero, por eso se invierte la bandera y dado que para BEQ, BLT, BLTU el bit funct3[0] 
	 // es 0 para estas y 1 para BNE, BGE, BGEU, se coloca el funct3[0] como selector de este MUX
	 assign FlagBranchOutputMUX = SELFlagBranchh ? ~FlagBranch : FlagBranch; // Selecciona FLag si es para BEQ,BLT, o BLTU o para BNE, BGE, BGEU
	 
	 assign PCWriteBranch  = PCWriteCond & FlagBranchOutputMUX;  // COmpuerta AND de PCWriteBranch 
	
	 assign EnableLoadPC = PCWrite | PCWriteBranch;  // Compuerta OR para los saltos incondicionales
	 
	 Register #(.Widht(WidthData)) ALUOptRegister (
	 .CLK(CLK),                        //*****************************************     
	 .Reset(ResetMicro),                    //*****************************************
	 .Enable(EnableALUOut),   //******************************************
	 .DataInput(DataALUOut),   //*****************************************
	 .DataOutput(DataALUOptRegister)  //**************************************
	 );
	 
	 
	 
	 // Comparador de salida Adress, el bus de direcciones solo sale si se quiere acceder a una dirección menor a 512.
	 // el mapa de memoria indica que si una dirección es menor a 1024 lo que se quiere hacer es hablar con un dispositivo de entrada y salida
	 
	 always @* begin
      if (AddressEfectiveRAM < 32'h00000200) //Si la dirección de memoria interna es menor a 512, significa que se le esta hablando a un dispositivo de entrada y salida en lugar de a la memoria RAM
         AccesoPuertos <= 1'b1; // Si esta en 1 significa que se le da acceso a un dispositivo de entrada y salida
      else
         AccesoPuertos <= 1'b0; // Si es 0 significa que se le da acceso a la memoria RAm
	 end



	 RegisterOneBit RegisterSignalResultadoComparacionIO ( // Registro sin control de flujo que almacena el resultado de comparación para el mapa de puertos
	 .CLK(CLK),  //**************
	 .Reset(ResetResultCompare),   //******************
	 .Enable(EnableRAM),        //*********************************
	 .DataInput(AccesoPuertos), //Señal de AccesoPuertos: Resultado de comparar bus de direcciones si es menor a 1024
	 .DataOutput(AccesoPuertosReg) //Señal de AccesoPuertos guardada en registro: También es el reset de la RAM y el Enable del registro que escribe el bus de direcciones a la salida y el bus de datos a la salida. Y es también el selector del mux de la salida de memoria
	 );
	 
	 
	 
	 // Compuerta OR para resetear la interfaz de memoria RAS, se hace en caso de que se vaya a realizar
	 // una lectura o escritura de un PPI, como los PPI se accesan por medio de load y store
    // también va a intentar escribir o leer la memoria, por esta razón, cuando la dirección efectiva
    // es menor a 512 se necesita resetear los registros internos de la RAM para que no
    // escriba en la RAM.	 
	 assign ResetInterfazRAM = ResetMicro | AccesoPuertosReg; // ResetMicro;
	 
	 RegisterOneBitSinEnable RegisterSignalFSMWritePPI (
	 .CLK(CLK),  //**************
	 .Reset(ResetMicro),   //******************
	 .DataInput(WriteMeMRAM), //Señal de Write MEM
	 .DataOutput(WriteMeMRAM11Reg) //Señal de WriteMEM guardada en registro
	 );
	 
	 RegisterOneBitSinEnable RegisterSignalFSMEnablePPI (
	 .CLK(CLK),  //**************
	 .Reset(ResetMicro),   //******************
	 .DataInput(EnableRAM), //Señal de EnableRAM
	 .DataOutput(EnableRAMReg111) //Señal de EnableRAM guardada en registro
	 );
	 
	 // Se realiza la compuerta AND para saber si efectivamente es solo una lectura o escritura de un puerto externo
	 // lo que se hace es la salida del comparador de menor a 512, se le hace una AND con EnableRAM y WritePPI
	 // Si la salida de comparador es menor a 512 y Wirte MEM esta activo significa que se quiere escribir un PPI 
	 // Si la salida de comparador es menor a 512 y EnableRAM es 1, significa que se quiere leer un PPI Externo
	 
	 
	 
	 assign WritePPI11 = WriteMeMRAM11Reg & AccesoPuertosReg; // // Si la salida de comparador es verdadera(menor a 512) y Wirte MEM esta activo significa que se quiere escribir un PPI 
	 assign ReadPPI11 =  EnableRAMReg111 & AccesoPuertosReg & ~WriteMeMRAM11Reg; // // Si la salida de comparador es verdadera(menor a 512)  y EnableRAM esta en 1 y además WriteMeMRAM es 0  significa que se quiere leer un PPI 
	 
	 
	 
	 
	 RegisterOneBitSinEnable RegisterSignalEnableReadPPI (
	 .CLK(CLK),  //**************
	 .Reset(ResetMicro),   //******************
	 .DataInput(ReadPPI11), //Señal de EnableRAM
	 .DataOutput(EnableReadPPI) //Señal de EnableRAM guardada en registro
	 );
	 
	 
	 
	 
	 // **************** Registro del dato de entrada proviene de los PPI
	 
	 
	 
	 
	 Register #(.Widht(32)) RegistroEntradaDatosLeidosPPI ( // Registro que almacena los datos que se estan leyendo de un PPI, es decir el bus de datos que entra al micro
	 .CLK(CLK),                        //*****************************************     
	 .Reset(ResetMicro),                    //*****************************************
	 .Enable(EnableReadPPI),   //****************************************** El enable de lectura es la AND de la salida del comparador con EnableRAm  en 1 y WriteRAM negado 
	 .DataInput(DataInputTowardMicro[31:0]),   //*****************************************
	 .DataOutput(DataInputTowardMicroReg[31:0])  //**************************************
	 );
	 
	 
	 // ********************************** Asignación de pines almacenado en registros que van hacia la salida del microprocesador
	 
	 RegisterOneBitSinEnable RegisterSignalOutputMicroWritePPI (
	 .CLK(CLK),  //**************
	 .Reset(ResetMicro),   //******************
	 .DataInput(WritePPI11), //Señal WritePPI11 
	 .DataOutput(WritePPI) //Señal de WriteMEM guardada en registro, es la señal externa de salida para cuando se desea escribir un PPI
	 );
	  
	 Register #(.Widht(9)) RegistroSalidaMicroAddressPPI ( // Registro que almacena la salida del bus de direcciones hacia los PPI solo son 9 bits porque el mapa de puertos solo ocupa 9 bits
	 .CLK(CLK),                        //*****************************************     
	 .Reset(ResetMicro),                    //*****************************************
	 .Enable(AccesoPuertosReg),   //****************************************** El enable  es el resultado de la comparación si el bus de direcciones es menor a 512 es decir de lo contrario no hay salida 
	 .DataInput(AddressEfectiveRAM[8:0]),   //*****************************************
	 .DataOutput(AddressOutIO[8:0])  //**************************************
	 );
	 
	 Register #(.Widht(32)) RegistroSalidaDatosEscribirPPI ( // Registro que almacena los datos que se desean escribir en el PPI, es decir el bus de datos que sale del micro
	 .CLK(CLK),                        //*****************************************     
	 .Reset(ResetMicro),                    //*****************************************
	 .Enable(AccesoPuertosReg),   //****************************************** El enable  es el resultado de la comparación si el bus de direcciones es menor a 512 es decir de lo contrario no hay salida 
	 .DataInput(DatosSalidaMicro[31:0]),   //*****************************************
	 .DataOutput(DataOutputTowardIO[31:0])  //**************************************
	 );
	 
	

	


endmodule
	
	
	
	
