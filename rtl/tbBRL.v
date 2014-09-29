//
//File: tbBRL.v
//Device: Hardware Independence
//Created:  2014/9/28 19:30:39
//Description: test bench
//Revisions: 
//2014/9/28 19:30:59: created
//
`timescale 1ns/100ps
// the ModelSim project locates in "../"
`include "rtl/zDefine.v"
module tbBRL ();

	reg clk, rst_n;
	initial
	begin
		clk = `HIGH;
		rst_n = `HIGH;
		#44 rst_n = `LOW;
		#15 rst_n = `HIGH;
	end

	always #1 clk = ~clk;

	reg [31:0] tmp;
	always #4
		tmp = $random;

	reg en;
	wire wave;
	wire end_tick;
	reg [7:0] mem[99:0];
	reg [7:0] cyc_duty;
	reg [7:0] index;
	initial
	begin
		$readmemh("rtl/sine.dat", mem);
		en = `ON;
		index = 8'd0;
	end
	always @(posedge clk)
	begin
		if (end_tick == `ON)
		begin
			if (index == 8'd99)
				index <= 8'd0;
			else
				index <= index + 8'd1;
		end
	end
	always @(posedge clk)
	begin
		cyc_duty <= mem[index];
	end
	zPWM 
	#(///*autoinstparam*/
	  // Parameters
	  .pWIDTH			(10),
	  .pPERIOD			(100),
	  .pINC				(5))
	mzPWM 
	(
	 // Outputs
	 .wave				(wave),
	 // Inputs
	 .en				(en),
	 .clk				(clk),
	 .rst_n				(rst_n),
	 // Outputs
	 .end_tick			(end_tick),
	 // Inputs
	 .cyc_duty			(cyc_duty)
	 /*autoinst*/
	 );
	
endmodule

