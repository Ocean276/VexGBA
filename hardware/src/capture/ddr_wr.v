module ddr_wr (
    input   wire            clk                 ,
    input   wire            resetn              ,
        
    // from gpu     
    input   wire    [17:0]  pixel_data          ,    // RGB6
    input   wire    [7:0]   pixel_x             ,
    input   wire    [7:0]   pixel_y             ,
    input   wire            pixel_we            ,

    // from cpu
    input   wire            capture_en          ,

    output  wire    [31:0]  fifo_data_in        ,
    output  wire            fifo_wr_en          
);

localparam IDLE = 2'b00, WAIT = 2'b01, WRITE = 2'b10 , DUMMY = 2'b11;

reg     [1:0]   cur_state   ;
reg     [1:0]   nxt_state   ;


assign  fifo_data_in    =   {{8'b0}, {pixel_data[17:12], 2'b0,      // RGB6 to RGB8
                                         pixel_data[11:6], 2'b0, 
                                         pixel_data[5:0], 2'b0}};

assign  fifo_wr_en  =   (cur_state == WRITE) && pixel_we    ;

always @(posedge clk or negedge resetn) begin
    if(!resetn)
        cur_state   <=  IDLE    ;
    else
        cur_state   <=  nxt_state   ;
end

always @(*) begin
    case (cur_state)
        IDLE: begin
            if(capture_en)
                nxt_state  <=  WAIT    ;
            else
                nxt_state  <=  IDLE    ;
        end
        WAIT: begin
            if(pixel_x == 'd239 && pixel_y == 'd159 && pixel_we)
                nxt_state  <=  WRITE    ;
            else
                nxt_state  <=  WAIT    ;
        end
        WRITE: begin
            if(pixel_x == 'd239 && pixel_y == 'd159 && pixel_we)
                nxt_state  <=  DUMMY    ;
            else
                nxt_state  <=  WRITE    ;
        end
        DUMMY:
            nxt_state  <=  IDLE    ;
        default: nxt_state  <=  IDLE    ;
    endcase
end
    
endmodule