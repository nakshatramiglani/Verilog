//synchronizer - 2FF synchronizer can resolve metastability for 1 bit

module synchronizer(
    input clk,
    input nrst,
    input [3:0]ptr_in,
    output reg [3:0]ptr_sync
);

reg [3:0]q1;
always @(posedge clk or negedge nrst) begin
    if(!nrst) begin
        q1 <= 0;
        ptr_sync <=0 ;
    end else begin
        q1 <= ptr_in;
        ptr_sync <= q1; 
    end
end
endmodule

//gray code is assured to have only a single bit change from its previous value
// both write and read pointers need to convert first to their equivalent gray code 
//write pointer handler: 
//find next and full conditions 
module write_ptr(
    input wclk, wrst_n, w_en,
    input [3:0] g_rptr_sync, 
    output reg [3:0] b_wptr, g_wptr, 
    output reg full
);

    wire [3:0] b_wptr_next, g_wptr_next;
    wire wfull;
    assign b_wptr_next = b_wptr + (w_en & ~full); //update write ptr by 1 if enable = 1, it isnt full
    assign g_wptr_next = (b_wptr_next >> 1) ^ b_wptr_next; //convert to gray code
    
    //finding wfull
    always@(posedge wclk or negedge wrst_n) begin
        if(~wrst_n) begin
            b_wptr <= 0; 
            g_wptr <= 0;
            full <= 0;
        end else begin
            b_wptr <= b_wptr_next; // incr binary write pointer
            g_wptr <= g_wptr_next; // incr gray write pointer
            full <= wfull; 
        end
    end
    assign wfull = (g_wptr_next == {~g_rptr_sync[3:2], g_rptr_sync[1:0]}); //2 MSBs switched => full
endmodule

//write pointer handler: 
//find next and empty conditions 
module read_pointer(
    input rclk, rrst_n, r_en,
    input [3:0] g_wptr_sync, 
    output reg [3:0] g_rptr, b_rptr,
    output reg empty
);
    wire [3:0] b_rptr_next, g_rptr_next;
    wire rempty;
     assign b_rptr_next = b_rptr + (r_en & ~empty);
     assign g_rptr_next = (b_rptr_next >> 1) ^ b_rptr_next;

    //finding rempty
    always@(posedge rclk or negedge rrst_n) begin
        if(!rrst_n) begin
            b_rptr <= 0; 
            g_rptr <= 0;
            empty <= 1; 
        end else begin
            b_rptr <= b_rptr_next; // incr binary write pointer
            g_rptr <= g_rptr_next; // incr gray write pointer
            empty <= rempty; 
        end
    end
    assign rempty = (g_wptr_sync == g_rptr_next); 
    //read and write at same location => every location has been read
endmodule

//read and write
module read_write(
    input wclk, w_en,rclk, r_en,
    input [3:0] b_rptr, b_wptr, 
    input [7:0] d_in,
    input full, empty, 
    output [7:0] d_out
);
    reg [7:0] fifo [0:7]; 
    always @(posedge wclk ) begin
        if (w_en & ~full) fifo[b_wptr[2:0]] <= d_in; //MSB bit not imp, 3 bits enough to determine address location
    end
    //read is asynchronous, because rptr conditions were ensured before only
    assign d_out = fifo[b_rptr[2:0]];
endmodule

module topmodule(
    input wclk, wrst_n,
    input rclk, rrst_n,
    input w_en, r_en,
    input [7:0] data_in,
    output [7:0] data_out,
    output full, empty
);
    wire [3:0] g_wptr_sync, g_rptr_sync;
    wire [3:0] b_wptr, b_rptr;
    wire [3:0] g_wptr, g_rptr;

    //synchronising to the opposite clock domain
    synchronizer sync_wptr (rclk, rrst_n, g_wptr, g_wptr_sync); 
    synchronizer sync_rptr (wclk, wrst_n, g_rptr, g_rptr_sync); 

    write_ptr wptr(wclk, wrst_n, w_en, g_rptr_sync, b_wptr, g_wptr, full);
    read_pointer rptr(rclk, rrst_n, r_en, g_wptr_sync, g_rptr, b_rptr, empty);
    read_write readwrite(.wclk(wclk),.w_en(w_en),.rclk(rclk),.r_en(r_en),.b_rptr(b_rptr),.b_wptr(b_wptr),.d_in(data_in),.full(full),.empty(empty),.d_out(data_out));
endmodule