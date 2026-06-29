module vedic_multiplier #(
    parameter int N = 8
)(
    input  logic [N-1:0] a,
    input  logic [N-1:0] b,
    output logic [2*N-1:0] result
);

logic [N-1:0] pp [N]; 

genvar g_r, g_c, g_k;

generate
    for (g_r = 0; g_r < N; g_r++) begin : ROW
        for (g_c = 0; g_c < N; g_c++) begin : COL
            assign pp[g_r][g_c] = a[g_r] & b[g_c];
        end
    end
endgenerate

int unsigned raw_col_sum [2*N-1];

generate
    for (g_k = 0; g_k < 2*N - 1; g_k++) begin : DIAG
        localparam int START_IDX = (g_k > N - 1) ? (g_k - (N - 1)) : 0;
        localparam int END_IDX   = (g_k < N - 1) ? g_k : (N - 1);
        
        always_comb begin
            int sum;
            sum = 0;
            for (int r = START_IDX; r <= END_IDX; r++) begin
                sum += pp[r][g_k - r]; 
            end
            raw_col_sum[g_k] = sum;
        end
    end
endgenerate

always_comb begin
    int unsigned carry;
    int unsigned final_sum;
    
    result = '0;
    carry  = 0;

    for (int k = 0; k < 2*N - 1; k++) begin
        final_sum = raw_col_sum[k] + carry;
        
        result[k] = final_sum[0];
        carry     = final_sum >> 1;
    end
    
    result[2*N-1] = carry[0];
end

endmodule