// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
// Date        : Tue Jan 23 22:19:52 2018
// Host        : cmodws121 running 64-bit Red Hat Enterprise Linux Server release 7.4 (Maipo)
// Command     : write_verilog -force -mode funcsim
//               /home/golfit/git/rp/rp-ttl-gen/rp-ttl-gen/rp-ttl-gen.srcs/sources_1/bd/system/ip/system_ttl_gen_axi_v2_0_M00_AXI_0_0/system_ttl_gen_axi_v2_0_M00_AXI_0_0_sim_netlist.v
// Design      : system_ttl_gen_axi_v2_0_M00_AXI_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_ttl_gen_axi_v2_0_M00_AXI_0_0,ttl_gen_axi_v2_0_M00_AXI,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "ttl_gen_axi_v2_0_M00_AXI,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module system_ttl_gen_axi_v2_0_M00_AXI_0_0
   (clk,
    arm,
    trig,
    num_cycles,
    num_reps,
    init_val,
    v_out,
    state,
    error_flag,
    M_AXI_ACLK,
    M_AXI_ARESETN,
    M_AXI_AWADDR,
    M_AXI_AWPROT,
    M_AXI_AWVALID,
    M_AXI_AWREADY,
    M_AXI_WDATA,
    M_AXI_WSTRB,
    M_AXI_WVALID,
    M_AXI_WREADY,
    M_AXI_BRESP,
    M_AXI_BVALID,
    M_AXI_BREADY,
    M_AXI_ARADDR,
    M_AXI_ARPROT,
    M_AXI_ARVALID,
    M_AXI_ARREADY,
    M_AXI_RDATA,
    M_AXI_RRESP,
    M_AXI_RVALID,
    M_AXI_RREADY);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 1.25e+08, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0" *) input clk;
  input arm;
  input trig;
  input [31:0]num_cycles;
  input [31:0]num_reps;
  input init_val;
  output v_out;
  output [1:0]state;
  output error_flag;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 M_AXI_ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI_ACLK, ASSOCIATED_BUSIF M_AXI, ASSOCIATED_RESET M_AXI_ARESETN, FREQ_HZ 1.25e+08, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0" *) input M_AXI_ACLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 M_AXI_ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI_ARESETN, POLARITY ACTIVE_LOW" *) input M_AXI_ARESETN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWADDR" *) output [31:0]M_AXI_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWPROT" *) output [2:0]M_AXI_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWVALID" *) output M_AXI_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWREADY" *) input M_AXI_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WDATA" *) output [31:0]M_AXI_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WSTRB" *) output [3:0]M_AXI_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WVALID" *) output M_AXI_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WREADY" *) input M_AXI_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BRESP" *) input [1:0]M_AXI_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BVALID" *) input M_AXI_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BREADY" *) output M_AXI_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARADDR" *) output [31:0]M_AXI_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARPROT" *) output [2:0]M_AXI_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARVALID" *) output M_AXI_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARREADY" *) input M_AXI_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RDATA" *) input [31:0]M_AXI_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RRESP" *) input [1:0]M_AXI_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RVALID" *) input M_AXI_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 1.25e+08, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *) output M_AXI_RREADY;

  wire \<const0> ;
  wire \<const1> ;
  wire M_AXI_ACLK;
  wire [5:5]\^M_AXI_ARADDR ;
  wire M_AXI_ARESETN;
  wire M_AXI_ARREADY;
  wire M_AXI_ARVALID;
  wire M_AXI_RREADY;
  wire M_AXI_RVALID;
  wire arm;
  wire clk;
  wire [31:0]num_cycles;
  wire [0:0]\^state ;

  assign M_AXI_ARADDR[31] = \<const0> ;
  assign M_AXI_ARADDR[30] = \<const0> ;
  assign M_AXI_ARADDR[29] = \<const0> ;
  assign M_AXI_ARADDR[28] = \<const0> ;
  assign M_AXI_ARADDR[27] = \<const0> ;
  assign M_AXI_ARADDR[26] = \<const0> ;
  assign M_AXI_ARADDR[25] = \<const0> ;
  assign M_AXI_ARADDR[24] = \<const0> ;
  assign M_AXI_ARADDR[23] = \<const0> ;
  assign M_AXI_ARADDR[22] = \<const0> ;
  assign M_AXI_ARADDR[21] = \<const0> ;
  assign M_AXI_ARADDR[20] = \<const0> ;
  assign M_AXI_ARADDR[19] = \<const0> ;
  assign M_AXI_ARADDR[18] = \<const0> ;
  assign M_AXI_ARADDR[17] = \<const0> ;
  assign M_AXI_ARADDR[16] = \<const0> ;
  assign M_AXI_ARADDR[15] = \<const0> ;
  assign M_AXI_ARADDR[14] = \<const0> ;
  assign M_AXI_ARADDR[13] = \<const0> ;
  assign M_AXI_ARADDR[12] = \<const0> ;
  assign M_AXI_ARADDR[11] = \<const0> ;
  assign M_AXI_ARADDR[10] = \<const0> ;
  assign M_AXI_ARADDR[9] = \<const0> ;
  assign M_AXI_ARADDR[8] = \<const0> ;
  assign M_AXI_ARADDR[7] = \<const0> ;
  assign M_AXI_ARADDR[6] = \<const0> ;
  assign M_AXI_ARADDR[5] = \^M_AXI_ARADDR [5];
  assign M_AXI_ARADDR[4] = \<const0> ;
  assign M_AXI_ARADDR[3] = \<const0> ;
  assign M_AXI_ARADDR[2] = \<const0> ;
  assign M_AXI_ARADDR[1] = \<const0> ;
  assign M_AXI_ARADDR[0] = \<const0> ;
  assign M_AXI_ARPROT[2] = \<const0> ;
  assign M_AXI_ARPROT[1] = \<const0> ;
  assign M_AXI_ARPROT[0] = \<const1> ;
  assign M_AXI_AWADDR[31] = \<const0> ;
  assign M_AXI_AWADDR[30] = \<const0> ;
  assign M_AXI_AWADDR[29] = \<const0> ;
  assign M_AXI_AWADDR[28] = \<const0> ;
  assign M_AXI_AWADDR[27] = \<const0> ;
  assign M_AXI_AWADDR[26] = \<const0> ;
  assign M_AXI_AWADDR[25] = \<const0> ;
  assign M_AXI_AWADDR[24] = \<const0> ;
  assign M_AXI_AWADDR[23] = \<const0> ;
  assign M_AXI_AWADDR[22] = \<const0> ;
  assign M_AXI_AWADDR[21] = \<const0> ;
  assign M_AXI_AWADDR[20] = \<const0> ;
  assign M_AXI_AWADDR[19] = \<const0> ;
  assign M_AXI_AWADDR[18] = \<const0> ;
  assign M_AXI_AWADDR[17] = \<const0> ;
  assign M_AXI_AWADDR[16] = \<const0> ;
  assign M_AXI_AWADDR[15] = \<const0> ;
  assign M_AXI_AWADDR[14] = \<const0> ;
  assign M_AXI_AWADDR[13] = \<const0> ;
  assign M_AXI_AWADDR[12] = \<const0> ;
  assign M_AXI_AWADDR[11] = \<const0> ;
  assign M_AXI_AWADDR[10] = \<const0> ;
  assign M_AXI_AWADDR[9] = \<const0> ;
  assign M_AXI_AWADDR[8] = \<const0> ;
  assign M_AXI_AWADDR[7] = \<const0> ;
  assign M_AXI_AWADDR[6] = \<const0> ;
  assign M_AXI_AWADDR[5] = \<const0> ;
  assign M_AXI_AWADDR[4] = \<const0> ;
  assign M_AXI_AWADDR[3] = \<const0> ;
  assign M_AXI_AWADDR[2] = \<const0> ;
  assign M_AXI_AWADDR[1] = \<const0> ;
  assign M_AXI_AWADDR[0] = \<const0> ;
  assign M_AXI_AWPROT[2] = \<const0> ;
  assign M_AXI_AWPROT[1] = \<const0> ;
  assign M_AXI_AWPROT[0] = \<const0> ;
  assign M_AXI_AWVALID = \<const0> ;
  assign M_AXI_BREADY = \<const0> ;
  assign M_AXI_WDATA[31] = \<const0> ;
  assign M_AXI_WDATA[30] = \<const0> ;
  assign M_AXI_WDATA[29] = \<const0> ;
  assign M_AXI_WDATA[28] = \<const0> ;
  assign M_AXI_WDATA[27] = \<const0> ;
  assign M_AXI_WDATA[26] = \<const0> ;
  assign M_AXI_WDATA[25] = \<const0> ;
  assign M_AXI_WDATA[24] = \<const0> ;
  assign M_AXI_WDATA[23] = \<const0> ;
  assign M_AXI_WDATA[22] = \<const0> ;
  assign M_AXI_WDATA[21] = \<const0> ;
  assign M_AXI_WDATA[20] = \<const0> ;
  assign M_AXI_WDATA[19] = \<const0> ;
  assign M_AXI_WDATA[18] = \<const0> ;
  assign M_AXI_WDATA[17] = \<const0> ;
  assign M_AXI_WDATA[16] = \<const0> ;
  assign M_AXI_WDATA[15] = \<const0> ;
  assign M_AXI_WDATA[14] = \<const0> ;
  assign M_AXI_WDATA[13] = \<const0> ;
  assign M_AXI_WDATA[12] = \<const0> ;
  assign M_AXI_WDATA[11] = \<const0> ;
  assign M_AXI_WDATA[10] = \<const0> ;
  assign M_AXI_WDATA[9] = \<const0> ;
  assign M_AXI_WDATA[8] = \<const0> ;
  assign M_AXI_WDATA[7] = \<const0> ;
  assign M_AXI_WDATA[6] = \<const0> ;
  assign M_AXI_WDATA[5] = \<const0> ;
  assign M_AXI_WDATA[4] = \<const0> ;
  assign M_AXI_WDATA[3] = \<const0> ;
  assign M_AXI_WDATA[2] = \<const0> ;
  assign M_AXI_WDATA[1] = \<const0> ;
  assign M_AXI_WDATA[0] = \<const0> ;
  assign M_AXI_WSTRB[3] = \<const1> ;
  assign M_AXI_WSTRB[2] = \<const1> ;
  assign M_AXI_WSTRB[1] = \<const1> ;
  assign M_AXI_WSTRB[0] = \<const1> ;
  assign M_AXI_WVALID = \<const0> ;
  assign error_flag = \<const0> ;
  assign state[1] = \<const0> ;
  assign state[0] = \^state [0];
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  system_ttl_gen_axi_v2_0_M00_AXI_0_0_ttl_gen_axi_v2_0_M00_AXI inst
       (.M_AXI_ACLK(M_AXI_ACLK),
        .M_AXI_ARADDR(\^M_AXI_ARADDR ),
        .M_AXI_ARESETN(M_AXI_ARESETN),
        .M_AXI_ARREADY(M_AXI_ARREADY),
        .M_AXI_ARVALID(M_AXI_ARVALID),
        .M_AXI_RREADY(M_AXI_RREADY),
        .M_AXI_RVALID(M_AXI_RVALID),
        .arm(arm),
        .clk(clk),
        .num_cycles(num_cycles[31:1]),
        .\state[0] (\^state ));
