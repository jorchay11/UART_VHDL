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
library UNISIM;
use UNISIM.VComponents.all;
use std.textio.all; 
use ieee.std_logic_textio.all; 



entity clk_1K_tb is
   -- Port ( );
end clk_1K_tb;


architecture Behavioral of clk_1K_tb is

component Clk_1K 
port (clk_in : in STD_LOGIC;
      reset : in STD_LOGIC;
      clk_out : out STD_LOGIC
      );
end component; 

signal clk_in: std_logic := '0'; 
signal reset: std_logic := '0'; 
signal clk_out: std_logic; 
signal clk_posEdge_count : integer := 0; 
signal shouldBe_flag : std_logic := '1'; 
signal invCount_forSim : integer := 10;        --change for number chosen in entity

--signal clk_count : STD_LOGIC_VECTOR(15 downto 0);
--signal clk_out_temp : std_logic := '0';
 PROCEDURE MonitorOut(clk_out_ShouldBe : in std_logic) is 
 VARIABLE lout: line; 
 begin
WRITE(lout, NOW, right, 10, ns); 
WRITE(lout, string'("  Clk input -->")); 
WRITE(lout, clk_in);
WRITE(lout, string'("  Reset -->")); 
WRITE(lout, reset);
WRITE(lout, string'("  Clk Out -->")); 
WRITE(lout, clk_out);
WRITELINE(OUTPUT, lout); 
ASSERT clk_out = clk_out_ShouldBe REPORT "Test Failed, Clk_out is not correct" SEVERITY FAILURE; 
end MonitorOut; 
          
-------------------------------------------------------------------------------------
begin
T1: Clk_1K port map(clk_in => clk_in, clk_out => clk_out, reset => reset);

    process --designed for 10 count cycle 
    begin 
    
        wait for 100 ns; 
        REPORT "Beginning the 1KHz clktest" SEVERITY NOTE; 
        
        REPORT "Test 1: Initialized by reset. clk_out expected: 0" SEVERITY NOTE;
        reset <= '1';
        wait for 1 ns;
        MonitorOut('0'); 
        
        reset <= '0';
        wait for 10 ns; 
            
        for i in 0 to 31 loop
            
            clk_in <= '0'; 
            wait for 1 ns; 
            clk_in <= '1'; 
            wait for 1 ns; 
            
            clk_posEdge_count <= clk_posEdge_count + 1;
           
            
            if(clk_posEdge_count = invCount_forSim) then 
                clk_posEdge_count <= 0; 
                
                if(shouldBe_flag = '1') then 
                    REPORT "Test 2: Looped through specified number of cycles. clk_out expected: 1" SEVERITY NOTE;
                    shouldBe_flag <= '0'; 
                    MonitorOut('1'); 
                else
                    REPORT "Test 3: Looped through specified number of cycles twice. clk_out expected: 0" SEVERITY NOTE;
                    shouldBe_flag <= '1';
                    MonitorOut('0');
                end if;
            end if;                    
        end loop; 
       
       
        REPORT "Test 4: Reset. clk_out expected: 0" SEVERITY NOTE; 
        clk_in <= '0';
        wait for 100 ns; 
        reset <= '1'; 
        wait for 10 ns; 
        clk_in <= '1'; 
        wait for 1 ns; 
        reset <= '0'; 
        wait for 1 ns; 
        clk_in <= '0'; 
        
        wait for 1 ns; 
        MonitorOut('0'); 
        
--        reset <= '0';           --in case he wants to see this as well
--        wait for 1 ns; 
--        MonitorOut('0');
        
    end process; 
end Behavioral;
