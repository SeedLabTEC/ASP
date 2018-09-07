`timescale 1ns / 1ps


module cpu_tb();
	 reg CLK, Reset;
	 
	 wire WritePPI; // Escritura de un PPI
	 wire [31:0] DataOutputTowardIO; // Bus de datos que ve desde el microprocesador y hacia los PPIs
	 wire [31:0] DataOutput;
	 wire [8:0] AddressOutIO; // Bus de direcciones para apuntar a un PPI en específico
	 wire SingleLED; // Salida del módulo PPI LED
	 reg [31:0] DataInputTowardMicro; // Bus de datos que va hacia el microprocesador, es la salida del multiplexor que selecciona cual PPI le va a hablar al microprocesador
	
	//////////////////////////////////////////////////////////////////////////////////
	 wire [31:0] SalidaDePrueba;
	/////////////////////////////////////////
	
	//****************Instanciación del Micro******************************
	  cpu CPUMain (
    .CLK(CLK),  //********************************
    .Reset(Reset),   //******************************
	 .DataInputTowardMicro(DataInputTowardMicro),//*********
    .AddressOutIO(AddressOutIO),  //*******************
    .DataOutputTowardIO(DataOutputTowardIO), //****************************
    .WritePPI(WritePPI),
	 .SalidaDePrueba(SalidaDePrueba)//*******************
    );
	 
initial begin
#100
CLK = 0;
Reset = 1;
#1
CLK = 0;
Reset = 0;

end
always
#1 CLK = ~CLK;

endmodule
