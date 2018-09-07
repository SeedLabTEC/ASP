`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:19:44 08/13/2015 
// Design Name: 
// Module Name:    InterfazMemoriaRAM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:  Inicializar se va a usar para los logaritmos que se deben calcular
// InicializarRAM = Si se quiere que la RAM este inicializada se utiliza InicializarRAM = 1, si no esta inicializada se coloca InicializarRAM = 0
// DIRInicioInicializarRAM = Se coloca tal y como esta en el Programa en C: Por ejemplo: int *n1 = (int*)0x0040; Sugiere que esta inicializado en la dirección 0x0040 si esta fuera la primera dirección
// Se pone DIRInicioInicializarRAM = 32'h00000040.
// Si el último puntero se coloca en int *n3 = (int*)0x0048; Se pone DIRFinInicializarRAM = 32'h00000048
// Consejo, si se inicializa un flotante, se debe colocar en direcciones subsecuentes
//////////////////////////////////////////////////////////////////////////////////
module InterfazMemoriaRAM #(parameter  WidthData = 32, RAM_ADDR_BITS = 10,  RAM_ADDR_START_BITS = 0,InicializarRAM = 1, DIRInicioInicializarRAM = 32'h00000008, DIRFinInicializarRAM = 32'h0000000c)
(CLK, Reset, WriteMemory, funct3, EnableReadWrite, AddressRAM, DataLoad, DataOutput);

	 input CLK, Reset, WriteMemory; // El reset es de los registros intermedios 
	 input EnableReadWrite; // Señal global que envía la máquina de estados para indicar que la memoria esta habilitada para leer o para escribir
	 input [2:0] funct3;
	 input [WidthData-1:0] AddressRAM;
	 input   [WidthData-1:0] DataLoad;
	 output   [WidthData-1:0] DataOutput;
	 
    wire [WidthData-1:0] AddressRAMReg, DataLoadReg;
	 wire [2:0] funct3REG;
	 
	 reg [3:0] EnableReadWriteInt = 0; // Señal que habilita el Enable tanto Write como Read
	 wire EnableReadWriteReg; // Señal de enable almacenada en registro
	 reg EnableRAM = 0; // Señal que se encarga de la mobilidad de la RAM
	 wire RegEnableRAM; //Señal del EnableRAM
	 wire [3:0] RegEnableReadWriteInt, RegEnableEnableFInalesRAM; //
	 
	 wire  WriteMemoryReg1, WriteMemoryReg2;
	 wire [3:0] WriteMemoryReg3;
	 
	 wire [WidthData-1:0] OutputMEM, OutputMEMReg;
	 reg [WidthData-1:0] LoadByte0 = 0;
	 reg [WidthData-1:0] LoadByte1 = 0;
	 reg [WidthData-1:0] LoadByte2 = 0;
	 reg [WidthData-1:0] LoadByte3 = 0;
	 
	 reg [WidthData-1:0] LoadHighL = 0;
	 reg [WidthData-1:0] LoadHighH = 0;
	 
	 reg [WidthData-1:0]  LoadByte = 0;
	 wire  [WidthData-1:0]  LoadHigh, LoadByteReg, LoadHighReg, LoadWordReg1; 
	 reg [WidthData -1:0] DataLoadOutputMEM = 0;
	 
	 wire [WidthData-1:0] LoadWordReg, LoadHighHReg, LoadHighLReg, LoadByte3Reg, LoadByte2Reg, LoadByte1Reg, LoadByte0Reg;
	 wire [WidthData-1:0] DataLoadMeMREG1, DataLoadMeMREG2;
	 reg [WidthData-1:0] DataLoadRegMux = 0;
	 
	 
	 wire [RAM_ADDR_BITS-3:0] AddressRAMFinal;
	 
	 //*****************************  Señales de Entrada de los registros  **********************
	 Register #(.Widht(WidthData)) RegAddressRAM (
    .CLK(CLK), //****************************
	 .Enable(EnableReadWrite), //****************
    .Reset(Reset), //**************************
    .DataInput(AddressRAM), //**************************
    .DataOutput(AddressRAMReg) //***************************
    );
	 
	 Register #(.Widht(WidthData)) RegDataLoad (
    .CLK(CLK),    //**************************
    .Reset(Reset),  //**************************
	 .Enable(EnableReadWrite), //******************
    .DataInput(DataLoad), //**************************
    .DataOutput(DataLoadReg)//***************
    );
	 
	 Register #(.Widht(3)) RegFunct3 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
	 .Enable(EnableReadWrite), //****************
    .DataInput(funct3), //***************
    .DataOutput(funct3REG)  //***************
    );
	 
	 RegisterOneBitSinEnable RegistroEnableInput (
	 .CLK(CLK),  //**************
	 .Reset(Reset),   //******************
	 .DataInput(EnableReadWrite),//*********************
	 .DataOutput(EnableReadWriteReg) //***********************
	 );
	 
	 RegisterOneBitSinEnable RegistroWriteMemory1 (
	 .CLK(CLK),  //**************
	 .Reset(Reset),   //******************
	 .DataInput(WriteMemory),//*********************
	 .DataOutput(WriteMemoryReg1) //***********************
	 );
	 
	 
	 
	 
	 // **************************Decodificador de Enable de lectura o escritura*****************************
	  
	 
	 
	 always @(EnableReadWriteReg,funct3REG[1:0],AddressRAMReg[1:0],DataLoadReg)  begin //Enable de lectura o escritura
		if(EnableReadWriteReg) begin
			if(funct3REG[1:0] == 2'b10) begin//LW o SW
				EnableReadWriteInt <=4'b1111;
				DataLoadRegMux <= DataLoadReg;
			end else if (funct3REG[1:0] == 2'b01) begin // SH LH
				if(AddressRAMReg[1:0] == 2'b00) begin
				   DataLoadRegMux <= DataLoadReg;
					EnableReadWriteInt <=4'b0011;
				end else begin
					EnableReadWriteInt <=4'b1100;
					DataLoadRegMux <= DataLoadReg << 16; // Desplazamiento a la izquierda 16 bits
				end
			end else begin     // funct3[1:0] == 2'b00
				if(AddressRAMReg[1:0] == 2'b00) begin
					EnableReadWriteInt <=4'b0001;
					DataLoadRegMux <= DataLoadReg;
				end else if(AddressRAMReg[1:0] == 2'b01) begin
					EnableReadWriteInt <=4'b0010;
					DataLoadRegMux <= DataLoadReg << 8; // Desplazamiento a la izquierda 8 bits
				end else if(AddressRAMReg[1:0] == 2'b10) begin
					EnableReadWriteInt <=4'b0100;
					DataLoadRegMux <= DataLoadReg << 16; // Desplazamiento a la izquierda 16 bits
				end else begin
					EnableReadWriteInt <=4'b1000;
					DataLoadRegMux <= DataLoadReg << 24; // Desplazamiento a la izquierda 24 bits
				end
			end
		end else begin
			EnableReadWriteInt <=4'b0000;
			DataLoadRegMux <= 32'd0;
		end
	 end
	 
	 
	 //******************************************** Se encarga de poner la RAM en un lugar específico*************
	 
	  generate
		 if (RAM_ADDR_START_BITS == 0) begin
			 always @* begin
				 if (AddressRAMReg <= ((2**RAM_ADDR_BITS) -1'd1))
						EnableRAM <= 1'b1;
				 else
						EnableRAM <= 1'b0;
			 end
			 
			 assign AddressRAMFinal = AddressRAMReg[RAM_ADDR_BITS-1:2]; // Dirección hacia la RAM, Adresss/4 == Address desplazado a la derecha
			 
		 end else begin
			always @* begin
				if ((AddressRAMReg >= 2**RAM_ADDR_START_BITS) && (AddressRAMReg <= ((2**RAM_ADDR_START_BITS)+(2**RAM_ADDR_BITS) -1'd1)))
					EnableRAM <= 1'b1;
				else
					EnableRAM <= 1'b0;
			end
			
			wire [WidthData-1:0] AddressRAMNew; // Se utiliza para almacenar la resta entre Address y el RAMStartBit
	      wire [RAM_ADDR_BITS-3:0] AddressRAMNew1; // Salida del registro del resultado anterior
			wire [RAM_ADDR_BITS-3:0] AddressRAMNew2; // Salida del registro del resultado anterior
			
			assign AddressRAMNew = AddressRAMReg - (2**RAM_ADDR_START_BITS); // Se resta el offset
			
			RegistroSinEnable #(.Widht(RAM_ADDR_BITS-2)) RegistroRAMNewStartBitZero1 (
			.CLK(CLK),    //**************************
			.Reset(Reset),   //**************************
			.DataInput(AddressRAMNew[RAM_ADDR_BITS-1:2]), //*************** Se  divide entre 4, es decir se desplaza a la derecha
			.DataOutput(AddressRAMNew1)  //***************
			);
			
			RegistroSinEnable #(.Widht(RAM_ADDR_BITS-2)) RegistroRAMNewStartBitZero2 (
			.CLK(CLK),    //**************************
			.Reset(Reset),   //**************************
			.DataInput(AddressRAMNew1), //***************
			.DataOutput(AddressRAMNew2)  //***************
			);
			
			assign AddressRAMFinal = AddressRAMNew2;
			
		 end
	 endgenerate
	 
	 RegistroSinEnable #(.Widht(4)) RegistroAlmacenaEnableRAM (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(EnableReadWriteInt), //***************
    .DataOutput(RegEnableReadWriteInt)  //***************
    );
	 
	 RegisterOneBitSinEnable RegistroEnableRAMStartBit (
	 .CLK(CLK),  //**************
	 .Reset(Reset),   //******************
	 .DataInput(EnableRAM),//*********************
	 .DataOutput(RegEnableRAM) //***********************
	 );
	 
	 RegisterOneBitSinEnable RegistroWriteMemory2 (
	 .CLK(CLK),  //**************
	 .Reset(Reset),   //******************
	 .DataInput(WriteMemoryReg1),//*********************
	 .DataOutput(WriteMemoryReg2) //***********************
	 );
	 
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaElDatoGuardarenMEM1 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(DataLoadRegMux), //***************
    .DataOutput(DataLoadMeMREG1)  //***************
    );
	 
	 
	 
	 
	 // Otro registro que hace la AND del EnableRAM con los otros bits
	 
	 RegistroSinEnable #(.Widht(4)) RegistroAlmacenaEnableFinales (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput({(RegEnableRAM & RegEnableReadWriteInt[3]),(RegEnableRAM & RegEnableReadWriteInt[2]),(RegEnableRAM & RegEnableReadWriteInt[1]),(RegEnableRAM & RegEnableReadWriteInt[0])}), //***************
    .DataOutput(RegEnableEnableFInalesRAM)  //***************
    );
	 
	 RegistroSinEnable #(.Widht(4)) RegistroWriteMemory3 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput({(WriteMemoryReg2 & RegEnableReadWriteInt[3]),(WriteMemoryReg2 & RegEnableReadWriteInt[2]),(WriteMemoryReg2 & RegEnableReadWriteInt[1]),(WriteMemoryReg2 & RegEnableReadWriteInt[0])}), //***************
    .DataOutput(WriteMemoryReg3)  //***************
    );
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaElDatoGuardarenMEM2 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(DataLoadMeMREG1), //***************
    .DataOutput(DataLoadMeMREG2)  //***************
    );
	 
	 generate
	 	if (RAM_ADDR_START_BITS == 0) begin
			MemoriesRAM #(.WidthData(WidthData), .RAM_ADDR_BITS(RAM_ADDR_BITS-2), .InicializarRAM(InicializarRAM), .DIRInicioInicializarRAM((DIRInicioInicializarRAM)/4), .DIRFinInicializarRAM((DIRFinInicializarRAM)/4)) 
		   MemoriesRAMMicro (
	 	   .CLK(CLK), //*******************************************
		   .RAMEnableByte0LSB(RegEnableEnableFInalesRAM[0]),  //**************
		   .RAMEnableByte1(RegEnableEnableFInalesRAM[1]), //*******************
		   .RAMEnableByte2(RegEnableEnableFInalesRAM[2]), //*******************
		   .RAMEnableByte3MSB(RegEnableEnableFInalesRAM[3]),  //******************** 
		   .WriteMemoryByte0LSB(WriteMemoryReg3[0]),   //*******************
		   .WriteMemoryByte1(WriteMemoryReg3[1]),    //***************
		   .WriteMemoryByte2(WriteMemoryReg3[2]),    //***************************
		   .WriteMemoryByte3MSB(WriteMemoryReg3[3]),  //*******************************
		   .DataLoad(DataLoadMeMREG2),  //***************************** 
		   .AddressRAM(AddressRAMFinal), //************************
		   .DataOutput(OutputMEM)      //**********************
		   );		
		end else begin
			MemoriesRAM #(.WidthData(WidthData), .RAM_ADDR_BITS(RAM_ADDR_BITS-2), .InicializarRAM(InicializarRAM), .DIRInicioInicializarRAM(((DIRInicioInicializarRAM - (2**RAM_ADDR_START_BITS))/4)), .DIRFinInicializarRAM(((DIRFinInicializarRAM - (2**RAM_ADDR_START_BITS))/4))) 
		   MemoriesRAMMicro (
		   .CLK(CLK), //*******************************************
		   .RAMEnableByte0LSB(RegEnableEnableFInalesRAM[0]),  //**************
		   .RAMEnableByte1(RegEnableEnableFInalesRAM[1]), //*******************
		   .RAMEnableByte2(RegEnableEnableFInalesRAM[2]), //*******************
		   .RAMEnableByte3MSB(RegEnableEnableFInalesRAM[3]),  //******************** 
		   .WriteMemoryByte0LSB(WriteMemoryReg3[0]),   //*******************
		   .WriteMemoryByte1(WriteMemoryReg3[1]),    //***************
		   .WriteMemoryByte2(WriteMemoryReg3[2]),    //***************************
		   .WriteMemoryByte3MSB(WriteMemoryReg3[3]),  //*******************************
		   .DataLoad(DataLoadMeMREG2),  //***************************** 
		   .AddressRAM(AddressRAMFinal), //************************
		   .DataOutput(OutputMEM)      //**********************
		   );
		end
	 endgenerate
	 
	 
	 
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaDatoMEM (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(OutputMEM), //***************
    .DataOutput(OutputMEMReg)  //***************
    );
	 
	 always @* begin  // Extensión de zero o de signo para Load Byte 0 LSB
		if (~funct3REG[2])
			LoadByte0 <= {{24{OutputMEMReg[7]}},OutputMEMReg[7:0]}; // LB Sign Extension
		else
			LoadByte0 <= {24'd0,OutputMEMReg[7:0]}; // LBU Zero Extension
	 end 
	 
	 always @* begin  // Extensión de zero o de signo para Load Byte 1 
		if (~funct3REG[2])
			LoadByte1 <= {{24{OutputMEMReg[15]}},OutputMEMReg[15:8]}; // LB Sign Extension
		else
			LoadByte1 <= {24'd0,OutputMEMReg[15:8]}; // LBU Zero Extension
	 end 
	 
	 always @* begin  // Extensión de zero o de signo para Load Byte 2 
		if (~funct3REG[2])
			LoadByte2 <= {{24{OutputMEMReg[23]}},OutputMEMReg[23:16]}; // LB Sign Extension
		else
			LoadByte2 <= {24'd0,OutputMEMReg[23:16]}; // LBU Zero Extension
	 end 
	 
	 always @* begin  // Extensión de zero o de signo para Load Byte 3 MSB 
		if (~funct3REG[2])
			LoadByte3 <= {{24{OutputMEMReg[31]}},OutputMEMReg[31:24]}; // LB Sign Extension
		else
			LoadByte3 <= {24'd0,OutputMEMReg[31:24]}; // LBU Zero Extension
	 end 
	 
	 
	 
	 
	 always @* begin // Extensión de zero o de signo para Load High Lower
		if(~funct3REG[2])
			LoadHighL <= {{16{OutputMEMReg[15]}},OutputMEMReg[15:0]}; // LH Sign Extension
		else
			LoadHighL <= {16'd0,OutputMEMReg[15:0]}; // LHU Zero Extension
	 end
	 
	 
	 always @* begin // Extensión de zero o de signo para Load High Upper
		if(~funct3REG[2])
			LoadHighH <= {{16{OutputMEMReg[31]}},OutputMEMReg[31:16]}; // LH Sign Extension
		else
			LoadHighH <= {16'd0,OutputMEMReg[31:16]}; // LHU Zero Extension
	 end
		
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadByte0 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(LoadByte0), //***************
    .DataOutput(LoadByte0Reg)  //***************
    );
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadByte1 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(LoadByte1), //***************
    .DataOutput(LoadByte1Reg)  //***************
    );
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadByte2 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(LoadByte2), //***************
    .DataOutput(LoadByte2Reg)  //***************
    );
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadByte3 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(LoadByte3), //***************
    .DataOutput(LoadByte3Reg)  //***************
    );
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadHighL (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(LoadHighL), //***************
    .DataOutput(LoadHighLReg)  //***************
    );
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadHighH (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(LoadHighH), //***************
    .DataOutput(LoadHighHReg)  //***************
    );
	 
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadWord (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(OutputMEMReg), //***************
    .DataOutput(LoadWordReg)  //***************
    );
	 
	 
	 always @(AddressRAMReg[1:0], LoadByte0Reg, LoadByte1Reg, LoadByte2Reg, LoadByte3Reg) begin
      case (AddressRAMReg[1:0])
         2'b00: LoadByte <= LoadByte0Reg;
         2'b01: LoadByte <= LoadByte1Reg;
         2'b10: LoadByte <= LoadByte2Reg;
         2'b11: LoadByte <= LoadByte3Reg;
      endcase
	 end
	 
	 assign LoadHigh = (AddressRAMReg[1:0] == 2'b10) ? LoadHighHReg : LoadHighLReg;
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadByte (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(LoadByte), //***************
    .DataOutput(LoadByteReg)  //***************
    );
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadHigh (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(LoadHigh), //***************
    .DataOutput(LoadHighReg)  //***************
    );
	 
	 RegistroSinEnable #(.Widht(WidthData)) RegistroAlmacenaLoadWord1 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(LoadWordReg), //***************
    .DataOutput(LoadWordReg1)  //***************
    );
	 
	 always @(funct3REG[1:0], LoadWordReg1, LoadHighReg, LoadByteReg) begin
      case (funct3REG[1:0])
         2'b00: DataLoadOutputMEM <= LoadByteReg;  //LB
         2'b01: DataLoadOutputMEM <= LoadHighReg;  //LH
         2'b10: DataLoadOutputMEM <= LoadWordReg1;  //LW
         2'b11: DataLoadOutputMEM <= 32'd0;  // No implementado para 32 bits
      endcase
	end
		
	 RegistroSinEnable #(.Widht(WidthData)) RegistroSalida1 (
    .CLK(CLK),    //**************************
    .Reset(Reset),   //**************************
    .DataInput(DataLoadOutputMEM), //***************
    .DataOutput(DataOutput)  //***************
    );
		
	
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	  





	
	 

	 
	 
	 
    
	
		 
	 

	
	 
	 
	
	 
	 



endmodule
