//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.9 (64-bit) 
//Created Time: 2024-11-03 15:11:39
create_clock -name hclk5 -period 2.694 -waveform {0 1.347} [get_nets {hclk5}]
create_clock -name clk16 -period 59.7 -waveform {0 29.85} [get_nets {clk16}]
create_clock -name gtx_clk -period 8 -waveform {0 4} [get_ports {RGMII_GTXCLK}]
create_clock -name phy_clk -period 40 -waveform {0 20} [get_nets {PHY_CLK}]

//create_clock -name tck -period 250 -waveform {0 125} [get_ports {tck_pad_i}]
//create_clock -name ddr_clk_100M -period 10 -waveform {0 5} [get_nets {ddr_clk_100M}]
//create_clock -name clk_ddr -period 10 -waveform {0 5} [get_pins {capture/u_ddr3/gw3_top/u_ddr_phy_top/fclkdiv/CLKOUT}]
//create_clock -name ddr_clk_400M -period 2.5 -waveform {0 1.25} [get_nets {ddr_clk_400M}]
create_generated_clock -name hclk -source [get_nets {hclk5}] -master_clock hclk5 -divide_by 5 [get_nets {hclk}]
create_generated_clock -name clk67 -source [get_nets {clk16}] -multiply_by 4 [get_nets {clk67}]
create_generated_clock -name clk50 -source [get_nets {clk16}] -multiply_by 3 [get_nets {clk50}]
set_clock_groups -asynchronous -group [get_clocks {clk16}] -group [get_clocks {clk50}] -group [get_clocks {gtx_clk}] -group [get_clocks {tck}]
set_clock_groups -asynchronous -group [get_clocks {gtx_clk}] -group [get_clocks {phy_clk}]-group [get_clocks {tck}]
//set_clock_groups -asynchronous -group [get_clocks {ddr_clk_100M}] -group [get_clocks {ddr_clk_400M}] -group [get_clocks {clk_ddr}] -group [get_clocks {clk16}] -group [get_clocks {clk50}] -group [get_clocks {gtx_clk}] -group [get_clocks {tck}]
//set_clock_groups -asynchronous -group [get_clocks {gtx_clk}] -group [get_clocks {phy_clk}] -group [get_clocks {clk_ddr}] -group [get_clocks {tck}]
//set_clock_groups -asynchronous -group [get_clocks {gtx_clk}] -group [get_clocks {clk_ddr}]
set_false_path -from [get_pins {gpu/drawer/ivram_lo/*/*}] -to [get_pins {sdram/*/*}] 
set_multicycle_path -from [get_clocks {clk67}] -to [get_clocks {clk16}]  -setup -start 4
set_multicycle_path -from [get_clocks {clk67}] -to [get_clocks {clk16}]  -hold -start 3
set_multicycle_path -from [get_clocks {clk16}] -to [get_clocks {clk67}]  -setup -end 4
set_multicycle_path -from [get_clocks {clk16}] -to [get_clocks {clk67}]  -hold -end 3
set_multicycle_path -from [get_pins {sdram/cpu_rdata*/*}] -to [get_clocks {clk67}]  -setup -end 4
set_multicycle_path -from [get_pins {sdram/cpu_rdata*/*}] -to [get_clocks {clk67}]  -hold -end 3
set_multicycle_path -from [get_clocks {clk16}] -to [get_clocks {clk50}]  -setup -end 3
set_multicycle_path -from [get_clocks {clk16}] -to [get_clocks {clk50}]  -hold -end 2
set_multicycle_path -from [get_clocks {clk50}] -to [get_clocks {clk16}]  -setup -start 3
set_multicycle_path -from [get_clocks {clk50}] -to [get_clocks {clk16}]  -hold -start 2
