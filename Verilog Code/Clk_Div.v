`timescale 1ns / 1ps


module Clk_Div(
input clk, //50MHz.
output reg divided_clk = 1 //output signal depending upon the DIVISOR.
    );

localparam divisor = 24999999;

//Formula: divisionValue = 50MHz / ( 2 * desired freq) - 1 => for 1 Hz => "49999999" ////Some Problem With Formula////

//counter code.

integer counterValue = 0;


always @ (posedge clk) //trigger.
begin
	
	if (counterValue == divisor)
		counterValue <= 0; //for reseting the counter.
	else
		counterValue <= counterValue + 1; //incrementing the counter.

end



//divider code based upon the counter.

always @ (posedge clk)
begin
	
	if (counterValue == divisor)
		divided_clk <= ~divided_clk; //flipping the signal on and off per cycle.
	else
		divided_clk <= divided_clk; //keep the previous value if couunter has reached to DIVISOR yet.
		
end


endmodule


