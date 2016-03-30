module multi_bit_adder(a,b,cin,cout,s);
		parameter n =8;


		input [n-1:0] a,b;
		input cin;
		output cout;
		output [n-1:0]s;

		wire [n-1:0] p = a ^ b;  // carry propagation enable   : p
		wire [n-1:0] g = a & b;  // carry generate at current stage (carry generate) : g
		wire [n:0] c =  { (g | (p & c[n-1:0]))  ,cin}; //  AND (propagate enable , cin ) become propagation carry
		//  OR (propagation carry , carry generate ) become cout
		assign s = g ^ c[n-1:0];
		assign cout = c[n];



endmodule
