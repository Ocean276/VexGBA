module capture (
    input   wire                clk50M      ,
    input   wire                resetn      ,

    // from gpu     
    input   wire    [17:0]      pixel_data  ,    // RGB6
    input   wire    [7:0]       pixel_x     ,
    input   wire    [7:0]       pixel_y     ,
    input   wire                pixel_we    ,

    // from cpu
    input   wire                capture_en  ,

	input   wire			    RGMII_GTXCLK    ,
	output  wire			    RGMII_RST_N     , 	
	output  wire    [3:0] 	    RGMII_TXD       , 		
	output  wire   		        RGMII_TXEN	 
);

wire    [7:0]   rd_data ;
wire            rd_en   ;
wire    [10:0]  Rnum    ;
wire    [31:0]  wr_data ;
wire            wr_en   ;

ddr_wr ddr_wr(
    .clk                 (clk50M    ),
    .resetn              (resetn    ),
        
    // from gpu     
    .pixel_data          (pixel_data    ),    // RGB6
    .pixel_x             (pixel_x       ),
    .pixel_y             (pixel_y       ),
    .pixel_we            (pixel_we      ),

    // from cpu
    .capture_en          (capture_en    ),

    .fifo_data_in        (wr_data       ),
    .fifo_wr_en          (wr_en         )
);

pixel_udp_fifo pixel_udp_fifo(
    .Data   (wr_data        ), //input [31:0] Data
    .WrClk  (clk50M         ), //input WrClk
    .RdClk  (RGMII_GTXCLK   ), //input RdClk
    .WrEn   (wr_en          ), //input WrEn
    .RdEn   (rd_en          ), //input RdEn
    .Rnum   (Rnum           ), //output [10:0] Rnum
    .Q      (rd_data        ), //output [7:0] Q
    .Empty  (), //output Empty
    .Full   () //output Full
);

udp udp(
	.rst_n          (resetn         ), 		

	.RGMII_GTXCLK   (RGMII_GTXCLK   ),
	.RGMII_RST_N    (RGMII_RST_N    ), 	
	.RGMII_TXD      (RGMII_TXD      ), 		
	.RGMII_TXEN     (RGMII_TXEN     ),

    .rd_data		(rd_data		),
    .rd_en		    (rd_en		    ),
    .Rnum			(Rnum		    )	
);
    
endmodule