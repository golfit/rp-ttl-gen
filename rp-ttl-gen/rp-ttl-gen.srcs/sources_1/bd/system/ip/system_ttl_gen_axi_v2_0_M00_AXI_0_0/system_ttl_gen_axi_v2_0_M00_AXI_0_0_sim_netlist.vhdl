-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
-- Date        : Tue Jan 23 22:19:53 2018
-- Host        : cmodws121 running 64-bit Red Hat Enterprise Linux Server release 7.4 (Maipo)
-- Command     : write_vhdl -force -mode funcsim
--               /home/golfit/git/rp/rp-ttl-gen/rp-ttl-gen/rp-ttl-gen.srcs/sources_1/bd/system/ip/system_ttl_gen_axi_v2_0_M00_AXI_0_0/system_ttl_gen_axi_v2_0_M00_AXI_0_0_sim_netlist.vhdl
-- Design      : system_ttl_gen_axi_v2_0_M00_AXI_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_ttl_gen_axi_v2_0_M00_AXI_0_0_ttl_gen_axi_v2_0_M00_AXI is
  port (
    M_AXI_RREADY : out STD_LOGIC;
    \state[0]\ : out STD_LOGIC;
    M_AXI_ARVALID : out STD_LOGIC;
    M_AXI_ARADDR : out STD_LOGIC_VECTOR ( 0 to 0 );
    arm : in STD_LOGIC;
    clk : in STD_LOGIC;
    M_AXI_RVALID : in STD_LOGIC;
    M_AXI_ARESETN : in STD_LOGIC;
    M_AXI_ACLK : in STD_LOGIC;
    num_cycles : in STD_LOGIC_VECTOR ( 30 downto 0 );
    M_AXI_ARREADY : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_ttl_gen_axi_v2_0_M00_AXI_0_0_ttl_gen_axi_v2_0_M00_AXI : entity is "ttl_gen_axi_v2_0_M00_AXI";
end system_ttl_gen_axi_v2_0_M00_AXI_0_0_ttl_gen_axi_v2_0_M00_AXI;

architecture STRUCTURE of system_ttl_gen_axi_v2_0_M00_AXI_0_0_ttl_gen_axi_v2_0_M00_AXI is
  signal \^m_axi_araddr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^m_axi_arvalid\ : STD_LOGIC;
  signal \^m_axi_rready\ : STD_LOGIC;
  signal arm_last : STD_LOGIC;
  signal \axi_araddr[5]_i_10_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_11_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_12_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_1_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_2_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_3_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_4_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_5_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_6_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_7_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_8_n_0\ : STD_LOGIC;
  signal \axi_araddr[5]_i_9_n_0\ : STD_LOGIC;
  signal axi_arvalid_i_1_n_0 : STD_LOGIC;
  signal axi_rready_i_1_n_0 : STD_LOGIC;
  signal last_read : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \last_read[0]_i_1_n_0\ : STD_LOGIC;
  signal \last_read[1]_i_1_n_0\ : STD_LOGIC;
  signal \last_read[2]_i_1_n_0\ : STD_LOGIC;
  signal read_index : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \read_index[0]_i_1_n_0\ : STD_LOGIC;
  signal \read_index[1]_i_1_n_0\ : STD_LOGIC;
  signal \read_index[2]_i_1_n_0\ : STD_LOGIC;
  signal start_single_read : STD_LOGIC;
  signal \^state[0]\ : STD_LOGIC;
  signal \state_reg[0]_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of axi_arvalid_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \last_read[0]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \last_read[1]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \last_read[2]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \read_index[0]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \read_index[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \read_index[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \state_reg[0]_i_1\ : label is "soft_lutpair2";
begin
  M_AXI_ARADDR(0) <= \^m_axi_araddr\(0);
  M_AXI_ARVALID <= \^m_axi_arvalid\;
  M_AXI_RREADY <= \^m_axi_rready\;
  \state[0]\ <= \^state[0]\;
arm_last_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => arm,
      Q => arm_last,
      R => '0'
    );
\axi_araddr[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555FFFF00008880"
    )
        port map (
      I0 => \^state[0]\,
      I1 => \axi_araddr[5]_i_2_n_0\,
      I2 => \axi_araddr[5]_i_3_n_0\,
      I3 => \axi_araddr[5]_i_4_n_0\,
      I4 => \axi_araddr[5]_i_5_n_0\,
      I5 => \^m_axi_araddr\(0),
      O => \axi_araddr[5]_i_1_n_0\
    );
\axi_araddr[5]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => num_cycles(26),
      I1 => num_cycles(27),
      I2 => num_cycles(24),
      I3 => num_cycles(25),
      O => \axi_araddr[5]_i_10_n_0\
    );
\axi_araddr[5]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => num_cycles(18),
      I1 => num_cycles(19),
      I2 => num_cycles(16),
      I3 => num_cycles(17),
      O => \axi_araddr[5]_i_11_n_0\
    );
