module Multi_Input_Adder(a,b,c,d,e,f, out);
		// 5-bit input  total 6 inputs
		input [4:0] a,b,c ,d,e,f;
		output [5:0] out;
		wire [4:0] temp1,temp2,temp3,temp4;
		wire [5:0]	layer2_1, layer2_2;   
		wire [6:0] bit1_sum,  bit1_carry;

//          Carry Save Adder
		// first layer half adder 5 bit
		FA #(2) bit1forabc (.a(a[0]), .b(b[0]), .c(c[0]),  .cout(temp1[0], .s(temp2[0] );
		FA #(2) bit2forabc (.a(a[1]), .b(b[1]), .c(c[1]),  .cout(temp1[1], .s(temp2[1] );
		FA #(2) bit3forabc (.a(a[2]), .b(b[2]), .c(c[2]),  .cout(temp1[2], .s(temp2[2] );
		FA #(2) bit4forabc (.a(a[3]), .b(b[3]), .c(c[3]),  .cout(temp1[3], .s(temp2[3] );
		FA #(2) bit5forabc (.a(a[4]), .b(b[4]), .c(c[4]),  .cout(temp1[4], .s(temp2[4] );
						
		FA #(2) bit1fordef (.d(d[0]), .e(e[0]), .f(f[0]),  .cout(temp3[0], .s(temp4[0] );
		FA #(2) bit2fordef (.d(d[1]), .e(e[1]), .f(f[1]),  .cout(temp3[1], .s(temp4[1] );
		FA #(2) bit3fordef (.d(d[2]), .e(e[2]), .f(f[2]),  .cout(temp3[2], .s(temp4[2] );
		FA #(2) bit4fordef (.d(d[3]), .e(e[3]), .f(f[3]),  .cout(temp3[3], .s(temp4[3] );
		FA #(2) bit5fordef (.d(d[4]), .e(e[4]), .f(f[4]),  .cout(temp3[4], .s(temp4[4] );
		//  second layer half adder	6 bit
		
		FA #(2) bit1fortemp123 (.a(1'b0),     .b(temp2[0]), .c(1'b0),      .cout(layer2_1[0], .s(layer2_2[0] );
		FA #(2) bit1fortemp123 (.a(temp1[0]), .b(temp2[1]), .c(temp3[0]),  .cout(layer2_1[1], .s(layer2_2[1] );
		FA #(2) bit2fortemp123 (.a(temp1[1]), .b(temp2[2]), .c(temp3[1]),  .cout(layer2_1[2], .s(layer2_2[2] );
		FA #(2) bit3fortemp123 (.a(temp1[2]), .b(temp2[3]), .c(temp3[2]),  .cout(layer2_1[3], .s(layer2_2[3] );
		FA #(2) bit4fortemp123 (.a(temp1[3]), .b(temp2[4]), .c(temp3[3]),  .cout(layer2_1[4], .s(layer2_2[4] );
		FA #(2) bit5fortemp123 (.a(temp1[4]), .b(1'b0),     .c(temp3[4]),  .cout(layer2_1[5], .s(layer2_2[5] );
		//  third layer half adder  7 bit

		FA #(2) bit1forlayer2andtemp4 (.a(1'b0)       , .b(layer2_2[0]), .c(temp4[0]),  .cout(bit1_sum[0], .s(bit1_carry[0] );
		FA #(2) bit2forlayer2andtemp4 (.a(layer2_1[0]), .b(layer2_2[1]), .c(temp4[1]),  .cout(bit1_sum[1], .s(bit1_carry[1] );
		FA #(2) bit3forlayer2andtemp4 (.a(layer2_1[1]), .b(layer2_2[2]), .c(temp4[2]),  .cout(bit1_sum[2], .s(bit1_carry[2] );
		FA #(2) bit4forlayer2andtemp4 (.a(layer2_1[2]), .b(layer2_2[3]), .c(temp4[3]),  .cout(bit1_sum[3], .s(bit1_carry[3] );
		FA #(2) bit5forlayer2andtemp4 (.a(layer2_1[3]), .b(layer2_2[4]), .c(temp4[4]),  .cout(bit1_sum[4], .s(bit1_carry[4] );
		FA #(2) bit1forlayer2andtemp4 (.a(layer2_1[4]), .b(layer2_2[5]), .c(1'b0)    ,  .cout(bit1_sum[5]) .s(bit1_carry[5] );
		FA #(2) bit1forlayer2andtemp4 (.a(layer2_1[5]), .b(1'b0)       , .c(1'b0)    ,  .cout(bit1_sum[6]) .s(bit1_carry[6] );
//            In Carry Save Half Adder , propagate 63 layer device


//          Propagationd adder
		FA #(7) PropagationAdd (.a(bit1_sum) , .b(bit1_carry) , 1'b0 , out[5], out[4:0] );
		// In propagation adder,  propagate 5 fa ripple


//  Total 8 propagation time,              original need 30 propagation time

//		Saving Multiple Adder's Propagation Time for each adding


endmodule
