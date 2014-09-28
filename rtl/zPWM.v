//
//File: zPWM.v
//Device: Hardware Independence
//Created:  2014/9/28 19:24:26
//Description: a PWM generation module
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
	output reg wave = `LOW
);

	reg	[pWIDTH-1:0] cnt;
	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n)
			cnt <= {(pWIDTH){1'b0}};
		else if (en == `ON)
			if (cnt == pPERIOD-pINC)
				cnt <= {(pWIDTH){1'b0}};
			else
				cnt <= cnt + pINC;
		else 
			cnt <= {(pWIDTH){1'b0}};
	end

endmodule