endmodule

(* ORIG_REF_NAME = "ttl_gen_axi_v2_0_M00_AXI" *) 
module system_ttl_gen_axi_v2_0_M00_AXI_0_0_ttl_gen_axi_v2_0_M00_AXI
   (M_AXI_RREADY,
    \state[0] ,
    M_AXI_ARVALID,
    M_AXI_ARADDR,
    arm,
    clk,
    M_AXI_RVALID,
    M_AXI_ARESETN,
    M_AXI_ACLK,
    num_cycles,
    M_AXI_ARREADY);
  output M_AXI_RREADY;
  output \state[0] ;
  output M_AXI_ARVALID;
  output [0:0]M_AXI_ARADDR;
  input arm;
  input clk;
  input M_AXI_RVALID;
  input M_AXI_ARESETN;
  input M_AXI_ACLK;
  input [30:0]num_cycles;
  input M_AXI_ARREADY;

  wire M_AXI_ACLK;
  wire [0:0]M_AXI_ARADDR;
  wire M_AXI_ARESETN;
  wire M_AXI_ARREADY;
  wire M_AXI_ARVALID;
  wire M_AXI_RREADY;
  wire M_AXI_RVALID;
  wire arm;
  wire arm_last;
  wire \axi_araddr[5]_i_10_n_0 ;
  wire \axi_araddr[5]_i_11_n_0 ;
  wire \axi_araddr[5]_i_12_n_0 ;
  wire \axi_araddr[5]_i_1_n_0 ;
  wire \axi_araddr[5]_i_2_n_0 ;
  wire \axi_araddr[5]_i_3_n_0 ;
  wire \axi_araddr[5]_i_4_n_0 ;
  wire \axi_araddr[5]_i_5_n_0 ;
  wire \axi_araddr[5]_i_6_n_0 ;
  wire \axi_araddr[5]_i_7_n_0 ;
  wire \axi_araddr[5]_i_8_n_0 ;
  wire \axi_araddr[5]_i_9_n_0 ;
  wire axi_arvalid_i_1_n_0;
  wire axi_rready_i_1_n_0;
  wire clk;
  wire [2:0]last_read;
  wire \last_read[0]_i_1_n_0 ;
  wire \last_read[1]_i_1_n_0 ;
  wire \last_read[2]_i_1_n_0 ;
  wire [30:0]num_cycles;
  wire [2:0]read_index;
  wire \read_index[0]_i_1_n_0 ;
  wire \read_index[1]_i_1_n_0 ;
  wire \read_index[2]_i_1_n_0 ;
  wire start_single_read;
  wire \state[0] ;
  wire \state_reg[0]_i_1_n_0 ;

  FDRE arm_last_reg
       (.C(clk),
        .CE(1'b1),
        .D(arm),
        .Q(arm_last),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h5555FFFF00008880)) 
    \axi_araddr[5]_i_1 
       (.I0(\state[0] ),
        .I1(\axi_araddr[5]_i_2_n_0 ),
        .I2(\axi_araddr[5]_i_3_n_0 ),
        .I3(\axi_araddr[5]_i_4_n_0 ),
        .I4(\axi_araddr[5]_i_5_n_0 ),
        .I5(M_AXI_ARADDR),
        .O(\axi_araddr[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \axi_araddr[5]_i_10 
       (.I0(num_cycles[26]),
        .I1(num_cycles[27]),
        .I2(num_cycles[24]),
        .I3(num_cycles[25]),
        .O(\axi_araddr[5]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \axi_araddr[5]_i_11 
       (.I0(num_cycles[18]),
        .I1(num_cycles[19]),
        .I2(num_cycles[16]),
        .I3(num_cycles[17]),
        .O(\axi_araddr[5]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \axi_araddr[5]_i_12 
       (.I0(num_cycles[22]),
        .I1(num_cycles[23]),
        .I2(num_cycles[20]),
        .I3(num_cycles[21]),
        .O(\axi_araddr[5]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h0008804004022010)) 
    \axi_araddr[5]_i_2 
       (.I0(read_index[1]),
        .I1(read_index[2]),
        .I2(read_index[0]),
        .I3(last_read[1]),
        .I4(last_read[0]),
        .I5(last_read[2]),
        .O(\axi_araddr[5]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \axi_araddr[5]_i_3 
       (.I0(\axi_araddr[5]_i_6_n_0 ),
        .I1(\axi_araddr[5]_i_7_n_0 ),
        .I2(\axi_araddr[5]_i_8_n_0 ),
        .I3(\axi_araddr[5]_i_9_n_0 ),
        .O(\axi_araddr[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \axi_araddr[5]_i_4 
       (.I0(\axi_araddr[5]_i_10_n_0 ),
        .I1(num_cycles[29]),
        .I2(num_cycles[28]),
        .I3(num_cycles[30]),
        .I4(\axi_araddr[5]_i_11_n_0 ),
        .I5(\axi_araddr[5]_i_12_n_0 ),
        .O(\axi_araddr[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \axi_araddr[5]_i_5 
       (.I0(last_read[0]),
        .I1(read_index[0]),
        .I2(last_read[2]),
        .I3(read_index[2]),
        .I4(last_read[1]),
        .I5(read_index[1]),
        .O(\axi_araddr[5]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \axi_araddr[5]_i_6 
       (.I0(num_cycles[10]),
        .I1(num_cycles[11]),
        .I2(num_cycles[8]),
        .I3(num_cycles[9]),
        .O(\axi_araddr[5]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \axi_araddr[5]_i_7 
       (.I0(num_cycles[14]),
        .I1(num_cycles[15]),
        .I2(num_cycles[12]),
        .I3(num_cycles[13]),
        .O(\axi_araddr[5]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \axi_araddr[5]_i_8 
       (.I0(num_cycles[2]),
        .I1(num_cycles[3]),
        .I2(num_cycles[0]),
        .I3(num_cycles[1]),
        .O(\axi_araddr[5]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \axi_araddr[5]_i_9 
       (.I0(num_cycles[6]),
        .I1(num_cycles[7]),
        .I2(num_cycles[4]),
        .I3(num_cycles[5]),
        .O(\axi_araddr[5]_i_9_n_0 ));
  FDRE \axi_araddr_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(\axi_araddr[5]_i_1_n_0 ),
        .Q(M_AXI_ARADDR),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hF400)) 
    axi_arvalid_i_1
       (.I0(M_AXI_ARREADY),
        .I1(M_AXI_ARVALID),
        .I2(start_single_read),
        .I3(M_AXI_ARESETN),
        .O(axi_arvalid_i_1_n_0));
  FDRE axi_arvalid_reg
       (.C(M_AXI_ACLK),
        .CE(1'b1),
        .D(axi_arvalid_i_1_n_0),
        .Q(M_AXI_ARVALID),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h20)) 
    axi_rready_i_1
       (.I0(M_AXI_RVALID),
        .I1(M_AXI_RREADY),
        .I2(M_AXI_ARESETN),
        .O(axi_rready_i_1_n_0));
  FDRE axi_rready_reg
       (.C(M_AXI_ACLK),
        .CE(1'b1),
        .D(axi_rready_i_1_n_0),
        .Q(M_AXI_RREADY),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \last_read[0]_i_1 
       (.I0(read_index[0]),
        .I1(\state[0] ),
        .I2(last_read[0]),
        .O(\last_read[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \last_read[1]_i_1 
       (.I0(read_index[1]),
        .I1(\state[0] ),
        .I2(last_read[1]),
        .O(\last_read[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \last_read[2]_i_1 
       (.I0(read_index[2]),
        .I1(\state[0] ),
        .I2(last_read[2]),
        .O(\last_read[2]_i_1_n_0 ));
  FDRE \last_read_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\last_read[0]_i_1_n_0 ),
        .Q(last_read[0]),
        .R(1'b0));
  FDRE \last_read_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\last_read[1]_i_1_n_0 ),
        .Q(last_read[1]),
        .R(1'b0));
  FDRE \last_read_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\last_read[2]_i_1_n_0 ),
        .Q(last_read[2]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h60)) 
    \read_index[0]_i_1 
       (.I0(read_index[0]),
        .I1(start_single_read),
        .I2(M_AXI_ARESETN),
        .O(\read_index[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \read_index[1]_i_1 
       (.I0(read_index[1]),
        .I1(start_single_read),
        .I2(read_index[0]),
        .I3(M_AXI_ARESETN),
        .O(\read_index[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \read_index[2]_i_1 
       (.I0(read_index[2]),
        .I1(start_single_read),
        .I2(read_index[1]),
        .I3(read_index[0]),
        .I4(M_AXI_ARESETN),
        .O(\read_index[2]_i_1_n_0 ));
  FDRE \read_index_reg[0] 
       (.C(M_AXI_ACLK),
        .CE(1'b1),
        .D(\read_index[0]_i_1_n_0 ),
        .Q(read_index[0]),
        .R(1'b0));
  FDRE \read_index_reg[1] 
       (.C(M_AXI_ACLK),
        .CE(1'b1),
        .D(\read_index[1]_i_1_n_0 ),
        .Q(read_index[1]),
        .R(1'b0));
  FDRE \read_index_reg[2] 
       (.C(M_AXI_ACLK),
        .CE(1'b1),
        .D(\read_index[2]_i_1_n_0 ),
        .Q(read_index[2]),
        .R(1'b0));
  FDRE start_single_read_reg
       (.C(clk),
        .CE(1'b1),
        .D(\state[0] ),
        .Q(start_single_read),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hC4)) 
    \state_reg[0]_i_1 
       (.I0(arm_last),
        .I1(arm),
        .I2(\state[0] ),
        .O(\state_reg[0]_i_1_n_0 ));
  FDRE \state_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\state_reg[0]_i_1_n_0 ),
        .Q(\state[0] ),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
