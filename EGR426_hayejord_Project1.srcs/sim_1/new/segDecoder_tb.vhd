----------------------------------------------------------------------------------
-- Company: Grand Valley State University
-- Engineer: Joshua Johnston and Jordan Hayes
-- Create Date: 02/05/2022 
-- Project Name: Project 1: UART Serial Decoder 
-- Module Name: Seg_decoder_tb
-- Description: Simulates Seg_Decoder 
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

entity segDecoder_tb is
--  Port ( );
end segDecoder_tb;

architecture Behavioral of segDecoder_tb is
------------------------------------------------------------------
--COMPONENT 
COMPONENT seg_Decoder is
    Port (
           integer_4bit : in STD_LOGIC_VECTOR (3 downto 0);
           dout_busToSeg : out STD_LOGIC_VECTOR (0 to 7)
          );
end COMPONENT;
----------------------------------------------------------------
--SIGNALS

--input
signal integer_4bit : std_logic_vector (3 downto 0) := X"0"; 

--output
signal dout_busToSeg : std_logic_vector (0 to 7);   -- (0 to 7); 

-------------------------------------------------------------------
 PROCEDURE MonitorOut(dout_ShouldBe : in std_logic_vector (0 to 7)) is 
 VARIABLE lout: line; 
 begin
WRITE(lout, NOW, right, 10, ns); 
WRITE(lout, string'("  4 bit nibble -->")); 
WRITE(lout, integer_4bit);

WRITE(lout, string'("  Data Out -->")); 
WRITE(lout, dout_busToSeg);
WRITELINE(OUTPUT, lout); 
ASSERT dout_busToSeg = dout_ShouldBe REPORT "Test Failed" SEVERITY FAILURE; 
end MonitorOut; 
          
------------------------------------------------
begin
Seg_Decoder1 : seg_Decoder PORT MAP(integer_4bit => integer_4bit, dout_busToSeg  => dout_busToSeg); 

stim_proc: process
begin 
    wait for 100 ns; 
    REPORT "Beginning the Seg Decoder test" SEVERITY NOTE; 
    
    REPORT "Test 1: nibble in is 0, Seg Data Out: expected 3" SEVERITY NOTE; 
    integer_4bit <= X"0"; 
    wait for 1 ns;
    MonitorOut("11000000"); 
   
     REPORT "Test 2: nibble in is 1, Seg Data Out: expected 159" SEVERITY NOTE; 
    integer_4bit <= X"1"; 
    wait for 1 ns;
    MonitorOut("11111001"); 
    
    REPORT "Test 3: nibble in is 2, Seg Data Out: expected 37" SEVERITY NOTE; 
    integer_4bit <= X"2"; 
    wait for 1 ns;
    MonitorOut("10100100");  
    
    REPORT "Test 4: nibble in is 3, Seg Data Out: expected 13" SEVERITY NOTE; 
    integer_4bit <= X"3"; 
    wait for 1 ns; 
    MonitorOut("10110000");
   
   REPORT "Test 5: nibble in is 4, Seg Data Out: expected 153" SEVERITY NOTE; 
    integer_4bit <= X"4"; 
    wait for 1 ns; 
    MonitorOut("10011001");
  
  REPORT "Test 6: nibble in is 5, Seg Data Out: expected 73" SEVERITY NOTE; 
    integer_4bit <= X"5"; 
    wait for 1 ns; 
    MonitorOut("10010010");

    REPORT "Test 7: nibble in is 6, Seg Data Out: expected 65" SEVERITY NOTE; 
    integer_4bit <= X"6"; 
    wait for 1 ns; 
    MonitorOut("10000010");
    
    REPORT "Test 8: nibble in is 7, Seg Data Out: expected 31" SEVERITY NOTE; 
    integer_4bit <= X"7"; 
    wait for 1 ns; 
    MonitorOut("11111000");
    
    REPORT "Test 9: nibble in is 8, Seg Data Out: expected 1" SEVERITY NOTE; 
    integer_4bit <= X"8"; 
    wait for 1 ns; 
    MonitorOut("10000000");
    
    REPORT "Test 10: nibble in is 9, Seg Data Out: expected 25" SEVERITY NOTE; 
    integer_4bit <= X"9"; 
    wait for 1 ns; 
    MonitorOut("10011000");
    
    REPORT "Test 11: nibble in is A = 10, Seg Data Out: expected 17" SEVERITY NOTE; 
    integer_4bit <= X"A"; 
    wait for 1 ns; 
    MonitorOut("10001000");
    
    REPORT "Test 12: nibble in is B = 11, Seg Data Out: expected 193" SEVERITY NOTE; 
    integer_4bit <= X"B"; 
    wait for 1 ns; 
    MonitorOut("10000011");
    
    REPORT "Test 13: nibble in is C = 12, Seg Data Out: expected 99" SEVERITY NOTE; 
    integer_4bit <= X"C"; 
    wait for 1 ns;
    MonitorOut("11000110"); 
    
    REPORT "Test 14: nibble in is D = 13, Seg Data Out: expected 133" SEVERITY NOTE; 
    integer_4bit <= X"D"; 
    wait for 1 ns; 
    MonitorOut("10100001");
    
    REPORT "Test 15: nibble in is E = 14, Seg Data Out: expected 97" SEVERITY NOTE; 
    integer_4bit <= X"E"; 
    wait for 1 ns;
    MonitorOut("10000110"); 
    
    REPORT "Test 16: nibble in is F = 15, Seg Data Out: expected 113" SEVERITY NOTE; 
    integer_4bit <= X"F"; 
    wait for 1 ns; 
    MonitorOut("10001110");
         
    -------------------------------------- Purposeful error
    REPORT "Test 17: Purposeful Error: nibble in is F, Seg Data Out: expected 255" SEVERITY NOTE; 
    integer_4bit <= X"F"; 
    wait for 1 ns; 
    MonitorOut("11111111");
         
end process; 
            
end Behavioral;

 
        
       
        
        
        
       
        
        
      
        
       
        
       