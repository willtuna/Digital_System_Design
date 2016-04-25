`include "fsm.v"


module test_fsm;
		reg clk,rst;
		reg [7:0] in;
		
		wire [3:0] d4,d3,d2,d1;
		Calculator_fsm  fsm(clk,rst,in,d4,d2,d2,d1);



		initial begin
		rst = 0; clk =0;
		in = 8'd0;
		

		forever
		#1 clk = ~clk;
		
		end
		



		initial begin
		#5 rst =1'b1;
		#5 rst =1'b0;

		#10
		   in = 8'd3;
		#1000
		   in = 8'd5;
		#1000
		   in = 8'b1000_0010;
		#1000
		   in = 8'd4;
		#1000
		   in = 8'd5;
		#1000
		   in = 8'b0100_1000;
		#1000
		   $stop;



		end




endmodule
