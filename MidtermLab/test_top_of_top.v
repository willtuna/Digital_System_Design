`include "Midterm_Lab_Top.v"

module Test_Top;

    reg		clk,rst;
    reg		[3:0] in;

    wire	[3:0] row_sweep, seven_select;
    wire	[6:0] seven_out;
    
	Midterm_Lab_Top Midterm_Top(clk,rst,in,row_sweep,seven_out,seven_select);
	
	/*initial begin
		$fsdbDumpfile("waveform.fsdb");
		$fsdbDumpvars;
    end*/
    

    initial
    begin
//	outfile= $fopen("OUTPUT.out");
	clk= 1'b0;
	rst= 1'b0;
    in = 4'b0;
    end

    always begin
	#1 clk= ~clk;
    end
    
/*    always@(out)
    begin
	#5 $fdisplay(outfile, "%d out= %b   an=%d\n", $time, out, an);
    end
*/    
    initial 
    begin 
	#1 rst= 1'b1;
    #10 rst = 1'b0;
    #1000000 in =4'b0100;// 1st
    #1000000 in =4'b0000;
    #14000000 in =4'b0100;// 2nd
    #1000000 in =4'b0000;
    #15000000 in =4'b0100;// op
    #1000000 in =4'b0000;
    #16000000 in =4'b1000;// 4th
    #1000000 in =4'b0000;
    #12000000 in =4'b0001;// 5 th
    #1000000 in =4'b0000;
    #11000000 in = 4'b0100;

	#1000000 $stop;
    end
 

endmodule
