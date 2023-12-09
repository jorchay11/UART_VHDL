library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 
library UNISIM;
use UNISIM.VComponents.all;
use std.textio.all; 
use ieee.std_logic_textio.all; 

----------------------------------------------------------------------------------
-- Company: Grand Valley State University
-- Engineer: Joshua Johnston and Jordan Hayes
-- Create Date: 02/05/2022 
-- Module Name: UART_Recieve - Behavioral
-- Project Name: Project 1: UART Serial Decoder 
-- Description: UART communication protocol, receives ASCII character from the 
--              terminal and outputs 2 4 bit data busses.
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


entity UART_Recieve_Data is
 Port (Clk_in : in STD_LOGIC := '0'; 
       RxD : in STD_LOGIC;
       left_SegData : out STD_LOGIC_VECTOR(3 downto 0);
       right_SegData : out STD_LOGIC_VECTOR(3 downto 0)
       
       --rx_Data : out STD_LOGIC_VECTOR(7 downto 0)
       );
end UART_Recieve_Data;

architecture Behavioral of UART_Recieve_Data is
--signal LED_Out_Temp : STD_LOGIC_VECTOR(4 downto 0);

--there are 10,416.66666666 100M clock cycles in 1/9600 cycle of time 
constant bit_time : integer := 10418;           --10418, 5 for sim

signal rdrf : std_logic := '0';                 --recieve done and ready to send
signal FE : std_logic := '0';                   --Fault, do not send 
signal bits_transferred : integer := 0;         --number of bits transferred so far
signal baud_count : integer := 0;               --counts how many scans or cycles the clock runs through before resetting

signal state : integer := 0;



--signal rx_data_temp : std_logic_vector(7 downto 0) := "00000000"; 
signal rx_data_temp : unsigned (7 downto 0) := "00000000"; 

-------------------------for when completed and moving onto splitting
--move to signal and uncomment left and right seg out
--signal rx_Data : STD_LOGIC_VECTOR(7 downto 0) := "00000000"; 
 

begin
    process(clk_in, RxD)
    --type rx_data_temp is Array (7 downto 0) of std_logic;-- = ('0', '0', '0', '0', '0', '0', '0', '0'); 
    --variable rx_data_temp : std_logic_vector (7 downto 0) := "00000000";
  
    begin 
        if((clk_in'event) and (clk_in = '1')) then 
-----------------------------------------------------------------------------------
            if(state = 0) then                                      --mark state
                bits_transferred <= 0; 
                rdrf <= '0'; --assert? 
                FE <= '0'; 
                baud_count <= 0; 
            
                if(RxD = '0') then 
                    state <= 1;                                     --dont forget when this gets set in software 
                end if;
         
 ---------------------------------------------------------------------------------
            elsif(state = 1) then                                   --Start (delay half bit_time) state
        
                --increment baud count for every clock cycle 
                baud_count <= baud_count + 1; 
            
                --wait for half bit time to change state
                if(baud_count >= (bit_time / 2)) then
                    state <= 2;
                    baud_count <= 0;                               --does not require this in packet, should I be using this here?  
                end if;
             
---------------------------------------------------------------------------------------        
            elsif(state = 2) then                                   --delay state
                --increment baud_count each clock cycle 
            
                baud_count <= baud_count + 1;
            
                --when a full bit time has passed, chasnge state 
                if(baud_count >= bit_time) then
                    baud_count <= 0;
                    
                    if(bits_transferred = 8) then
                        rdrf <= '1';                              --here?
                    else 
                        rdrf <= '0';  
                    end if;
                    
                    state <= 3; 
                end if; 
        
---------------------------------------------------------------------------------------
            elsif(state = 3) then                                   --shift state
            
                if(rdrf = '0') then                                 --asserting? 

                    rx_data_temp <= shift_right(rx_data_temp, 1); 
                    rx_data_temp(7) <= RxD;  
                 
                    bits_transferred <= bits_transferred + 1;
                    state <= 2; 
                else
                    --want this to be 0
                    FE <= not RxD; 
                    state <= 4; 
                end if;
            
---------------------------------------------------------------------------------------------
            elsif(state = 4) then                               --stop state, after delaying another baud_time 
               
                --we want FE to be 0
                FE <= not RxD;                                  --this would not get assigned for comparison yet??
            
                if(FE = '1') then 
                    state <= 0;
                else
                    --rx_data <= std_logic_vector(rx_data_temp); 
                    left_SegData <= std_logic_vector(rx_data_temp(7 downto 4));
                    right_SegData <= std_logic_vector(rx_data_temp(3 downto 0)); 
                    
                    state <= 0;
                end if;  
            end if;
        end if;
          
    end process;
end Behavioral;
