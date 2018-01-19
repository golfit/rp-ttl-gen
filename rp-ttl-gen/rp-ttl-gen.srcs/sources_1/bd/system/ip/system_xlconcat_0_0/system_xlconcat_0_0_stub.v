// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
// Date        : Fri Jan 19 16:07:40 2018
// Host        : cmodws121 running 64-bit Red Hat Enterprise Linux Server release 7.4 (Maipo)
// Command     : write_verilog -force -mode synth_stub
//               /home/golfit/git/rp/rp-ttl-gen/rp-ttl-gen/rp-ttl-gen.srcs/sources_1/bd/system/ip/system_xlconcat_0_0/system_xlconcat_0_0_stub.v
// Design      : system_xlconcat_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlconcat_v2_1_1_xlconcat,Vivado 2017.4" *)
module system_xlconcat_0_0(In0, In1, In2, In3, dout)
/* synthesis syn_black_box black_box_pad_pin="In0[1:0],In1[0:0],In2[0:0],In3[3:0],dout[7:0]" */;
  input [1:0]In0;
  input [0:0]In1;
  input [0:0]In2;
  input [3:0]In3;
  output [7:0]dout;
endmodule
