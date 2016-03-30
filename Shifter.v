module shiftleft(n,a,b);// n is the number of bit to shift
parameter k=8;
parameter lk=3;

input [lk-1:0] n; // how much to shift
input [k-1:0] a; // number to shift
output [2*k-2:0] b ;
assign b = a<<n; // at most shift 2^lk bit

endmodule



module Barrel_Shifter(n,a,b)
		parameter k=8;
		parameter lk =3;
		input [lk-1:0] n;
		input [k-1:0] a;
		output [k-1:0] b; // output
		wire [2*k-2:0] x = a<<n; // output before wrapping

		assign b = x[k-1:0] | {1'b0. x[2*k-2:k];
		
endmodule}
