----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2022 09:35:14 PM
-- Design Name: 
-- Module Name: Clk_1K - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
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



entity Clk_25M is
    Port ( clk_in       : in std_logic := '0'; 
            reset       : in STD_LOGIC := '0'; 
            clk_out     : out STD_LOGIC
            );
end Clk_25M;

architecture Behavioral of Clk_25M is

signal clk_count : STD_LOGIC_VECTOR(1 downto 0) := "00";
--type clk_count is array(15 downto 0) of bit;                  --what was this? in lectures somewhere 
signal clk_out_temp : std_logic := '0';

begin
--declare a 16 bit count 
    process(clk_in, reset)
        begin         
        if(reset = '1') then
            clk_out_temp <= '0'; 
            clk_count <= "00";
        
        --elsif    
        elsif((clk_in'event) and (clk_in = '1')) then
           if(clk_count = 2) then              
                clk_count <= "00"; 
                clk_out_temp <=  not clk_out_temp; 
            else 
                clk_count <= clk_count + 1; 
                clk_out_temp <= clk_out_temp;           --this is for 
            end if;
            end if; 
       end process;
      
   clk_out <= clk_out_temp;
                    
end Behavioral;

