module axi2custom (
    input                       clk                             ,
    input                       resetn                          ,

    // left
    input   wire                io_axiOut_arw_valid             ,
    output  reg                 io_axiOut_arw_ready             ,
    input   wire    [31:0]      io_axiOut_arw_payload_addr      ,
    input   wire                io_axiOut_arw_payload_write     ,

    input   wire    [3:0]       io_axiOut_arw_payload_id        ,
    input   wire    [3:0]       io_axiOut_arw_payload_region    ,
    input   wire    [7:0]       io_axiOut_arw_payload_len       ,
    input   wire    [2:0]       io_axiOut_arw_payload_size      ,
    input   wire    [1:0]       io_axiOut_arw_payload_burst     ,
    input   wire    [0:0]       io_axiOut_arw_payload_lock      ,
    input   wire    [3:0]       io_axiOut_arw_payload_cache     ,
    input   wire    [3:0]       io_axiOut_arw_payload_qos       ,
    input   wire    [2:0]       io_axiOut_arw_payload_prot      ,

    input   wire                io_axiOut_w_valid               ,
    output  reg                 io_axiOut_w_ready               ,
    input   wire    [31:0]      io_axiOut_w_payload_data        ,
    input   wire    [3:0]       io_axiOut_w_payload_strb        ,
    input   wire                io_axiOut_w_payload_last        ,

    output  reg                 io_axiOut_b_valid               ,
    input   wire                io_axiOut_b_ready               ,
    output  wire    [3:0]       io_axiOut_b_payload_id          ,
    output  wire    [1:0]       io_axiOut_b_payload_resp        ,

    output  wire                io_axiOut_r_valid               ,
    input   wire                io_axiOut_r_ready               ,
    output  wire    [31:0]      io_axiOut_r_payload_data        ,
    output  wire    [3:0]       io_axiOut_r_payload_id          ,
    output  wire    [1:0]       io_axiOut_r_payload_resp        ,
    output  wire                io_axiOut_r_payload_last        ,

    // right
	output  reg                 mem_valid                       ,
	input                       mem_ready                       ,

	output  reg     [31:0]      mem_addr                        ,
	output  wire    [31:0]      mem_wdata                       ,
	output  wire    [ 3:0]      mem_wstrb                       ,
	input           [31:0]      mem_rdata                       
);

reg             axi_write       ;

always @(posedge clk ) begin
    if(io_axiOut_arw_ready && io_axiOut_arw_valid)
        axi_write   <=  io_axiOut_arw_payload_write ;
end

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        io_axiOut_b_valid <=  'd0 ;
    else if(io_axiOut_b_valid)
        io_axiOut_b_valid <=  'd0 ;
    else if(mem_valid   &&  mem_ready  && axi_write)
        io_axiOut_b_valid <=  'd1 ;
end

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        io_axiOut_arw_ready <=  'd1 ;
    else if(io_axiOut_arw_ready && io_axiOut_arw_valid)
        io_axiOut_arw_ready <=  'd0 ;
    else if((io_axiOut_b_valid && io_axiOut_b_ready) || (io_axiOut_r_valid && io_axiOut_r_ready))
        io_axiOut_arw_ready <=  'd1 ;
end

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        mem_valid   <=  'd0 ;
    else if(io_axiOut_arw_ready && io_axiOut_arw_valid)
        mem_valid   <=  'd1 ;
    else if(mem_valid   &&  mem_ready)
        mem_valid   <=  'd0 ;
end

assign  io_axiOut_r_payload_data    =   (mem_ready  &&  mem_valid)  ?   mem_rdata   :   'd0;
assign  io_axiOut_r_valid           =   (mem_ready  &&  mem_valid)  &&  !axi_write  ;
assign  io_axiOut_r_payload_id      =   'd0 ;
assign  io_axiOut_r_payload_resp    =   'd0 ;
assign  io_axiOut_r_payload_last    =   'd1 ;

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        mem_addr    <=  'd0 ;
    else if(io_axiOut_arw_ready && io_axiOut_arw_valid)
        mem_addr    <=  io_axiOut_arw_payload_addr  ;
end

assign  mem_wdata   =   io_axiOut_w_payload_data    ;
assign  mem_wstrb   =   axi_write   ?   io_axiOut_w_payload_strb    :   'd0 ;

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        io_axiOut_w_ready   <=  'd0 ;
    else if((mem_ready  &&  mem_valid)  &&  axi_write)
        io_axiOut_w_ready   <=  'd1 ;
    else
        io_axiOut_w_ready   <=  'd0 ;
end
    
endmodule