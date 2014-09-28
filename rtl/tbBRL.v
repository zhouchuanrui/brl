//
//File: tbBRL.v
//Device: Hardware Independence
//Created:  2014/9/28 19:30:39
//Description: test bench
//Revisions: 
//2014/9/28 19:30:59: created
//
`timescale 1ns/100ps
`include "zDefine.v"
module tbBRL ();

	reg clk;
	initial
	begin
		clk = `HIGH;
	end

	always #1 clk = ~clk;

	reg [31:0] tmp;
	always #4
		tmp = $random;

	zPWM mzPWM 
	(/*autoinst*/
	 // Outputs
	 .wave				(wave),
	 // Inputs
	 .en				(en),
	 .clk				(clk),
	 .rst_n				(rst_n));

endmodule