\axi_araddr[5]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => num_cycles(22),
      I1 => num_cycles(23),
      I2 => num_cycles(20),
      I3 => num_cycles(21),
      O => \axi_araddr[5]_i_12_n_0\
    );
\axi_araddr[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0008804004022010"
    )
        port map (
      I0 => read_index(1),
      I1 => read_index(2),
      I2 => read_index(0),
      I3 => last_read(1),
      I4 => last_read(0),
      I5 => last_read(2),
      O => \axi_araddr[5]_i_2_n_0\
    );
\axi_araddr[5]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \axi_araddr[5]_i_6_n_0\,
      I1 => \axi_araddr[5]_i_7_n_0\,
      I2 => \axi_araddr[5]_i_8_n_0\,
      I3 => \axi_araddr[5]_i_9_n_0\,
      O => \axi_araddr[5]_i_3_n_0\
    );
\axi_araddr[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \axi_araddr[5]_i_10_n_0\,
      I1 => num_cycles(29),
      I2 => num_cycles(28),
      I3 => num_cycles(30),
      I4 => \axi_araddr[5]_i_11_n_0\,
      I5 => \axi_araddr[5]_i_12_n_0\,
      O => \axi_araddr[5]_i_4_n_0\
    );
\axi_araddr[5]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => last_read(0),
      I1 => read_index(0),
      I2 => last_read(2),
      I3 => read_index(2),
      I4 => last_read(1),
      I5 => read_index(1),
      O => \axi_araddr[5]_i_5_n_0\
    );
\axi_araddr[5]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => num_cycles(10),
      I1 => num_cycles(11),
      I2 => num_cycles(8),
      I3 => num_cycles(9),
      O => \axi_araddr[5]_i_6_n_0\
    );
\axi_araddr[5]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => num_cycles(14),
      I1 => num_cycles(15),
      I2 => num_cycles(12),
      I3 => num_cycles(13),
      O => \axi_araddr[5]_i_7_n_0\
    );
\axi_araddr[5]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => num_cycles(2),
      I1 => num_cycles(3),
      I2 => num_cycles(0),
      I3 => num_cycles(1),
      O => \axi_araddr[5]_i_8_n_0\
    );
\axi_araddr[5]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => num_cycles(6),
      I1 => num_cycles(7),
      I2 => num_cycles(4),
      I3 => num_cycles(5),
      O => \axi_araddr[5]_i_9_n_0\
    );
\axi_araddr_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \axi_araddr[5]_i_1_n_0\,
      Q => \^m_axi_araddr\(0),
      R => '0'
    );
axi_arvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F400"
    )
        port map (
      I0 => M_AXI_ARREADY,
      I1 => \^m_axi_arvalid\,
      I2 => start_single_read,
      I3 => M_AXI_ARESETN,
      O => axi_arvalid_i_1_n_0
    );
axi_arvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => M_AXI_ACLK,
      CE => '1',
      D => axi_arvalid_i_1_n_0,
      Q => \^m_axi_arvalid\,
      R => '0'
    );
axi_rready_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => M_AXI_RVALID,
      I1 => \^m_axi_rready\,
      I2 => M_AXI_ARESETN,
      O => axi_rready_i_1_n_0
    );
axi_rready_reg: unisim.vcomponents.FDRE
     port map (
      C => M_AXI_ACLK,
      CE => '1',
      D => axi_rready_i_1_n_0,
      Q => \^m_axi_rready\,
      R => '0'
    );
\last_read[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => read_index(0),
      I1 => \^state[0]\,
      I2 => last_read(0),
      O => \last_read[0]_i_1_n_0\
    );
\last_read[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => read_index(1),
      I1 => \^state[0]\,
      I2 => last_read(1),
      O => \last_read[1]_i_1_n_0\
    );
\last_read[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => read_index(2),
      I1 => \^state[0]\,
      I2 => last_read(2),
      O => \last_read[2]_i_1_n_0\
    );
\last_read_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \last_read[0]_i_1_n_0\,
      Q => last_read(0),
      R => '0'
    );
\last_read_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \last_read[1]_i_1_n_0\,
      Q => last_read(1),
      R => '0'
    );
