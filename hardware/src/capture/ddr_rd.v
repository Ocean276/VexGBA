module ddr_rd (
    input               clk                 ,
    input               udp_clk             ,
    input               rst_n               ,
    input               ddr_cmd_rdy         ,
    output     [2:0]    ddr_cmd             ,
    output              ddr_cmd_en          ,
    output reg [29-1:0] ddr_rd_addr         ,
    input               ddr_rd_data_valid   ,
    input               ddr_rd_data_end     ,
    input [255:0]       ddr_rd_data         ,
    input               init_calib_complete ,

    input               intr_sig            ,

    input               rd_en               ,
    input               send_finish         ,
    output reg [7:0]    line_number         ,
    output [10:0]       Rnum                ,
    output [7:0]        rd_data             ,
    output  wire        send_finish_pos_pos      
);

reg         send_finish_d1  ;
reg         send_finish_d2  ;

reg         send_finish_pos_d1  ;
wire        send_finish_pos     ;

reg         is_transmitting ;

reg [7:0]   line_cnt    ;
reg [4:0]   cmd_cnt     ;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        line_cnt    <=  'd0 ;
    else if(line_cnt == 159 && send_finish_pos_pos)
        line_cnt    <=  'd0 ;
    else if(send_finish_pos_pos)
        line_cnt    <=  line_cnt    +   1   ;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cmd_cnt    <=  'd0 ;
    else if(cmd_cnt == 29 && ddr_cmd_rdy && ddr_cmd_en)
        cmd_cnt    <=  'd0 ;
    else if(ddr_cmd_rdy && ddr_cmd_en)
        cmd_cnt    <=  cmd_cnt    +   1   ;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        is_transmitting <=  'd0 ;
    else if((intr_sig || send_finish_pos_pos) && init_calib_complete) begin
        if(line_cnt == 159)
            is_transmitting <=  'd0 ;
        else
            is_transmitting <=  'd1 ;
    end
    else if(cmd_cnt == 29 && ddr_cmd_rdy && ddr_cmd_en)
        is_transmitting <=  'd0 ;
end

always @(posedge udp_clk or negedge rst_n) begin
    if(!rst_n)
        line_number <=  'd0 ;
    else if(send_finish) begin
        if(line_number == 159)
            line_number <=  'd0 ;
        else
            line_number <=  line_number +   1   ;
    end
end

assign  send_finish_pos =   send_finish_d1  ||  send_finish ||  send_finish_d2  ;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        send_finish_pos_d1  <=  'd0 ;
    else
        send_finish_pos_d1  <=  send_finish_pos ;
end

assign  send_finish_pos_pos =   send_finish_pos && !send_finish_pos_d1  ;

always @(posedge udp_clk or negedge rst_n) begin
    if(!rst_n) begin
        send_finish_d1  <=  'd0 ;
        send_finish_d2  <=  'd0 ;
    end
    else begin
        send_finish_d1  <=  send_finish     ;
        send_finish_d2  <=  send_finish_d1  ;
    end
end

assign ddr_cmd_en   =   is_transmitting && ddr_cmd_rdy  ;

assign ddr_cmd      =   1   ;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        ddr_rd_addr <= 'h0;
    end
    else if(ddr_cmd_rdy && ddr_cmd_en) begin
        ddr_rd_addr <= ddr_rd_addr + 8;
    end
    else if(ddr_rd_addr == 'd38400 && send_finish_pos_pos)
        ddr_rd_addr <= 'h0;
end

DDR_rd_fifo DDR_rd_fifo(
	.Data   (ddr_rd_data        ), //input [255:0] Data
	.WrClk  (clk                ), //input WrClk
	.RdClk  (udp_clk            ), //input RdClk
	.WrEn   (ddr_rd_data_valid  ), //input WrEn
	.RdEn   (rd_en              ), //input RdEn
	.Rnum   (Rnum               ), //output [10:0] Rnum
	.Q      (rd_data            ), //output [7:0] Q
	.Empty  (                   ), //output Empty
	.Full   (                   ) //output Full
);

endmodule
