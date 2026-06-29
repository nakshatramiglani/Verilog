`include "vedic-generate.v"

module vedic_top (
    input  logic        clk,     
    input  logic [7:0]  sw_a,    
    input  logic [7:0]  sw_b,   
    output logic [15:0] led_out
);

    logic [7:0]  a_reg, b_reg;
    logic [15:0] mult_result;

    vedic_multiplier #(
        .N(8)
    ) u_vedic_mult (
        .a(a_reg),
        .b(b_reg),
        .result(mult_result)
    );

    always_ff @(posedge clk) begin
        a_reg   <= sw_a;
        b_reg   <= sw_b;
        led_out <= mult_result;
    end

endmodule