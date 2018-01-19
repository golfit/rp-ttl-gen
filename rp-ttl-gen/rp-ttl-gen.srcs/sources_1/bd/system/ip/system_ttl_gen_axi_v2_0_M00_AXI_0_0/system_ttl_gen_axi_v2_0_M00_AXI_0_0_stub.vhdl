-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
-- Date        : Fri Jan 19 18:16:58 2018
-- Host        : cmodws121 running 64-bit Red Hat Enterprise Linux Server release 7.4 (Maipo)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/golfit/git/rp/rp-ttl-gen/rp-ttl-gen/rp-ttl-gen.srcs/sources_1/bd/system/ip/system_ttl_gen_axi_v2_0_M00_AXI_0_0/system_ttl_gen_axi_v2_0_M00_AXI_0_0_stub.vhdl
-- Design      : system_ttl_gen_axi_v2_0_M00_AXI_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_ttl_gen_axi_v2_0_M00_AXI_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    arm : in STD_LOGIC;
    trig : in STD_LOGIC;
    num_cycles : in STD_LOGIC_VECTOR ( 31 downto 0 );
    num_reps : in STD_LOGIC_VECTOR ( 31 downto 0 );
    init_val : in STD_LOGIC;
    v_out : out STD_LOGIC;
    state : out STD_LOGIC_VECTOR ( 1 downto 0 );
    error_flag : out STD_LOGIC;
    M_AXI_ACLK : in STD_LOGIC;
    M_AXI_ARESETN : in STD_LOGIC;
    M_AXI_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_AWVALID : out STD_LOGIC;
    M_AXI_AWREADY : in STD_LOGIC;
    M_AXI_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_WVALID : out STD_LOGIC;
    M_AXI_WREADY : in STD_LOGIC;
    M_AXI_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_BVALID : in STD_LOGIC;
    M_AXI_BREADY : out STD_LOGIC;
    M_AXI_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_ARVALID : out STD_LOGIC;
    M_AXI_ARREADY : in STD_LOGIC;
    M_AXI_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_RVALID : in STD_LOGIC;
    M_AXI_RREADY : out STD_LOGIC
  );

end system_ttl_gen_axi_v2_0_M00_AXI_0_0;

architecture stub of system_ttl_gen_axi_v2_0_M00_AXI_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,arm,trig,num_cycles[31:0],num_reps[31:0],init_val,v_out,state[1:0],error_flag,M_AXI_ACLK,M_AXI_ARESETN,M_AXI_AWADDR[31:0],M_AXI_AWPROT[2:0],M_AXI_AWVALID,M_AXI_AWREADY,M_AXI_WDATA[31:0],M_AXI_WSTRB[3:0],M_AXI_WVALID,M_AXI_WREADY,M_AXI_BRESP[1:0],M_AXI_BVALID,M_AXI_BREADY,M_AXI_ARADDR[31:0],M_AXI_ARPROT[2:0],M_AXI_ARVALID,M_AXI_ARREADY,M_AXI_RDATA[31:0],M_AXI_RRESP[1:0],M_AXI_RVALID,M_AXI_RREADY";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ttl_gen_axi_v2_0_M00_AXI,Vivado 2017.4";
begin
end;
