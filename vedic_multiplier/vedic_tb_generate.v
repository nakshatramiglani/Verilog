`timescale 1ns / 1ps

module tb_vedic_top;

    logic        clk;
    logic [7:0]  sw_a;
    logic [7:0]  sw_b;
    logic [15:0] led_out;

    vedic_top uut (
        .clk(clk),
        .sw_a(sw_a),
        .sw_b(sw_b),
        .led_out(led_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        sw_a = 8'd0;
        sw_b = 8'd0;
        
        repeat(2) @(posedge clk);
        $display("--- Starting FPGA Top Testbench ---");
        sw_a = 8'd10;
        sw_b = 8'd5;
        repeat(3) @(posedge clk); 
        $display("Time=%0t | sw_a = %3d, sw_b = %3d | led_out = %5d", $time, 10, 5, led_out);

        sw_a = 8'd255;
        sw_b = 8'd255;
        repeat(3) @(posedge clk);
        $display("Time=%0t | sw_a = %3d, sw_b = %3d | led_out = %5d", $time, 255, 255, led_out);

        sw_a = 8'd42;
        sw_b = 8'd0;
        repeat(3) @(posedge clk);
        $display("Time=%0t | sw_a = %3d, sw_b = %3d | led_out = %5d", $time, 42, 0, led_out);

        sw_a = 8'd123;
        sw_b = 8'd45;
        repeat(3) @(posedge clk);
        $display("Time=%0t | sw_a = %3d, sw_b = %3d | led_out = %5d", $time, 123, 45, led_out);

        $finish;
    end

endmodule