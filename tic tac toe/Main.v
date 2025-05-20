`include "Tcell.v"
`include "Tboard.v"
`include "rcdecoder.v"
// Module: TBox
// Description: Top-level controller for tic-tac-toe.
//              Determines the current state of the game.

module TBox(
    input clk, 
    input set, 
    input reset, 
    input [1:0] row, 
    input [1:0] col, 
    output [8:0] valid, 
    output [8:0] symbol, 
    output [1:0] game_state
);

    wire [8:0] w;
    wire set_symbol;

    // Row-Column decoder
    rcdecoder r1(col, row, set, w);

    // Symbol toggling based on number of valid cells
    assign set_symbol = ~(valid[0] ^ valid[1] ^ valid[2] ^ valid[3] ^ valid[4] ^ valid[5] ^ valid[6] ^ valid[7] ^ valid[8]);

    // Instantiate the board
    tboard t1(clk, w, reset, set_symbol, valid, symbol);

    // Winning conditions for 'X'
    wire w1 = valid[8]&valid[7]&valid[6]&symbol[8]&symbol[7]&symbol[6];
    wire w2 = valid[5]&valid[4]&valid[3]&symbol[5]&symbol[4]&symbol[3];
    wire w3 = valid[2]&valid[1]&valid[0]&symbol[2]&symbol[1]&symbol[0];
    wire w7 = valid[8]&valid[4]&valid[0]&symbol[8]&symbol[4]&symbol[0];
    wire w8 = valid[6]&valid[4]&valid[2]&symbol[6]&symbol[4]&symbol[2];
    wire w13 = valid[8]&valid[5]&valid[2]&symbol[8]&symbol[5]&symbol[2];
    wire w14 = valid[7]&valid[4]&valid[1]&symbol[7]&symbol[4]&symbol[1];
    wire w15 = valid[6]&valid[3]&valid[0]&symbol[6]&symbol[3]&symbol[0];

    // Winning conditions for 'O'
    wire w4 = valid[8]&valid[7]&valid[6]&~symbol[8]&~symbol[7]&~symbol[6];
    wire w5 = valid[5]&valid[4]&valid[3]&~symbol[5]&~symbol[4]&~symbol[3];
    wire w6 = valid[2]&valid[1]&valid[0]&~symbol[2]&~symbol[1]&~symbol[0];
    wire w9 = valid[8]&valid[4]&valid[0]&~symbol[8]&~symbol[4]&~symbol[0];
    wire w10 = valid[6]&valid[4]&valid[2]&~symbol[6]&~symbol[4]&~symbol[2];
    wire w16 = valid[8]&valid[5]&valid[2]&~symbol[8]&~symbol[5]&~symbol[2];
    wire w17 = valid[7]&valid[4]&valid[1]&~symbol[7]&~symbol[4]&~symbol[1];
    wire w18 = valid[6]&valid[3]&valid[0]&~symbol[6]&~symbol[3]&~symbol[0];

    // Check win or draw
    wire w11 = w1 | w2 | w3 | w7 | w8 | w13 | w14 | w15;  // X wins
    wire w12 = w4 | w5 | w6 | w9 | w10 | w16 | w17 | w18; // O wins
    wire w19 = &valid; // All cells valid => board full

    // Game state:
    // game_state[0] = X wins or draw
    // game_state[1] = O wins or draw
    assign game_state[0] = w11 | (~w11 & ~w12 & w19);
    assign game_state[1] = w12 | (~w11 & ~w12 & w19);

endmodule
