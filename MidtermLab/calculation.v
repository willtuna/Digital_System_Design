`include "Column_Row_Shifter.v" // for input table
module calculation(rst,A1,A0,OP,B1,B0,out);
		input [7:0]A1,A0,B1,B0,OP,rst;
		
		output reg out;
		reg [13:0] out_temp;

		reg [13:0] A,B;

		
		always@(*)begin
				A = rst ? 14'b0  : (A1*10 + A0);
				B = rst ? 14'b0  : (B1*10 + B0);

				case(OP)
				`A_add:
						out = A + B;
				`B_sub:
						out = A - B;
				`f_mult:
						out = A * B;

				//`D_ivid:
				default:
						out = 14'bz;
				endcase
		end

endmodule
