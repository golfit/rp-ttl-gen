// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
// Date        : Fri Jan 19 18:16:57 2018
// Host        : cmodws121 running 64-bit Red Hat Enterprise Linux Server release 7.4 (Maipo)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_ttl_gen_axi_v2_0_M00_AXI_0_0_stub.v
// Design      : system_ttl_gen_axi_v2_0_M00_AXI_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ttl_gen_axi_v2_0_M00_AXI,Vivado 2017.4" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, arm, trig, num_cycles, num_reps, init_val, 
  v_out, state, error_flag, M_AXI_ACLK, M_AXI_ARESETN, M_AXI_AWADDR, M_AXI_AWPROT, M_AXI_AWVALID, 
  M_AXI_AWREADY, M_AXI_WDATA, M_AXI_WSTRB, M_AXI_WVALID, M_AXI_WREADY, M_AXI_BRESP, 
  M_AXI_BVALID, M_AXI_BREADY, M_AXI_ARADDR, M_AXI_ARPROT, M_AXI_ARVALID, M_AXI_ARREADY, 
  M_AXI_RDATA, M_AXI_RRESP, M_AXI_RVALID, M_AXI_RREADY)
/* synthesis syn_black_box black_box_pad_pin="clk,arm,trig,num_cycles[31:0],num_reps[31:0],init_val,v_out,state[1:0],error_flag,M_AXI_ACLK,M_AXI_ARESETN,M_AXI_AWADDR[31:0],M_AXI_AWPROT[2:0],M_AXI_AWVALID,M_AXI_AWREADY,M_AXI_WDATA[31:0],M_AXI_WSTRB[3:0],M_AXI_WVALID,M_AXI_WREADY,M_AXI_BRESP[1:0],M_AXI_BVALID,M_AXI_BREADY,M_AXI_ARADDR[31:0],M_AXI_ARPROT[2:0],M_AXI_ARVALID,M_AXI_ARREADY,M_AXI_RDATA[31:0],M_AXI_RRESP[1:0],M_AXI_RVALID,M_AXI_RREADY" */;
  input clk;
  input arm;
  input trig;
  input [31:0]num_cycles;
  input [31:0]num_reps;
  input init_val;
  output v_out;
  output [1:0]state;
  output error_flag;
  input M_AXI_ACLK;
  input M_AXI_ARESETN;
  output [31:0]M_AXI_AWADDR;
  output [2:0]M_AXI_AWPROT;
  output M_AXI_AWVALID;
  input M_AXI_AWREADY;
  output [31:0]M_AXI_WDATA;
  output [3:0]M_AXI_WSTRB;
  output M_AXI_WVALID;
  input M_AXI_WREADY;
  input [1:0]M_AXI_BRESP;
  input M_AXI_BVALID;
  output M_AXI_BREADY;
  output [31:0]M_AXI_ARADDR;
  output [2:0]M_AXI_ARPROT;
  output M_AXI_ARVALID;
  input M_AXI_ARREADY;
  input [31:0]M_AXI_RDATA;
  input [1:0]M_AXI_RRESP;
  input M_AXI_RVALID;
  output M_AXI_RREADY;
endmodule
