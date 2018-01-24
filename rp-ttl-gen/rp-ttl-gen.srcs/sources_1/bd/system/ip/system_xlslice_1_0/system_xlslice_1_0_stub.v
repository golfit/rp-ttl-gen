// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
// Date        : Tue Jan 23 21:43:27 2018
// Host        : cmodws121 running 64-bit Red Hat Enterprise Linux Server release 7.4 (Maipo)
// Command     : write_verilog -force -mode synth_stub -rename_top system_xlslice_1_0 -prefix
//               system_xlslice_1_0_ system_xlslice_0_0_stub.v
// Design      : system_xlslice_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlslice_v1_0_1_xlslice,Vivado 2017.4" *)
module system_xlslice_1_0(Din, Dout)
/* synthesis syn_black_box black_box_pad_pin="Din[31:0],Dout[0:0]" */;
  input [31:0]Din;
  output [0:0]Dout;
endmodule
