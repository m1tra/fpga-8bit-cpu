module alu (
    input logic [7:0] left_value,
    input logic [7:0] right_value,
    input logic [2:0] operation,

    output logic [7:0] result,
    output logic N,
    output logic Z,
    output logic V,
    output logic C
);
    
    localparam logic [2:0] 
        ADD_ALU = 3'b000,
        SUB_ALU = 3'b001;

    logic       is_sub;
    logic [7:0] adder_right;
    logic [7:0] adder_result;
    logic       adder_v;
    logic       adder_c;

    assign is_sub = operation == SUB_ALU;
    assign adder_right = is_sub ? ~right_value : right_value;

    adder u_adder (
        .left_value  (left_value),
        .right_value (adder_right),
        .carry_in    (is_sub),
        .result      (adder_result),
        .V           (adder_v),
        .C           (adder_c)
    );

    always_comb begin 
        case(operation)
        
            ADD_ALU: 
                begin
                    result = adder_result;
                    C = adder_c;
                    V = adder_v;
                end

            SUB_ALU: 
                begin
                    result = adder_result;
                    C = ~adder_c;
                    V = adder_v;
                end


            default: 
                begin
                    result = 8'b0;
                    C = 1'b0;
                    V = 1'b0;
                end
        
        endcase
    end

    assign N = result[7];
    assign Z = result == 0 ? 1 : 0;

endmodule