`timescale 1ns/1ps

module alu_tb;

    logic [7:0] left_value;
    logic [7:0] right_value;
    logic [2:0] operation;

    logic [7:0] result;
    logic N;
    logic Z;
    logic V;
    logic C;

    alu ALU_UT (
        .left_value  (left_value),
        .right_value (right_value),
        .operation   (operation),
        .result      (result),
        .V           (V),
        .C           (C),
        .Z           (Z),
        .N           (N)
    );


    initial begin
        
        left_value = 1;
        right_value = 2;
        operation = 0;

        #20ns;

        if (result === 8'd3 &&
            C === 1'b0 && V === 1'b0 &&
            Z === 1'b0 && N === 1'b0) 
            begin
                $display("SUCCESS: test passed");
            end else begin
                $error("FAIL: result=%0d C=%b V=%b Z=%b N=%b",
                        result, C, V, Z, N);
            end

        $finish;

    end
    

endmodule