\last_read_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \last_read[2]_i_1_n_0\,
      Q => last_read(2),
      R => '0'
    );
\read_index[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"60"
    )
        port map (
      I0 => read_index(0),
      I1 => start_single_read,
      I2 => M_AXI_ARESETN,
      O => \read_index[0]_i_1_n_0\
    );
\read_index[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6A00"
    )
        port map (
      I0 => read_index(1),
      I1 => start_single_read,
      I2 => read_index(0),
      I3 => M_AXI_ARESETN,
      O => \read_index[1]_i_1_n_0\
    );
\read_index[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAA0000"
    )
        port map (
      I0 => read_index(2),
      I1 => start_single_read,
      I2 => read_index(1),
      I3 => read_index(0),
      I4 => M_AXI_ARESETN,
      O => \read_index[2]_i_1_n_0\
    );
\read_index_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => M_AXI_ACLK,
      CE => '1',
      D => \read_index[0]_i_1_n_0\,
      Q => read_index(0),
      R => '0'
    );
\read_index_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => M_AXI_ACLK,
      CE => '1',
      D => \read_index[1]_i_1_n_0\,
      Q => read_index(1),
      R => '0'
    );
\read_index_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => M_AXI_ACLK,
      CE => '1',
      D => \read_index[2]_i_1_n_0\,
      Q => read_index(2),
      R => '0'
    );
start_single_read_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \^state[0]\,
      Q => start_single_read,
      R => '0'
    );
\state_reg[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C4"
    )
        port map (
      I0 => arm_last,
      I1 => arm,
      I2 => \^state[0]\,
      O => \state_reg[0]_i_1_n_0\
    );
\state_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \state_reg[0]_i_1_n_0\,
      Q => \^state[0]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_ttl_gen_axi_v2_0_M00_AXI_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of system_ttl_gen_axi_v2_0_M00_AXI_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of system_ttl_gen_axi_v2_0_M00_AXI_0_0 : entity is "system_ttl_gen_axi_v2_0_M00_AXI_0_0,ttl_gen_axi_v2_0_M00_AXI,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of system_ttl_gen_axi_v2_0_M00_AXI_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of system_ttl_gen_axi_v2_0_M00_AXI_0_0 : entity is "ttl_gen_axi_v2_0_M00_AXI,Vivado 2017.4";
end system_ttl_gen_axi_v2_0_M00_AXI_0_0;

architecture STRUCTURE of system_ttl_gen_axi_v2_0_M00_AXI_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^m_axi_araddr\ : STD_LOGIC_VECTOR ( 5 to 5 );
  signal \^state\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of M_AXI_ACLK : signal is "xilinx.com:signal:clock:1.0 M_AXI_ACLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of M_AXI_ACLK : signal is "XIL_INTERFACENAME M_AXI_ACLK, ASSOCIATED_BUSIF M_AXI, ASSOCIATED_RESET M_AXI_ARESETN, FREQ_HZ 1.25e+08, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0";
  attribute X_INTERFACE_INFO of M_AXI_ARESETN : signal is "xilinx.com:signal:reset:1.0 M_AXI_ARESETN RST";
  attribute X_INTERFACE_PARAMETER of M_AXI_ARESETN : signal is "XIL_INTERFACENAME M_AXI_ARESETN, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of M_AXI_ARREADY : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARREADY";
  attribute X_INTERFACE_INFO of M_AXI_ARVALID : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARVALID";
  attribute X_INTERFACE_INFO of M_AXI_AWREADY : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWREADY";
  attribute X_INTERFACE_INFO of M_AXI_AWVALID : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWVALID";
  attribute X_INTERFACE_INFO of M_AXI_BREADY : signal is "xilinx.com:interface:aximm:1.0 M_AXI BREADY";
  attribute X_INTERFACE_INFO of M_AXI_BVALID : signal is "xilinx.com:interface:aximm:1.0 M_AXI BVALID";
  attribute X_INTERFACE_INFO of M_AXI_RREADY : signal is "xilinx.com:interface:aximm:1.0 M_AXI RREADY";
  attribute X_INTERFACE_PARAMETER of M_AXI_RREADY : signal is "XIL_INTERFACENAME M_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 1.25e+08, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0";
  attribute X_INTERFACE_INFO of M_AXI_RVALID : signal is "xilinx.com:interface:aximm:1.0 M_AXI RVALID";
  attribute X_INTERFACE_INFO of M_AXI_WREADY : signal is "xilinx.com:interface:aximm:1.0 M_AXI WREADY";
  attribute X_INTERFACE_INFO of M_AXI_WVALID : signal is "xilinx.com:interface:aximm:1.0 M_AXI WVALID";
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 1.25e+08, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0";
  attribute X_INTERFACE_INFO of M_AXI_ARADDR : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARADDR";
  attribute X_INTERFACE_INFO of M_AXI_ARPROT : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARPROT";
  attribute X_INTERFACE_INFO of M_AXI_AWADDR : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWADDR";
  attribute X_INTERFACE_INFO of M_AXI_AWPROT : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWPROT";
  attribute X_INTERFACE_INFO of M_AXI_BRESP : signal is "xilinx.com:interface:aximm:1.0 M_AXI BRESP";
  attribute X_INTERFACE_INFO of M_AXI_RDATA : signal is "xilinx.com:interface:aximm:1.0 M_AXI RDATA";
  attribute X_INTERFACE_INFO of M_AXI_RRESP : signal is "xilinx.com:interface:aximm:1.0 M_AXI RRESP";
  attribute X_INTERFACE_INFO of M_AXI_WDATA : signal is "xilinx.com:interface:aximm:1.0 M_AXI WDATA";
  attribute X_INTERFACE_INFO of M_AXI_WSTRB : signal is "xilinx.com:interface:aximm:1.0 M_AXI WSTRB";
