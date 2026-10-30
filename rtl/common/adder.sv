module adder (
    input logic [7:0] left_value,
    input logic [7:0] right_value,
    input carry_in,
    
    output logic [7:0] result,
    output logic V,
    output logic C

);

    logic [8:0] carry;

    assign carry[0] = carry_in;

    for (genvar i = 0; i < 8; i++) begin : adder
        
        assign result[i] = left_value[i] ^ right_value[i] ^ carry[i];

        assign carry[i + 1] = 
            (left_value[i] & right_value[i]) |
            (left_value[i] & carry[i]) |
            (carry[i] & right_value[i])
        ;

    end

    assign C = carry[8];
    assign V = carry[7] ^ carry[8];
    
endmodule