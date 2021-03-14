`timescale 1ns / 1ps


module Four_Way_Traffic_Lights(
input clk,
output wire secclk,

output reg [2:0] TL_1 = 3'b000, //Road 1 Traffic Lights.
output reg [2:0] TL_2 = 3'b000, //Road 2 Traffic Lights. 
output reg [2:0] TL_3 = 3'b000, //Road 3 Traffic Lights.
output reg [2:0] TL_4 = 3'b000, //Road 4 Traffic Lights.

/*
TL_1[2] >>> Green Light
TL_1[1] >>> Yellow Light
TL_1[0] >>> Red Light
*/

output reg PED_1 = 1'b0, //Pedestrian Light for Road 1.
output reg PED_2 = 1'b0, //Pedestrian Light for Road 2.
output reg PED_3 = 1'b0, //Pedestrian Light for Road 3.
output reg PED_4 = 1'b0  //Pedestrian Light for Road 4.
    );

reg [2:0] big_state = 3'b111; 
reg [2:0] state_1 = 3'b000;
reg [2:0] state_2 = 3'b000;
reg [2:0] state_3 = 3'b000;
reg [2:0] state_4 = 3'b000;

integer counter_1 = 0;
integer counter_2 = 0;

localparam divisor_1 = 3;
localparam divisor_2 = 1;


Clk_Div G1 (
.clk(clk),
.divided_clk(secclk)
);


always @ (posedge secclk)
begin

		case (big_state) //FSM for switching between the traffic lights of 4 roads.
		
				
				3'b111: //Initial state: Turning ON all the Red lights.
				begin
							TL_1[0] <= 1'b1; //Turning ON all the Red lights.
							TL_2[0] <= 1'b1;  
							TL_3[0] <= 1'b1;
							TL_4[0] <= 1'b1;
							
							big_state <= 3'b000;
				end	
				
				
				
				////////////////////////////////
				
			
				
				3'b000:
				begin
				case (state_1) //FSM for road 1 traffic lights.
					
					
					3'b000:
					begin
										
							PED_1 <= 1'b0; //Switching traffic lights from the previous road 4.
							TL_4[2] <= 1'b0;
							TL_4[1] <= 1'b0;
							TL_4[0] <= 1'b1;	
							
							TL_1[2] <= 1'b0; //Red light ON for Road 1.
							TL_1[1] <= 1'b0;
							TL_1[0] <= 1'b1;
							PED_2 <= 1'b0;
							
							state_1 <= 3'b001;
							
					end
					
					3'b001:
					begin
							
							TL_1[2] <= 1'b1; //Green light ON for Road 1.
							TL_1[1] <= 1'b0;
							TL_1[0] <= 1'b0;
							PED_2 <= 1'b1;
							
							if (counter_1 == divisor_1) begin
								counter_1 <= 0;
								state_1 <= 3'b010;
								end
								
							else begin
								counter_1 <= counter_1 + 1;
								state_1 <= 3'b001;
								end
					end
					
					3'b010:
					begin
							
							TL_1[2] <= 1'b0; //Yellow light ON for Road 1.
							TL_1[1] <= 1'b1;
							TL_1[0] <= 1'b0;
							PED_2 <= 1'b1;
							
							if (counter_2 == divisor_2) begin
								counter_2 <= 0;
								
								
								big_state <= 3'b001;								
								end
								
							else begin
								counter_2 <= counter_2 + 1;
								state_1 <= 3'b010;
								end
					end
					
				
				endcase
				end
				
				
				////////////////////////////
				
				
					3'b001: //FSM for road 2 traffic lights.
					begin
					case (state_2)
						
						
						3'b000:
						begin
								PED_2 <= 1'b0; //Switching traffic lights from the previous road 1.
								TL_1[2] <= 1'b0;
								TL_1[1] <= 1'b0;
								TL_1[0] <= 1'b1;
								
								TL_2[2] <= 1'b0; //Red light ON for Road 2.
								TL_2[1] <= 1'b0;
								TL_2[0] <= 1'b1;
								PED_3 <= 1'b0;
								
								state_2 <= 3'b001;
								
						end
						
						3'b001:
						begin
								
								TL_2[2] <= 1'b1; //Green light ON for Road 2.
								TL_2[1] <= 1'b0;
								TL_2[0] <= 1'b0;
								PED_3 <= 1'b1;
								
								if (counter_1 == divisor_1) begin
									counter_1 <= 0;
									state_2 <= 3'b010;
									end
									
								else begin
									counter_1 <= counter_1 + 1;
									state_2 <= 3'b001;
									end
						end
						
						3'b010:
						begin
								
								TL_2[2] <= 1'b0; //Yellow light ON for Road 2.
								TL_2[1] <= 1'b1;
								TL_2[0] <= 1'b0;
								PED_3 <= 1'b1;
								
								if (counter_2 == divisor_2) begin
									counter_2 <= 0;
									
									big_state <= 3'b010;
									
									end
									
								else begin
									counter_2 <= counter_2 + 1;
									state_2 <= 3'b010;
									end
						end
						
					
					endcase
					end
				
				
				////////////////////////////
				
				
					3'b010:
					begin
					case (state_3) //FSM for road 3 traffic lights.
						
						
						3'b000:
						begin
								PED_3 <= 1'b0; //Switching traffic lights from the previous road 2.
								TL_2[2] <= 1'b0;
								TL_2[1] <= 1'b0;
								TL_2[0] <= 1'b1;
								
								TL_3[2] <= 1'b0; //Red light ON for Road 3.
								TL_3[1] <= 1'b0;
								TL_3[0] <= 1'b1;
								PED_4 <= 1'b0;
								
								state_3 <= 3'b001;
								
						end
						
						3'b001:
						begin
								
								TL_3[2] <= 1'b1; //Green light ON for Road 3.
								TL_3[1] <= 1'b0;
								TL_3[0] <= 1'b0;
								PED_4 <= 1'b1;
								
								if (counter_1 == divisor_1) begin
									counter_1 <= 0;
									state_3 <= 3'b010;
									end
									
								else begin
									counter_1 <= counter_1 + 1;
									state_3 <= 3'b001;
									end
						end
						
						3'b010:
						begin
								
								TL_3[2] <= 1'b0; //Yellow light ON for Road 3.
								TL_3[1] <= 1'b1;
								TL_3[0] <= 1'b0;
								PED_4 <= 1'b1;
								
								if (counter_2 == divisor_2) begin
									counter_2 <= 0;
									
									big_state <= 3'b100;
									
									end
									
								else begin
									counter_2 <= counter_2 + 1;
									state_3 <= 3'b010;
									end
						end
					
					endcase
					end
				
				
				////////////////////////////
				
				
					3'b100:
					begin
					case (state_4) //FSM for road 4 traffic lights.
							
							
							3'b000:
							begin
									PED_4 <= 1'b0; //Switching traffic lights from the previous road 3.
									TL_3[2] <= 1'b0;
									TL_3[1] <= 1'b0;
									TL_3[0] <= 1'b1;
									
									TL_4[2] <= 1'b0; //Red light ON for Road 4.
									TL_4[1] <= 1'b0;
									TL_4[0] <= 1'b1;
									PED_1 <= 1'b0;
									
									state_4 <= 3'b001;
									
							end
							
							3'b001:
							begin
									
									TL_4[2] <= 1'b1; //Green light ON for Road 4.
									TL_4[1] <= 1'b0;
									TL_4[0] <= 1'b0;
									PED_1 <= 1'b1;
									
									if (counter_1 == divisor_1) begin
										counter_1 <= 0;
										state_4 <= 3'b010;
										end
										
									else begin
										counter_1 <= counter_1 + 1;
										state_4 <= 3'b001;
										end
							end
							
							3'b010:
							begin
									
									TL_4[2] <= 1'b0; //Yellow light ON for Road 4.
									TL_4[1] <= 1'b1;
									TL_4[0] <= 1'b0;
									PED_1 <= 1'b1;
									
									if (counter_2 == divisor_2) begin
										counter_2 <= 0;
										
										big_state <= 3'b000; //Returning back to Road 1 lights.
										
										state_1 <= 3'b000; //Initializing ALL state variables for the Roads.
										state_2 <= 3'b000;
										state_3 <= 3'b000;
										state_4 <= 3'b000;
										end
										
									else begin
										counter_2 <= counter_2 + 1;
										state_4 <= 3'b010;
										end
							end
							
						
					endcase
					end

		
		endcase
end

endmodule