begin
  M_AXI_ARADDR(31) <= \<const0>\;
  M_AXI_ARADDR(30) <= \<const0>\;
  M_AXI_ARADDR(29) <= \<const0>\;
  M_AXI_ARADDR(28) <= \<const0>\;
  M_AXI_ARADDR(27) <= \<const0>\;
  M_AXI_ARADDR(26) <= \<const0>\;
  M_AXI_ARADDR(25) <= \<const0>\;
  M_AXI_ARADDR(24) <= \<const0>\;
  M_AXI_ARADDR(23) <= \<const0>\;
  M_AXI_ARADDR(22) <= \<const0>\;
  M_AXI_ARADDR(21) <= \<const0>\;
  M_AXI_ARADDR(20) <= \<const0>\;
  M_AXI_ARADDR(19) <= \<const0>\;
  M_AXI_ARADDR(18) <= \<const0>\;
  M_AXI_ARADDR(17) <= \<const0>\;
  M_AXI_ARADDR(16) <= \<const0>\;
  M_AXI_ARADDR(15) <= \<const0>\;
  M_AXI_ARADDR(14) <= \<const0>\;
  M_AXI_ARADDR(13) <= \<const0>\;
  M_AXI_ARADDR(12) <= \<const0>\;
  M_AXI_ARADDR(11) <= \<const0>\;
  M_AXI_ARADDR(10) <= \<const0>\;
  M_AXI_ARADDR(9) <= \<const0>\;
  M_AXI_ARADDR(8) <= \<const0>\;
  M_AXI_ARADDR(7) <= \<const0>\;
  M_AXI_ARADDR(6) <= \<const0>\;
  M_AXI_ARADDR(5) <= \^m_axi_araddr\(5);
  M_AXI_ARADDR(4) <= \<const0>\;
  M_AXI_ARADDR(3) <= \<const0>\;
  M_AXI_ARADDR(2) <= \<const0>\;
  M_AXI_ARADDR(1) <= \<const0>\;
  M_AXI_ARADDR(0) <= \<const0>\;
  M_AXI_ARPROT(2) <= \<const0>\;
  M_AXI_ARPROT(1) <= \<const0>\;
  M_AXI_ARPROT(0) <= \<const1>\;
  M_AXI_AWADDR(31) <= \<const0>\;
  M_AXI_AWADDR(30) <= \<const0>\;
  M_AXI_AWADDR(29) <= \<const0>\;
  M_AXI_AWADDR(28) <= \<const0>\;
  M_AXI_AWADDR(27) <= \<const0>\;
  M_AXI_AWADDR(26) <= \<const0>\;
  M_AXI_AWADDR(25) <= \<const0>\;
  M_AXI_AWADDR(24) <= \<const0>\;
  M_AXI_AWADDR(23) <= \<const0>\;
  M_AXI_AWADDR(22) <= \<const0>\;
  M_AXI_AWADDR(21) <= \<const0>\;
  M_AXI_AWADDR(20) <= \<const0>\;
  M_AXI_AWADDR(19) <= \<const0>\;
  M_AXI_AWADDR(18) <= \<const0>\;
  M_AXI_AWADDR(17) <= \<const0>\;
  M_AXI_AWADDR(16) <= \<const0>\;
  M_AXI_AWADDR(15) <= \<const0>\;
  M_AXI_AWADDR(14) <= \<const0>\;
  M_AXI_AWADDR(13) <= \<const0>\;
  M_AXI_AWADDR(12) <= \<const0>\;
  M_AXI_AWADDR(11) <= \<const0>\;
  M_AXI_AWADDR(10) <= \<const0>\;
  M_AXI_AWADDR(9) <= \<const0>\;
  M_AXI_AWADDR(8) <= \<const0>\;
  M_AXI_AWADDR(7) <= \<const0>\;
  M_AXI_AWADDR(6) <= \<const0>\;
  M_AXI_AWADDR(5) <= \<const0>\;
  M_AXI_AWADDR(4) <= \<const0>\;
  M_AXI_AWADDR(3) <= \<const0>\;
  M_AXI_AWADDR(2) <= \<const0>\;
  M_AXI_AWADDR(1) <= \<const0>\;
  M_AXI_AWADDR(0) <= \<const0>\;
  M_AXI_AWPROT(2) <= \<const0>\;
  M_AXI_AWPROT(1) <= \<const0>\;
  M_AXI_AWPROT(0) <= \<const0>\;
  M_AXI_AWVALID <= \<const0>\;
  M_AXI_BREADY <= \<const0>\;
  M_AXI_WDATA(31) <= \<const0>\;
  M_AXI_WDATA(30) <= \<const0>\;
  M_AXI_WDATA(29) <= \<const0>\;
  M_AXI_WDATA(28) <= \<const0>\;
  M_AXI_WDATA(27) <= \<const0>\;
  M_AXI_WDATA(26) <= \<const0>\;
  M_AXI_WDATA(25) <= \<const0>\;
  M_AXI_WDATA(24) <= \<const0>\;
  M_AXI_WDATA(23) <= \<const0>\;
  M_AXI_WDATA(22) <= \<const0>\;
  M_AXI_WDATA(21) <= \<const0>\;
  M_AXI_WDATA(20) <= \<const0>\;
  M_AXI_WDATA(19) <= \<const0>\;
  M_AXI_WDATA(18) <= \<const0>\;
  M_AXI_WDATA(17) <= \<const0>\;
  M_AXI_WDATA(16) <= \<const0>\;
  M_AXI_WDATA(15) <= \<const0>\;
  M_AXI_WDATA(14) <= \<const0>\;
  M_AXI_WDATA(13) <= \<const0>\;
  M_AXI_WDATA(12) <= \<const0>\;
  M_AXI_WDATA(11) <= \<const0>\;
  M_AXI_WDATA(10) <= \<const0>\;
  M_AXI_WDATA(9) <= \<const0>\;
  M_AXI_WDATA(8) <= \<const0>\;
  M_AXI_WDATA(7) <= \<const0>\;
  M_AXI_WDATA(6) <= \<const0>\;
  M_AXI_WDATA(5) <= \<const0>\;
  M_AXI_WDATA(4) <= \<const0>\;
  M_AXI_WDATA(3) <= \<const0>\;
  M_AXI_WDATA(2) <= \<const0>\;
  M_AXI_WDATA(1) <= \<const0>\;
  M_AXI_WDATA(0) <= \<const0>\;
  M_AXI_WSTRB(3) <= \<const1>\;
  M_AXI_WSTRB(2) <= \<const1>\;
  M_AXI_WSTRB(1) <= \<const1>\;
  M_AXI_WSTRB(0) <= \<const1>\;
  M_AXI_WVALID <= \<const0>\;
  error_flag <= \<const0>\;
  state(1) <= \<const0>\;
  state(0) <= \^state\(0);
  v_out <= 'Z';
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.system_ttl_gen_axi_v2_0_M00_AXI_0_0_ttl_gen_axi_v2_0_M00_AXI
     port map (
      M_AXI_ACLK => M_AXI_ACLK,
      M_AXI_ARADDR(0) => \^m_axi_araddr\(5),
      M_AXI_ARESETN => M_AXI_ARESETN,
      M_AXI_ARREADY => M_AXI_ARREADY,
      M_AXI_ARVALID => M_AXI_ARVALID,
      M_AXI_RREADY => M_AXI_RREADY,
      M_AXI_RVALID => M_AXI_RVALID,
      arm => arm,
      clk => clk,
      num_cycles(30 downto 0) => num_cycles(31 downto 1),
      \state[0]\ => \^state\(0)
    );
end STRUCTURE;
