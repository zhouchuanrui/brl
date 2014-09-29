//
//File: zPWM.v
//Device: Hardware Independence
//Created:  2014/9/28 19:24:26
//Description: a PWM wave generation module
//Revisions: 
//2014/9/28 19:25:44: created
//
`include "zDefine.v"
module zPWM 
#(
//parameter declaration
	parameter
		pWIDTH = 20,
		pPERIOD = 1000_000,
		pINC = 20
)
(
	input wire en,
	input wire clk, rst_n,
	input wire [pWIDTH-1:0] cyc_duty,
	output reg end_tick = `OFF,
	output reg wave = `LOW
);

// the main counter block
// pPERIOD indicates the period of the counter with the unit ns
// pINC is the incremental unit with the uint ns
	reg	[pWIDTH-1:0] cnt;
	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n)
			cnt <= {(pWIDTH){1'b0}};
		else if (en == `ON)
			if (cnt >= pPERIOD - pINC)
				cnt <= {(pWIDTH){1'b0}};
			else
				cnt <= cnt + pINC;
		else 
			cnt <= {(pWIDTH){1'b0}};
	end

// the wave output 
	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n)
			wave <= `LOW;
		else if (cnt >= cyc_duty)
			wave <= `LOW;
		else
			wave <= `HIGH;
	end

	always @(posedge clk)
	begin
		if (cnt >= pPERIOD - pINC)
			end_tick <= `ON;
		else
			end_tick <= `OFF;
	end

endmodule

