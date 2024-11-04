module apb2custom (
    input                       clk                             ,
    input                       resetn                          ,

    // left
    input   wire [31:0]         io_apbOut_PADDR                 ,
    input   wire [0:0]          io_apbOut_PSEL                  ,
    input   wire                io_apbOut_PENABLE               ,
    output  wire                io_apbOut_PREADY                ,
    input   wire                io_apbOut_PWRITE                ,
    input   wire [31:0]         io_apbOut_PWDATA                ,
    output  wire [31:0]         io_apbOut_PRDATA                ,
    output  wire                io_apbOut_PSLVERROR             ,

    // right
	output  reg                 mem_valid                       ,
	input                       mem_ready                       ,

	output  reg     [31:0]      mem_addr                        ,
	output  reg     [31:0]      mem_wdata                       ,
	output  reg     [ 3:0]      mem_wstrb                       ,
	input           [31:0]      mem_rdata                       
);

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        mem_valid   <=  'd0 ;
    else if(mem_valid && mem_ready)
        mem_valid   <=  'd0 ;
    else if(io_apbOut_PSEL)
        mem_valid   <=  'd1 ;
end

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        mem_addr    <=  'd0 ;
    else if(io_apbOut_PSEL)
        mem_addr    <=  io_apbOut_PADDR ;
end

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        mem_wdata   <=  'd0 ;
    else if(io_apbOut_PSEL)
        mem_wdata   <=  io_apbOut_PWDATA    ;
end

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        mem_wstrb    <=  'd0 ;
    else if(io_apbOut_PSEL) begin
        if(io_apbOut_PWRITE)
            mem_wstrb    <=  4'b1111 ;
        else
            mem_wstrb    <=  4'b0000 ;
    end
end

assign  io_apbOut_PRDATA    =   mem_rdata   ;
assign  io_apbOut_PREADY    =   mem_valid   &&  mem_ready   ;
assign  io_apbOut_PSLVERROR =   1'b0    ;


endmodule