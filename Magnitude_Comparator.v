module MagComp (a,b,gt);//  bit - slice version  ---- would have a lot of ripple
		parameter k =8;
		input [k-1:0] a,b;
		output gt;
		wire [k-1:0] eqi = a ~^ b; // exclusive nor
		wire [k-1:0] gti = a & ~b; // a is 1  b is 0
		wire [k:0] gtb = {  (   (eqi[k-1:0] & gtb[k-1:0]) | gti[k-1:0] ),1'b0 };
		assign gt = gtb[k];   // all the result would pass from LSB upward to MSB and then to gtb[k]

endmodule

module MagCompare_Behavioral(a,b,gt);
		parameter k= 8;
		input [k-1:0] a,b;
		output gt;

		assign gt = (a>b);  // it's much more convenient to use assgin operator for comparater
endmodule



