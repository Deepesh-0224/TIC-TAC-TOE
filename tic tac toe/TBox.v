module TCell(input clk, set, reset,set_symbol, output reg valid,symbol);
//intialization
initial begin
   valid=1'b0; 
end

always @ (posedge clk)begin
    //resetting
    if(reset)begin
        valid=1'b0;
    end
    else begin
        if(set & !valid)begin
            symbol=set_symbol;
            valid=1'b1;
        end
    end
end
endmodule
//row col decoder
module rcdecoder(input [1:0]col,row,input set,output [8:0]c);
assign c[8]=((~row[1]&row[0]&col[0]&~col[1]))&set;
assign c[7]=(row[1]&~row[0]&col[0]&~col[1])&set;
assign c[6]=(row[1]&row[0]&col[0]&~col[1])&set;
assign c[5]=(~row[1]&row[0]&~col[0]&col[1])&set;
assign c[4]=(row[1]&~row[0]&~col[0]&col[1])&set;
assign c[3]=(row[1]&row[0]&~col[0]&col[1])&set;
assign c[2]=(~row[1]&row[0]&col[0]&col[1])&set;
assign c[1]=(row[1]&~row[0]&col[0]&col[1])&set;
assign c[0]=(row[1]&row[0]&col[0]&col[1])&set;
endmodule
//tic tac toe board
module tboard(input clk,input [8:0]c,input reset,input set_symbol,output [8:0]valid,output [8:0]symbol);
    TCell t1 (clk,c[8], reset, set_symbol, valid[8], symbol[8]);
    TCell t2 (clk,c[7], reset, set_symbol, valid[7], symbol[7]);
    TCell t3 (clk,c[6], reset, set_symbol, valid[6], symbol[6]);
    TCell t4 (clk,c[5], reset, set_symbol, valid[5], symbol[5]);
    TCell t5 (clk,c[4], reset, set_symbol, valid[4], symbol[4]);
    TCell t6 (clk,c[3], reset, set_symbol, valid[3], symbol[3]);
    TCell t7 (clk,c[2], reset, set_symbol, valid[2], symbol[2]);
    TCell t8 (clk,c[1], reset, set_symbol, valid[1], symbol[1]);
    TCell t9 (clk,c[0], reset, set_symbol, valid[0], symbol[0]);
endmodule

module TBox(input clk, set, reset, input [1:0] row, input [1:0] col, output [8:0] valid, output [8:0] symbol, output [1:0] game_state);
    wire [8:0]w;
    wire set_symbol;
    rcdecoder r1(col,row,set,w);
    assign set_symbol=~(valid[0]^valid[1]^valid[2]^valid[3]^valid[4]^valid[5]^valid[6]^valid[7]^valid[8]);
    tboard t1(clk,w,reset,set_symbol,valid,symbol);
    wire w1,w2,w3,w4,w5,w6,w7,w8;
    //conditions for winning x row wise
    assign w1=valid[8]&valid[7]&valid[6]&symbol[8]&symbol[7]&symbol[6];
    assign w2=valid[5]&valid[4]&valid[3]&symbol[5]&symbol[4]&symbol[3];
    assign w3=valid[2]&valid[1]&valid[0]&symbol[2]&symbol[1]&symbol[0];
    //conditions for winning o row wise
    assign w13=valid[8]&valid[5]&valid[2]&symbol[8]&symbol[5]&symbol[2];
    assign w14=valid[7]&valid[4]&valid[1]&symbol[7]&symbol[4]&symbol[1];
    assign w15=valid[6]&valid[3]&valid[0]&symbol[6]&symbol[3]&symbol[0];
    //conditions for winning x col wise
    assign w4=valid[8]&valid[7]&valid[6]&~symbol[8]&~symbol[7]&~symbol[6];
    assign w5=valid[5]&valid[4]&valid[3]&~symbol[5]&~symbol[4]&~symbol[3];
    assign w6=valid[2]&valid[1]&valid[0]&~symbol[2]&~symbol[1]&~symbol[0];
    //conditions for winning o col wise
    assign w16=valid[8]&valid[5]&valid[2]&~symbol[8]&~symbol[5]&~symbol[2];
    assign w17=valid[7]&valid[4]&valid[1]&~symbol[7]&~symbol[4]&~symbol[1];
    assign w18=valid[6]&valid[3]&valid[0]&~symbol[6]&~symbol[3]&~symbol[0];
    //conditions for winning x diagnolly
    assign w7=valid[8]&valid[4]&valid[0]&symbol[8]&symbol[4]&symbol[0];
    assign w8=valid[6]&valid[4]&valid[2]&symbol[6]&symbol[4]&symbol[2];
    //conditions for winning o diagnolly
    assign w9=valid[8]&valid[4]&valid[0]&~symbol[8]&~symbol[4]&~symbol[0];
    assign w10=valid[6]&valid[4]&valid[2]&~symbol[6]&~symbol[4]&~symbol[2];
    //check-win or draw or continue
    assign w11=w1|w2|w3|w7|w8|w13|w14|w15;
    assign w12=w4|w5|w6|w9|w10|w16|w17|w18;
    assign w19=&valid;
    assign game_state[0]=w11|(~w11&~w12&w19);
    assign game_state[1]=w12|(~w11&~w12&w19);
endmodule