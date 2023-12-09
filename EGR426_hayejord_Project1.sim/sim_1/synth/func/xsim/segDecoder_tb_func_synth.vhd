-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Thu Feb  3 19:57:08 2022
-- Host        : DESKTOP-9ED2F6A running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/Users/19896/EGR426_hayejord_Project1/EGR426_hayejord_Project1.sim/sim_1/synth/func/xsim/segDecoder_tb_func_synth.vhd
-- Design      : Proj1_serialDecoder
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7s50csga324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Proj1_serialDecoder is
  port (
    clk_100M : in STD_LOGIC;
    reset : in STD_LOGIC;
    annode_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Seg_out : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Proj1_serialDecoder : entity is true;
end Proj1_serialDecoder;

architecture STRUCTURE of Proj1_serialDecoder is
begin
\Seg_out_OBUF[0]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Seg_out(0),
      T => '1'
    );
\Seg_out_OBUF[1]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Seg_out(1),
      T => '1'
    );
\Seg_out_OBUF[2]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Seg_out(2),
      T => '1'
    );
\Seg_out_OBUF[3]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Seg_out(3),
      T => '1'
    );
\Seg_out_OBUF[4]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Seg_out(4),
      T => '1'
    );
\Seg_out_OBUF[5]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Seg_out(5),
      T => '1'
    );
\Seg_out_OBUF[6]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Seg_out(6),
      T => '1'
    );
\Seg_out_OBUF[7]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Seg_out(7),
      T => '1'
    );
\annode_out_OBUF[0]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => annode_out(0),
      T => '1'
    );
\annode_out_OBUF[1]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => annode_out(1),
      T => '1'
    );
\annode_out_OBUF[2]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => annode_out(2),
      T => '1'
    );
\annode_out_OBUF[3]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => annode_out(3),
      T => '1'
    );
end STRUCTURE;
