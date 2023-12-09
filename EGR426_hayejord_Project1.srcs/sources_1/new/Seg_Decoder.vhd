----------------------------------------------------------------------------------
-- Company: Grand Valley State University
-- Engineer: Joshua Johnston and Jordan Hayes
-- Create Date: 02/05/2022 
-- Project Name: Project 1: UART Serial Decoder 
-- Module Name: Seg_decoder
-- Description: Decodes a 4 bit hex integer into an 8 bit bus of segments for displaying the value 
--                  on an 8 segment bus 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 
library UNISIM;
use UNISIM.VComponents.all;
use std.textio.all; 
use ieee.std_logic_textio.all; 



--------------------------------------------------------------
--entity
entity seg_decoder is
    Port (
           integer_4bit : in STD_LOGIC_VECTOR (3 downto 0);
           dout_busToSeg : out STD_LOGIC_VECTOR (7 downto 0)
          );
end seg_decoder;

--------------------------------------------------------------
architecture Behavioral of seg_decoder is

begin
  
  process(integer_4bit)
    begin 
        
    case (integer_4bit) is 
        when "0000" => dout_busToSeg <= "11000000";         --0
        when "0001" => dout_busToSeg <= "11111001";         --1
        when "0010" => dout_busToSeg <= "10100100";         --2
        when "0011" => dout_busToSeg <= "10110000";         --3
        when "0100" => dout_busToSeg <= "10011001";         --4
        when "0101" => dout_busToSeg <= "10010010";         --5
        when "0110" => dout_busToSeg <= "10000010";         --6
        when "0111" => dout_busToSeg <= "11111000";         --7
        when "1000" => dout_busToSeg <= "10000000";         --8
        when "1001" => dout_busToSeg <= "10011000";         --9
        when "1010" => dout_busToSeg <= "10001000";         --A
        when "1011" => dout_busToSeg <= "10000011";         --b       --
        when "1100" => dout_busToSeg <= "11000110";         --C
        when "1101" => dout_busToSeg <= "10100001";         --d
        when "1110" => dout_busToSeg <= "10000110";         --E
        when "1111" => dout_busToSeg <= "10001110";         --F
        when others => dout_busToSeg <= "11111111"; 
    end case; 
    end process;
        
end Behavioral;
