// Module: rcdecoder
// Description: Decodes 2-bit row and 2-bit column into one-hot 9-bit output.

module rcdecoder(input [1:0] col, row, input set, output [8:0] c);

    assign c[8] = ((~row[1] & row[0] &  col[0] & ~col[1])) & set;
    assign c[7] = ( row[1] & ~row[0] &  col[0] & ~col[1]) & set;
    assign c[6] = ( row[1] &  row[0] &  col[0] & ~col[1]) & set;
    assign c[5] = ((~row[1] & row[0] & ~col[0] &  col[1])) & set;
    assign c[4] = ( row[1] & ~row[0] & ~col[0] &  col[1]) & set;
    assign c[3] = ( row[1] &  row[0] & ~col[0] &  col[1]) & set;
    assign c[2] = ((~row[1] & row[0] &  col[0] &  col[1])) & set;
    assign c[1] = ( row[1] & ~row[0] &  col[0] &  col[1]) & set;
    assign c[0] = ( row[1] &  row[0] &  col[0] &  col[1]) & set;

endmodule
