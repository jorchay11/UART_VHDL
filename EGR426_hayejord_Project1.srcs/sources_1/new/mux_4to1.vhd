----------------------------------------------------------------------------------
-- Company: Grand Valley State University
-- Engineer: Jordan Hayes
-- Create Date: 4/19/2022
-- Project Name: Project 3: Microcontroller Architecture 
-- Module Name: Multiplexer - Behavioral 
-- Description: Selects the active data and anode output on the device
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
-------------------------------------

entity mux_4to1 is
    Port ( reset : in STD_LOGIC; 
           WDT_reset : in STD_LOGIC; 
           clk_1K : in std_logiC;                    
           
           A_left, A_right, B_left, B_right : in STD_LOGIC_VECTOR(7 downto 0); 
           PC100_seg, PC10_seg, PC1_seg : in STD_LOGIC_VECTOR(7 downto 0);  
           
           left_Anode, right_Anode : out STD_LOGIC_VECTOR(3 downto 0);            --output is Anode selection and Seg data 
           left_Segs, right_Segs  : out STD_LOGIC_VECTOR(7 downto 0)                     
           );
end mux_4to1;

---------------------------------------------------------

architecture Behavioral of mux_4to1 is
-----------------------------------------------------------
--signals 

signal Anode_temp : std_logic_vector(3 downto 0) := X"F"; 

------------------------------------------------------------

begin
    --sensitivity list 
Anode_Seg_Select : process(clk_1K, reset, WDT_reset) begin

    if(reset = '1' or WDT_reset = '1') then 
        anode_temp <= "1111";
        left_Segs <= X"FF"; 
        right_Segs <= X"FF"; 
        
    elsif(clk_1K'event and clk_1K = '1') then  
        
        
        case anode_temp is 
            --When all off, turn all segs off 
            when "1111" => anode_temp <= "0111"; 
                            left_Segs <= X"FF"; 
                            right_Segs <= X"FF";
      
            --100s place of PC on left segs
            --Left nibble of Reg A on right  
            when "0111" => anode_temp <= "1011"; 
                            left_Segs <= PC10_seg; 
                            right_Segs <= A_right;   
                           
            when "1011" => anode_temp <= "1101"; 
                            left_Segs <= PC1_seg; 
                            right_Segs <= B_left;
                            
                             
            when "1101" => anode_temp <= "1110"; 
                            left_Segs <= X"FF"; 
                            right_Segs <= B_right; 
                            
                           
            when "1110" => anode_temp <= "0111"; 
                            left_Segs <= PC100_seg; 
                            right_Segs <= A_left;        
                            
            when others =>  anode_temp <= "1111";
                            left_Segs <= X"FF"; 
                            right_Segs <= X"FF";   
            end case;      
    end if;

    end process; 
    
left_Anode <= anode_temp; 
right_Anode <= anode_temp; 
    
end Behavioral;

