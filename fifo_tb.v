

`timescale 1ns/1ps

module FIFO_tb();

    reg [7:0] wdata;  
    wire [7:0] rdata; 
    wire wfull, rempty;    
    reg winc, rinc, wclk, rclk, wrst_n, rrst_n; 
    topmodule as_fifo (.wclk(wclk), .wrst_n(wrst_n), .rclk(rclk), .rrst_n(rrst_n), .w_en(winc), .r_en(rinc), .data_in(wdata), .data_out(rdata), .full(wfull), .empty(rempty));

    integer i = 0;
    integer seed = 1;

    always @(posedge wclk) begin
        #1
        if (winc && !wfull)
            $display("[%0t] WRITE : data=%h", $time, wdata);

        if (winc && wfull)
            $display("[%0t] WRITE BLOCKED : FIFO FULL", $time);
    end

    always @(posedge rclk) begin
        #1
        if (rinc && !rempty)
            $display("[%0t] READ : data=%h", $time, rdata);

        if (rinc && rempty)
            $display("[%0t] READ BLOCKED : FIFO EMPTY", $time);
    end
    
    always #5 wclk = ~wclk;  
    always #10 rclk = ~rclk;  
        // Initialize all signals
        initial begin
        wclk = 0;
        rclk = 0;
        wrst_n = 1;  
        rrst_n = 1;   
        winc = 0;
        rinc = 0;
        wdata = 0;

        // Reset the FIFO
        #40 wrst_n = 0; rrst_n = 0;
        #40 wrst_n = 1; rrst_n = 1;

        // Write data and read it back
        rinc = 1;
        for (i = 0; i < 10; i = i + 1) begin
            wdata = $random(seed) % 256;
            winc = 1;
            #10;
            winc = 0;
            #10;
        end

        //  Write data to make FIFO full 
        rinc = 0;
        winc = 1;
        for (i = 0; i < 11; i = i + 1) begin
            wdata = $random(seed) % 256;
            #10;
        end

        //  Read data from empty FIFO 
        winc = 0;
        rinc = 1;
        for (i = 0; i < 11; i = i + 1) begin
            #20;
        end

        $finish;
    end

endmodule
