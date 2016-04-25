`include "UniversalBCD.v"
`include "calculation.v"
`include "Column_Row_Shifter.v"

`define state_ini    7'b000_0001
`define store_1stD1  7'b000_0010
`define store_1stD0  7'b000_0100
`define store_op     7'b000_1000
`define store_2ndD1  7'b001_0000
`define store_2ndD0  7'b010_0000
`define EqualPressed 7'b100_0000






module Calculator_fsm(clk,rst,in,digit4,digit3,digit2,digit1);
    input clk,rst;
	input [7:0] in;

	output reg [3:0] digit4,digit3,digit2,digit1;

	reg [6:0] next_st, state;
    reg [7:0] A1,A0,B1,B0,OP;     // storage the in in differnet state
	//wire Unpressed = &in;
     wire in_not_0 = (&in)^1'b1; // (&in) means no value input



// ----------  Turn into wrie for CL of calculation module  ------
    wire [7:0] a1,a0,b1,b0,op;
    assign   a1=A1 ;
    assign   a0=A0 ;  
    assign	 op=OP ;
    assign   b1=B1 ;
    assign   b0=B0 ;
//------------------------------------------

    wire [13:0] answer;
	wire [15:0] ans_BCD;
	calculation cal(rst,a1,a0,op,b1,b0,answer);
    UniversalBCD result_to_BCD(answer,ans_BCD);

//----------------------------------------------------------------------




//--------------------- DFF -----------------------------------
    always@(posedge clk or posedge rst)begin
		if(rst)
				state = `state_ini ;
		else
				state = next_st;

	end
//------------------------------------------------------------



//---------------  Next State Combination Circuit----------------------------
	always@(in)begin
		case(state)
		  `state_ini : begin 
				next_st =  `state_ini;
				
				if(in)begin 
				A1  = rst ?  8'bz : in; // assign to reg
				//  show sevenseg  BCD(rst,in,out)
				{digit4,digit3,digit2,digit1} = {4'bz,4'bz,4'bz,A1[3:0]}; 
				end

		   end
		   `store_1stD1: begin
				next_st = `store_1stD1;
				
				if(in)begin
				A0 = rst ?  8'bz : in;
				//  show_sevenseg BCD
				{digit4,digit3,digit2,digit1} = {4'bz,4'bz,A1[3:0],A0[3:0]};
				end

		   end
		   `store_1stD0: begin  //   there is no dummy avoidance !!!!!!
				next_st = `store_1stD0;
				if(in_not_0 ) OP =  rst ?  8'bz : in;
				// No need to show
		   end
		   `store_op   : begin
				next_st= `store_op;
				if(in)begin
				B1 =  rst ?  8'bz : in;
				//show
				{digit4,digit3,digit2,digit1} = {4'bz,4'bz,4'bz,B1[3:0]};
				end

		   end
		   `store_2ndD1: begin
				next_st = `store_2ndD1;
				if(in)begin
				B0 =  rst ?  8'bz : in;					
				//show
				{digit4,digit3,digit2,digit1} = {4'bz,4'bz,B1[3:0],B0[3:0]};
				end

		   end
		   `store_2ndD0: begin
				next_st = (in == `E_qual ) ? `EqualPressed  : `store_2ndD0;
				//no need to show
				
		   end
		   `EqualPressed: begin
				//  combinational logic to calculate the result
				{digit4,digit3,digit2,digit1} = ans_BCD;
				// show
		   end
		endcase


    end




endmodule



