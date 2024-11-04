module gw_gao(
    \capture/udp/GMII_send_m0/rd_en ,
    \capture/udp/GMII_send_m0/Rnum[10] ,
    \capture/udp/GMII_send_m0/Rnum[9] ,
    \capture/udp/GMII_send_m0/Rnum[8] ,
    \capture/udp/GMII_send_m0/Rnum[7] ,
    \capture/udp/GMII_send_m0/Rnum[6] ,
    \capture/udp/GMII_send_m0/Rnum[5] ,
    \capture/udp/GMII_send_m0/Rnum[4] ,
    \capture/udp/GMII_send_m0/Rnum[3] ,
    \capture/udp/GMII_send_m0/Rnum[2] ,
    \capture/udp/GMII_send_m0/Rnum[1] ,
    \capture/udp/GMII_send_m0/Rnum[0] ,
    \capture/udp/GMII_TXD[7] ,
    \capture/udp/GMII_TXD[6] ,
    \capture/udp/GMII_TXD[5] ,
    \capture/udp/GMII_TXD[4] ,
    \capture/udp/GMII_TXD[3] ,
    \capture/udp/GMII_TXD[2] ,
    \capture/udp/GMII_TXD[1] ,
    \capture/udp/GMII_TXD[0] ,
    \capture/udp/GMII_TXEN ,
    \capture/udp/GMII_send_m0/rd_data[7] ,
    \capture/udp/GMII_send_m0/rd_data[6] ,
    \capture/udp/GMII_send_m0/rd_data[5] ,
    \capture/udp/GMII_send_m0/rd_data[4] ,
    \capture/udp/GMII_send_m0/rd_data[3] ,
    \capture/udp/GMII_send_m0/rd_data[2] ,
    \capture/udp/GMII_send_m0/rd_data[1] ,
    \capture/udp/GMII_send_m0/rd_data[0] ,
    \capture/udp/GMII_send_m0/state[3] ,
    \capture/udp/GMII_send_m0/state[2] ,
    \capture/udp/GMII_send_m0/state[1] ,
    \capture/udp/GMII_send_m0/state[0] ,
    \capture/pixel_we ,
    \capture/pixel_data[17] ,
    \capture/pixel_data[16] ,
    \capture/pixel_data[15] ,
    \capture/pixel_data[14] ,
    \capture/pixel_data[13] ,
    \capture/pixel_data[12] ,
    \capture/pixel_data[11] ,
    \capture/pixel_data[10] ,
    \capture/pixel_data[9] ,
    \capture/pixel_data[8] ,
    \capture/pixel_data[7] ,
    \capture/pixel_data[6] ,
    \capture/pixel_data[5] ,
    \capture/pixel_data[4] ,
    \capture/pixel_data[3] ,
    \capture/pixel_data[2] ,
    \capture/pixel_data[1] ,
    \capture/pixel_data[0] ,
    \capture/wr_data[31] ,
    \capture/wr_data[30] ,
    \capture/wr_data[29] ,
    \capture/wr_data[28] ,
    \capture/wr_data[27] ,
    \capture/wr_data[26] ,
    \capture/wr_data[25] ,
    \capture/wr_data[24] ,
    \capture/wr_data[23] ,
    \capture/wr_data[22] ,
    \capture/wr_data[21] ,
    \capture/wr_data[20] ,
    \capture/wr_data[19] ,
    \capture/wr_data[18] ,
    \capture/wr_data[17] ,
    \capture/wr_data[16] ,
    \capture/wr_data[15] ,
    \capture/wr_data[14] ,
    \capture/wr_data[13] ,
    \capture/wr_data[12] ,
    \capture/wr_data[11] ,
    \capture/wr_data[10] ,
    \capture/wr_data[9] ,
    \capture/wr_data[8] ,
    \capture/wr_data[7] ,
    \capture/wr_data[6] ,
    \capture/wr_data[5] ,
    \capture/wr_data[4] ,
    \capture/wr_data[3] ,
    \capture/wr_data[2] ,
    \capture/wr_data[1] ,
    \capture/wr_data[0] ,
    \capture/wr_en ,
    \capture/rd_en ,
    \capture/Rnum[10] ,
    \capture/Rnum[9] ,
    \capture/Rnum[8] ,
    \capture/Rnum[7] ,
    \capture/Rnum[6] ,
    \capture/Rnum[5] ,
    \capture/Rnum[4] ,
    \capture/Rnum[3] ,
    \capture/Rnum[2] ,
    \capture/Rnum[1] ,
    \capture/Rnum[0] ,
    \capture/rd_data[7] ,
    \capture/rd_data[6] ,
    \capture/rd_data[5] ,
    \capture/rd_data[4] ,
    \capture/rd_data[3] ,
    \capture/rd_data[2] ,
    \capture/rd_data[1] ,
    \capture/rd_data[0] ,
    \capture/udp/GMII_send_m0/line_number[7] ,
    \capture/udp/GMII_send_m0/line_number[6] ,
    \capture/udp/GMII_send_m0/line_number[5] ,
    \capture/udp/GMII_send_m0/line_number[4] ,
    \capture/udp/GMII_send_m0/line_number[3] ,
    \capture/udp/GMII_send_m0/line_number[2] ,
    \capture/udp/GMII_send_m0/line_number[1] ,
    \capture/udp/GMII_send_m0/line_number[0] ,
    \capture/RGMII_GTXCLK ,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \capture/udp/GMII_send_m0/rd_en ;
input \capture/udp/GMII_send_m0/Rnum[10] ;
input \capture/udp/GMII_send_m0/Rnum[9] ;
input \capture/udp/GMII_send_m0/Rnum[8] ;
input \capture/udp/GMII_send_m0/Rnum[7] ;
input \capture/udp/GMII_send_m0/Rnum[6] ;
input \capture/udp/GMII_send_m0/Rnum[5] ;
input \capture/udp/GMII_send_m0/Rnum[4] ;
input \capture/udp/GMII_send_m0/Rnum[3] ;
input \capture/udp/GMII_send_m0/Rnum[2] ;
input \capture/udp/GMII_send_m0/Rnum[1] ;
input \capture/udp/GMII_send_m0/Rnum[0] ;
input \capture/udp/GMII_TXD[7] ;
input \capture/udp/GMII_TXD[6] ;
input \capture/udp/GMII_TXD[5] ;
input \capture/udp/GMII_TXD[4] ;
input \capture/udp/GMII_TXD[3] ;
input \capture/udp/GMII_TXD[2] ;
input \capture/udp/GMII_TXD[1] ;
input \capture/udp/GMII_TXD[0] ;
input \capture/udp/GMII_TXEN ;
input \capture/udp/GMII_send_m0/rd_data[7] ;
input \capture/udp/GMII_send_m0/rd_data[6] ;
input \capture/udp/GMII_send_m0/rd_data[5] ;
input \capture/udp/GMII_send_m0/rd_data[4] ;
input \capture/udp/GMII_send_m0/rd_data[3] ;
input \capture/udp/GMII_send_m0/rd_data[2] ;
input \capture/udp/GMII_send_m0/rd_data[1] ;
input \capture/udp/GMII_send_m0/rd_data[0] ;
input \capture/udp/GMII_send_m0/state[3] ;
input \capture/udp/GMII_send_m0/state[2] ;
input \capture/udp/GMII_send_m0/state[1] ;
input \capture/udp/GMII_send_m0/state[0] ;
input \capture/pixel_we ;
input \capture/pixel_data[17] ;
input \capture/pixel_data[16] ;
input \capture/pixel_data[15] ;
input \capture/pixel_data[14] ;
input \capture/pixel_data[13] ;
input \capture/pixel_data[12] ;
input \capture/pixel_data[11] ;
input \capture/pixel_data[10] ;
input \capture/pixel_data[9] ;
input \capture/pixel_data[8] ;
input \capture/pixel_data[7] ;
input \capture/pixel_data[6] ;
input \capture/pixel_data[5] ;
input \capture/pixel_data[4] ;
input \capture/pixel_data[3] ;
input \capture/pixel_data[2] ;
input \capture/pixel_data[1] ;
input \capture/pixel_data[0] ;
input \capture/wr_data[31] ;
input \capture/wr_data[30] ;
input \capture/wr_data[29] ;
input \capture/wr_data[28] ;
input \capture/wr_data[27] ;
input \capture/wr_data[26] ;
input \capture/wr_data[25] ;
input \capture/wr_data[24] ;
input \capture/wr_data[23] ;
input \capture/wr_data[22] ;
input \capture/wr_data[21] ;
input \capture/wr_data[20] ;
input \capture/wr_data[19] ;
input \capture/wr_data[18] ;
input \capture/wr_data[17] ;
input \capture/wr_data[16] ;
input \capture/wr_data[15] ;
input \capture/wr_data[14] ;
input \capture/wr_data[13] ;
input \capture/wr_data[12] ;
input \capture/wr_data[11] ;
input \capture/wr_data[10] ;
input \capture/wr_data[9] ;
input \capture/wr_data[8] ;
input \capture/wr_data[7] ;
input \capture/wr_data[6] ;
input \capture/wr_data[5] ;
input \capture/wr_data[4] ;
input \capture/wr_data[3] ;
input \capture/wr_data[2] ;
input \capture/wr_data[1] ;
input \capture/wr_data[0] ;
input \capture/wr_en ;
input \capture/rd_en ;
input \capture/Rnum[10] ;
input \capture/Rnum[9] ;
input \capture/Rnum[8] ;
input \capture/Rnum[7] ;
input \capture/Rnum[6] ;
input \capture/Rnum[5] ;
input \capture/Rnum[4] ;
input \capture/Rnum[3] ;
input \capture/Rnum[2] ;
input \capture/Rnum[1] ;
input \capture/Rnum[0] ;
input \capture/rd_data[7] ;
input \capture/rd_data[6] ;
input \capture/rd_data[5] ;
input \capture/rd_data[4] ;
input \capture/rd_data[3] ;
input \capture/rd_data[2] ;
input \capture/rd_data[1] ;
input \capture/rd_data[0] ;
input \capture/udp/GMII_send_m0/line_number[7] ;
input \capture/udp/GMII_send_m0/line_number[6] ;
input \capture/udp/GMII_send_m0/line_number[5] ;
input \capture/udp/GMII_send_m0/line_number[4] ;
input \capture/udp/GMII_send_m0/line_number[3] ;
input \capture/udp/GMII_send_m0/line_number[2] ;
input \capture/udp/GMII_send_m0/line_number[1] ;
input \capture/udp/GMII_send_m0/line_number[0] ;
input \capture/RGMII_GTXCLK ;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \capture/udp/GMII_send_m0/rd_en ;
wire \capture/udp/GMII_send_m0/Rnum[10] ;
wire \capture/udp/GMII_send_m0/Rnum[9] ;
wire \capture/udp/GMII_send_m0/Rnum[8] ;
wire \capture/udp/GMII_send_m0/Rnum[7] ;
wire \capture/udp/GMII_send_m0/Rnum[6] ;
wire \capture/udp/GMII_send_m0/Rnum[5] ;
wire \capture/udp/GMII_send_m0/Rnum[4] ;
wire \capture/udp/GMII_send_m0/Rnum[3] ;
wire \capture/udp/GMII_send_m0/Rnum[2] ;
wire \capture/udp/GMII_send_m0/Rnum[1] ;
wire \capture/udp/GMII_send_m0/Rnum[0] ;
wire \capture/udp/GMII_TXD[7] ;
wire \capture/udp/GMII_TXD[6] ;
wire \capture/udp/GMII_TXD[5] ;
wire \capture/udp/GMII_TXD[4] ;
wire \capture/udp/GMII_TXD[3] ;
wire \capture/udp/GMII_TXD[2] ;
wire \capture/udp/GMII_TXD[1] ;
wire \capture/udp/GMII_TXD[0] ;
wire \capture/udp/GMII_TXEN ;
wire \capture/udp/GMII_send_m0/rd_data[7] ;
wire \capture/udp/GMII_send_m0/rd_data[6] ;
wire \capture/udp/GMII_send_m0/rd_data[5] ;
wire \capture/udp/GMII_send_m0/rd_data[4] ;
wire \capture/udp/GMII_send_m0/rd_data[3] ;
wire \capture/udp/GMII_send_m0/rd_data[2] ;
wire \capture/udp/GMII_send_m0/rd_data[1] ;
wire \capture/udp/GMII_send_m0/rd_data[0] ;
wire \capture/udp/GMII_send_m0/state[3] ;
wire \capture/udp/GMII_send_m0/state[2] ;
wire \capture/udp/GMII_send_m0/state[1] ;
wire \capture/udp/GMII_send_m0/state[0] ;
wire \capture/pixel_we ;
wire \capture/pixel_data[17] ;
wire \capture/pixel_data[16] ;
wire \capture/pixel_data[15] ;
wire \capture/pixel_data[14] ;
wire \capture/pixel_data[13] ;
wire \capture/pixel_data[12] ;
wire \capture/pixel_data[11] ;
wire \capture/pixel_data[10] ;
wire \capture/pixel_data[9] ;
wire \capture/pixel_data[8] ;
wire \capture/pixel_data[7] ;
wire \capture/pixel_data[6] ;
wire \capture/pixel_data[5] ;
wire \capture/pixel_data[4] ;
wire \capture/pixel_data[3] ;
wire \capture/pixel_data[2] ;
wire \capture/pixel_data[1] ;
wire \capture/pixel_data[0] ;
wire \capture/wr_data[31] ;
wire \capture/wr_data[30] ;
wire \capture/wr_data[29] ;
wire \capture/wr_data[28] ;
wire \capture/wr_data[27] ;
wire \capture/wr_data[26] ;
wire \capture/wr_data[25] ;
wire \capture/wr_data[24] ;
wire \capture/wr_data[23] ;
wire \capture/wr_data[22] ;
wire \capture/wr_data[21] ;
wire \capture/wr_data[20] ;
wire \capture/wr_data[19] ;
wire \capture/wr_data[18] ;
wire \capture/wr_data[17] ;
wire \capture/wr_data[16] ;
wire \capture/wr_data[15] ;
wire \capture/wr_data[14] ;
wire \capture/wr_data[13] ;
wire \capture/wr_data[12] ;
wire \capture/wr_data[11] ;
wire \capture/wr_data[10] ;
wire \capture/wr_data[9] ;
wire \capture/wr_data[8] ;
wire \capture/wr_data[7] ;
wire \capture/wr_data[6] ;
wire \capture/wr_data[5] ;
wire \capture/wr_data[4] ;
wire \capture/wr_data[3] ;
wire \capture/wr_data[2] ;
wire \capture/wr_data[1] ;
wire \capture/wr_data[0] ;
wire \capture/wr_en ;
wire \capture/rd_en ;
wire \capture/Rnum[10] ;
wire \capture/Rnum[9] ;
wire \capture/Rnum[8] ;
wire \capture/Rnum[7] ;
wire \capture/Rnum[6] ;
wire \capture/Rnum[5] ;
wire \capture/Rnum[4] ;
wire \capture/Rnum[3] ;
wire \capture/Rnum[2] ;
wire \capture/Rnum[1] ;
wire \capture/Rnum[0] ;
wire \capture/rd_data[7] ;
wire \capture/rd_data[6] ;
wire \capture/rd_data[5] ;
wire \capture/rd_data[4] ;
wire \capture/rd_data[3] ;
wire \capture/rd_data[2] ;
wire \capture/rd_data[1] ;
wire \capture/rd_data[0] ;
wire \capture/udp/GMII_send_m0/line_number[7] ;
wire \capture/udp/GMII_send_m0/line_number[6] ;
wire \capture/udp/GMII_send_m0/line_number[5] ;
wire \capture/udp/GMII_send_m0/line_number[4] ;
wire \capture/udp/GMII_send_m0/line_number[3] ;
wire \capture/udp/GMII_send_m0/line_number[2] ;
wire \capture/udp/GMII_send_m0/line_number[1] ;
wire \capture/udp/GMII_send_m0/line_number[0] ;
wire \capture/RGMII_GTXCLK ;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top_0  u_la0_top(
    .control(control0[9:0]),
    .trig0_i({\capture/udp/GMII_send_m0/line_number[7] ,\capture/udp/GMII_send_m0/line_number[6] ,\capture/udp/GMII_send_m0/line_number[5] ,\capture/udp/GMII_send_m0/line_number[4] ,\capture/udp/GMII_send_m0/line_number[3] ,\capture/udp/GMII_send_m0/line_number[2] ,\capture/udp/GMII_send_m0/line_number[1] ,\capture/udp/GMII_send_m0/line_number[0] }),
    .data_i({\capture/udp/GMII_send_m0/rd_en ,\capture/udp/GMII_send_m0/Rnum[10] ,\capture/udp/GMII_send_m0/Rnum[9] ,\capture/udp/GMII_send_m0/Rnum[8] ,\capture/udp/GMII_send_m0/Rnum[7] ,\capture/udp/GMII_send_m0/Rnum[6] ,\capture/udp/GMII_send_m0/Rnum[5] ,\capture/udp/GMII_send_m0/Rnum[4] ,\capture/udp/GMII_send_m0/Rnum[3] ,\capture/udp/GMII_send_m0/Rnum[2] ,\capture/udp/GMII_send_m0/Rnum[1] ,\capture/udp/GMII_send_m0/Rnum[0] ,\capture/udp/GMII_TXD[7] ,\capture/udp/GMII_TXD[6] ,\capture/udp/GMII_TXD[5] ,\capture/udp/GMII_TXD[4] ,\capture/udp/GMII_TXD[3] ,\capture/udp/GMII_TXD[2] ,\capture/udp/GMII_TXD[1] ,\capture/udp/GMII_TXD[0] ,\capture/udp/GMII_TXEN ,\capture/udp/GMII_send_m0/rd_data[7] ,\capture/udp/GMII_send_m0/rd_data[6] ,\capture/udp/GMII_send_m0/rd_data[5] ,\capture/udp/GMII_send_m0/rd_data[4] ,\capture/udp/GMII_send_m0/rd_data[3] ,\capture/udp/GMII_send_m0/rd_data[2] ,\capture/udp/GMII_send_m0/rd_data[1] ,\capture/udp/GMII_send_m0/rd_data[0] ,\capture/udp/GMII_send_m0/state[3] ,\capture/udp/GMII_send_m0/state[2] ,\capture/udp/GMII_send_m0/state[1] ,\capture/udp/GMII_send_m0/state[0] ,\capture/pixel_we ,\capture/pixel_data[17] ,\capture/pixel_data[16] ,\capture/pixel_data[15] ,\capture/pixel_data[14] ,\capture/pixel_data[13] ,\capture/pixel_data[12] ,\capture/pixel_data[11] ,\capture/pixel_data[10] ,\capture/pixel_data[9] ,\capture/pixel_data[8] ,\capture/pixel_data[7] ,\capture/pixel_data[6] ,\capture/pixel_data[5] ,\capture/pixel_data[4] ,\capture/pixel_data[3] ,\capture/pixel_data[2] ,\capture/pixel_data[1] ,\capture/pixel_data[0] ,\capture/wr_data[31] ,\capture/wr_data[30] ,\capture/wr_data[29] ,\capture/wr_data[28] ,\capture/wr_data[27] ,\capture/wr_data[26] ,\capture/wr_data[25] ,\capture/wr_data[24] ,\capture/wr_data[23] ,\capture/wr_data[22] ,\capture/wr_data[21] ,\capture/wr_data[20] ,\capture/wr_data[19] ,\capture/wr_data[18] ,\capture/wr_data[17] ,\capture/wr_data[16] ,\capture/wr_data[15] ,\capture/wr_data[14] ,\capture/wr_data[13] ,\capture/wr_data[12] ,\capture/wr_data[11] ,\capture/wr_data[10] ,\capture/wr_data[9] ,\capture/wr_data[8] ,\capture/wr_data[7] ,\capture/wr_data[6] ,\capture/wr_data[5] ,\capture/wr_data[4] ,\capture/wr_data[3] ,\capture/wr_data[2] ,\capture/wr_data[1] ,\capture/wr_data[0] ,\capture/wr_en ,\capture/rd_en ,\capture/Rnum[10] ,\capture/Rnum[9] ,\capture/Rnum[8] ,\capture/Rnum[7] ,\capture/Rnum[6] ,\capture/Rnum[5] ,\capture/Rnum[4] ,\capture/Rnum[3] ,\capture/Rnum[2] ,\capture/Rnum[1] ,\capture/Rnum[0] ,\capture/rd_data[7] ,\capture/rd_data[6] ,\capture/rd_data[5] ,\capture/rd_data[4] ,\capture/rd_data[3] ,\capture/rd_data[2] ,\capture/rd_data[1] ,\capture/rd_data[0] }),
    .clk_i(\capture/RGMII_GTXCLK )
);

endmodule
