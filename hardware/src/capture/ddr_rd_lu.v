module ddr_rd_lu (
    input               clk                 ,
    input               udp_clk             ,
    input               rst_n               ,
    input               ddr_cmd_rdy         ,
    output reg [2:0]    ddr_cmd             ,
    output reg          ddr_cmd_en          ,
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
    output [7:0]        rd_data
);

localparam  IDLE                = 6'b000001;
localparam  READ_CMD            = 6'b000010;
localparam  READ_CMD_PAUSE      = 6'b000100;
localparam  READ                = 6'b001000;
localparam  READ_END            = 6'b010000;
localparam  WAIT                = 6'b100000;

localparam  BURST_NUM = 240*32/256;
localparam  FRAME_NUM = 160;

reg [5:0]   c_state;
reg [5:0]   n_state;

reg [6:0]  cmd_cnt;

reg         send_finish_d1  ;

wire        send_finish_pos ;

reg         intr_sig_r;

assign  send_finish_pos =   send_finish_d1  ||  send_finish ;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        send_finish_d1  <=  'd0 ;
    else
        send_finish_d1  <=  send_finish ;
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        c_state <= IDLE;
    end
    else begin
        c_state <= n_state;
    end
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        intr_sig_r <= 0;
    end
    else if(intr_sig) begin
        intr_sig_r <= 1;
    end
    else if(send_finish_pos & line_number == FRAME_NUM)begin
        intr_sig_r <= 0;
    end
end

always @(*)begin
    n_state = IDLE;
    case(c_state)
        IDLE:
            n_state = ((intr_sig_r | send_finish_pos) & init_calib_complete & ddr_cmd_rdy) ? READ_CMD : IDLE;
        READ_CMD:
            if(ddr_cmd_rdy)
                n_state = (cmd_cnt == BURST_NUM - 1) ? READ : READ_CMD;
            else 
                n_state = READ_CMD_PAUSE;
        READ_CMD_PAUSE:
            n_state = (ddr_cmd_rdy) ? READ_CMD : READ_CMD_PAUSE;
        READ:
            n_state = (ddr_rd_data_valid & ddr_rd_data_end) ? READ_END : READ;
        READ_END:
            n_state = IDLE;
    endcase
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cmd_cnt <= 0;
    end
    else if(ddr_cmd_en & ddr_cmd_rdy & cmd_cnt == BURST_NUM - 1) begin
        cmd_cnt <= 0;
    end
    else if(ddr_cmd_en & ddr_cmd_rdy) begin
        cmd_cnt <= cmd_cnt + 1;
    end
end

always @(negedge rst_n)begin
    if(!rst_n)begin
        ddr_cmd <= 1;
    end
end

always @(*)begin
    if(!rst_n)begin
        ddr_cmd_en = 0;
    end
    else if(n_state == READ_CMD_PAUSE)begin
        ddr_cmd_en = 0;
    end
    else if(n_state == READ_CMD)begin
        ddr_cmd_en = 1;
    end
    else if(c_state == READ)begin
        ddr_cmd_en = 0;
    end
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        ddr_rd_addr <= 'h0;
    end
    else if(intr_sig) begin
        ddr_rd_addr <= 'h0;
    end
    else if(n_state == READ_CMD) begin
        ddr_rd_addr <= ddr_rd_addr + 8;
    end
end

always @(posedge udp_clk or negedge rst_n)begin
    if(!rst_n)begin
        line_number <= 'h0;
    end
    else if(line_number == FRAME_NUM) begin
        line_number <= 'h0;
    end
    else if(send_finish) begin
        line_number <= line_number + 1;
    end
end

DDR_rd_fifo DDR_rd_fifo(
	.Data(ddr_rd_data), //input [255:0] Data
	.WrClk(clk), //input WrClk
	.RdClk(udp_clk), //input RdClk
	.WrEn(ddr_rd_data_valid), //input WrEn
	.RdEn(rd_en), //input RdEn
	.Rnum(Rnum), //output [10:0] Rnum
	.Q(rd_data), //output [7:0] Q
	.Empty(), //output Empty
	.Full() //output Full
);

endmodule
