// Module: tboard
// Description: Tic-tac-toe board made of 9 TCell modules.

module tboard(
    input clk,
    input [8:0] c,
    input reset,
    input set_symbol,
    output [8:0] valid,
    output [8:0] symbol
);

    TCell t1(clk, c[8], reset, set_symbol, valid[8], symbol[8]);
    TCell t2(clk, c[7], reset, set_symbol, valid[7], symbol[7]);
    TCell t3(clk, c[6], reset, set_symbol, valid[6], symbol[6]);
    TCell t4(clk, c[5], reset, set_symbol, valid[5], symbol[5]);
    TCell t5(clk, c[4], reset, set_symbol, valid[4], symbol[4]);
    TCell t6(clk, c[3], reset, set_symbol, valid[3], symbol[3]);
    TCell t7(clk, c[2], reset, set_symbol, valid[2], symbol[2]);
    TCell t8(clk, c[1], reset, set_symbol, valid[1], symbol[1]);
    TCell t9(clk, c[0], reset, set_symbol, valid[0], symbol[0]);

endmodule
