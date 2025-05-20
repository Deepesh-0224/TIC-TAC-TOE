// Module: TCell
// Description: Represents a single cell of the tic-tac-toe board.
//              Stores the symbol and validity state.

module TCell(input clk, set, reset, set_symbol, output reg valid, symbol);
    
    // Initialization
    initial begin
        valid = 1'b0; 
    end

    // Behavior on clock's positive edge
    always @ (posedge clk) begin
        // Resetting the cell
        if (reset) begin
            valid = 1'b0;
        end
        else begin
            // Set symbol only if cell is not already valid
            if (set & !valid) begin
                symbol = set_symbol;
                valid = 1'b1;
            end
        end
    end

endmodule
