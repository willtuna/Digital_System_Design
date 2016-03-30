module AddSub_Beh(a,b,sub,s,ovf);
		parameter n = 8;		
		input [n-1:0] a,b;
		input sub;
		output [n-1:0] s;
		output ovf;

		wire c1,c2 ; // c1 for cout_n-1,  c2 for cout_n
		assign ovf = c1 ^ c2; // overflow detector

		// adding non sign bits
		assign {c1,s[n-2:0]}  =  a[n-2:0] + (b[n-2:0] ^ {n-1{sub}}) + sub;
		// adding signed bits
		assign {c2, s[n-1] } = a[n-1] + (b[n-1]^ sub) + c1;
endmodule
