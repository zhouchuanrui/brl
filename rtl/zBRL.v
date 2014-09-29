//
//File: zBRL.v
//Device: Hardware Independence
//Created:  2014/9/29 17:19:30
//Description: the breathing lamp module
//Revisions: 
//2014/9/29 17:20:04: created
//
`include "zDefine.v"
module zBRL 
#(
//parameter declaration
	parameter
		pCLK_FQ = 50,
		pCARRIER_PRD = 20
)
(
	input wire en, clk, rst_n,

	output wire wave
);

	localparam
		pINC = 1000/pCLK_FQ,
		pPERIOD = 1000_000,
		pWIDTH = 20;

	reg [pWIDTH-1:0] cyc_duty = {(pWIDTH){1'b0}};
	wire end_tick;
	zPWM 
	#(///*autoinstparam*/
	  // Parameters
	  .pWIDTH			(pWIDTH),
	  .pPERIOD			(pPERIOD),
	  .pINC				(pINC))
	mzPWM 
	(
	 // Outputs
	 .end_tick			(end_tick),
	 .wave				(wave),
	 // Inputs
	 .en				(en),
	 .clk				(clk),
	 .rst_n				(rst_n),
	 .cyc_duty			(cyc_duty)
	/*autoinst*/
	);
	
// use mem as a rom 
// use the sine.dat file to initialize mem
	reg [19:0] mem[199:0];
	initial
	begin
		$readmemh("rtl/sine.dat", mem);
	end

	reg [9:0] cnt_tick = 10'd1;
	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n)
		begin
			cnt_tick <= 10'd1;
		end
		else if (end_tick == `ON)
		begin
			if (cnt_tick == pCARRIER_PRD)
				cnt_tick <= 10'd1;
			else
				cnt_tick <= cnt_tick + 10'd1;
		end
	end

// index_tick ticks when end_tick ticks pCARRIER_PRD times
	reg index_tick = `OFF;
	always @(posedge clk)
	begin
		if (cnt_tick == pCARRIER_PRD)
			index_tick <= `ON;
		else
			index_tick <= `OFF;
	end

// index increases at index_tick 
	reg [7:0] index = 8'd0;
	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n)
		begin
			index <= 8'd0;
		end
		else if ((index_tick == `ON)&&(end_tick == `ON))
		begin
			if (index == 8'd199)
				index <= 8'd0;
			else
				index <= index + 8'd1;
		end
	end

	always @(posedge clk)
	begin
		cyc_duty <= mem[index];
	end

endmodule

