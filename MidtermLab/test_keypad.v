`include "Column_Row_Shifter.v"

module Test_keypad;

    reg clk, rst;
	reg [3:0]in ;
	wire [7:0]press_pos;
	wire [3:0] row_select;
	wire [7:0] enc_out;
    Keypad_Top keypad(clk, rst, in, row_select,enc_out);
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
    #1000000 in =4'b0100;
    #5000000 in =4'b0000;
    #1000000 in =4'b0100;
    #1000000 in =4'b0000;
    #1000000 in =4'b0100;
    #1000000 in =4'b0000;
    #5000000 in =4'b1000;
    #1000000 in =4'b0000;
    #1000000 in =4'b0001;
    #1000000 in =4'b0000;
	#1000000 $stop;
    end
 

endmodule
