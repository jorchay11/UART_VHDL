----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2022 01:55:35 PM
-- Design Name: 
-- Module Name: clk_1K_tb - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity clk_25M_tb is
   -- Port ( );
end clk_25M_tb;


architecture Behavioral of clk_25M_tb is

component Clk_25M 
port (clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC
           );
end component; 

signal clk_in: std_logic := '0'; 
signal clk_out: std_logic; 
signal reset: std_logic := '0'; 

--signal clk_count : STD_LOGIC_VECTOR(15 downto 0);
--signal clk_out_temp : std_logic := '0';

begin
T1: Clk_25M port map(clk_in => clk_in, clk_out => clk_out, reset => reset);
--clk_count => clk_count
    process
    begin 
        wait for 100 ns; 
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        loop
            clk_in <= '0'; 
            wait for 10 ns; 
            clk_in <= '1'; 
            wait for 10 ns; 
            end loop; 
        end process; 
    

end Behavioral;
