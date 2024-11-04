//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5AST-LV138PG484AC1/I0
//Device: GW5AST-138B
//Device Version: B
//Created Time: Sat Oct 26 22:13:22 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Audio_SDPB your_instance_name(
        .dout(dout_o), //output [15:0] dout
        .clka(clka_i), //input clka
        .cea(cea_i), //input cea
        .clkb(clkb_i), //input clkb
        .ceb(ceb_i), //input ceb
        .oce(oce_i), //input oce
        .reset(reset_i), //input reset
        .ada(ada_i), //input [0:0] ada
        .din(din_i), //input [31:0] din
        .adb(adb_i) //input [1:0] adb
    );

//--------Copy end-------------------
