----------------------------------------------------------------------------------
-- Company: Grand Valley State University
-- Engineer: Joshua Johnston and Jordan Hayes
-- Create Date: 02/05/2022 
-- Project Name: Project 1: UART Serial Decoder 
-- Module Name: 2 bit Counter
-- Description: counts from 0 - 3 using 2 bits, incremented on the positive edge of the input
--              clock cycle 
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
----------------------------------------------------------
--entity
entity counter_2bit is
   Port (
            trigger_count, reset : in std_logic;
            count : out std_logic_vector(1 downto 0) 
         );
end counter_2bit;
-------------------------------------------------------------


-----------------------------------------------------------
architecture Behavioral of counter_2bit is

------------------------------------------------------------
--signals 
signal count_temp : std_logic_vector(1 downto 0) := "00"; 

---------------------------------------------------------------

begin
    process(trigger_count, reset)
     begin 
       if(  (trigger_count'event) and (trigger_count = '1')  ) then                      --for only counting one pos edge 
        if(reset = '1') then 
            count_temp <= "00"; 
        else 
            count_temp <= count_temp + 1;
        end if;
       end if;
    end process; 
    
    count <= count_temp; 
    
end Behavioral;
