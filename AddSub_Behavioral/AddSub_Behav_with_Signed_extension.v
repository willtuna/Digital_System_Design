module AddSub_Beh_with_Singed_ext(a,b,sub,s,ovf);
		parameter n = 8;		
		parameter m = 4;


		input [n-1:0] a;
		input [m-1:0] b;

		wire [n-1:0] ext_b    = {   {n-m+1{b[m-1]}}  , b[m-2:0]}; //  extend the MSB of b;
		//                n-m+1  ----------   +1  is for MSB itself
		

		input sub;
		output [n-1:0] s;
		output ovf;

		wire c1,c2 ; // c1 for cout_n-1,  c2 for cout_n
		assign ovf = c1 ^ c2; // overflow detector

		// adding non sign bits
		assign {c1,s[n-2:0]}  =  a[n-2:0] + (ext_b[n-2:0] ^ {n-1{sub}}) + sub;
		// adding signed bits
		assign {c2, s[n-1] } = a[n-1] + (ext_b[n-1]^ sub) + c1;
endmodule
