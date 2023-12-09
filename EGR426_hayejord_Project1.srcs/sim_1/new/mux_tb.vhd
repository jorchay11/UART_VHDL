----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2022 05:14:14 PM
-- Design Name: 
-- Module Name: mymux_beh_tb - Behavioral
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


entity mux_tb is

end mux_tb;

architecture Behavioral of mux_tb is
--------------------------------------------
COMPONENT mux_4to1
 Port ( current_LeftSegData : in STD_LOGIC_VECTOR(0 to 7);                    --input bits 
        current_RightSegData : in STD_LOGIC_VECTOR(0 to 7);                    
           
        s : in std_logic_vector(1 downto 0);                --selector 
           
        Anode_out : out STD_LOGIC_VECTOR(3 downto 0);        --output
        Segs_out  : out STD_LOGIC_VECTOR(0 to 7)                     
        );
           
end COMPONENT; 
 -------------------------------------------------
 --intputs 
 signal current_LeftSegData, current_RightSegData : std_logic_vector(0 to 7) := X"00";  
 signal s : std_logic_vector(1 downto 0) := "00"; 
 
 --outputs 
 signal Segs_Out : std_logic_vector(0 to 7);                       
 signal Anode_Out : std_logic_vector(3 downto 0);                      
-------------------------------------------------
 
 PROCEDURE Monitor_SegsOut(Segs_ShouldBe : in std_logic_vector (0 to 7)) is 
 VARIABLE lout: line; 
 begin
WRITE(lout, NOW, right, 10, ns); 
WRITE(lout, string'("  Tens Digit -->")); 
WRITE(lout, current_LeftSegData);
WRITE(lout, string'("  Ones Digit -->")); 
WRITE(lout, current_RightSegData);
WRITE(lout, string'("  S -->")); 
WRITE(lout, s); 

WRITE(lout, string'("  Seg Data -->")); 
WRITE(lout, Segs_Out);
WRITELINE(OUTPUT, lout); 
ASSERT Segs_Out = Segs_ShouldBe REPORT "Seg Test Failed" SEVERITY FAILURE; 
end Monitor_SegsOut; 
          
          
 PROCEDURE Monitor_AnodeOut(Anode_ShouldBe : in std_logic_vector(3 downto 0)) is 
 VARIABLE lout: line; 
 begin
WRITE(lout, NOW, right, 10, ns); 
  
WRITE(lout, string'("  S -->")); 
WRITE(lout, s); 

WRITE(lout, string'("  Anode -->")); 
WRITE(lout, Anode_Out);
WRITELINE(OUTPUT, lout);  
ASSERT Anode_Out = Anode_ShouldBe REPORT "Anode Test Failed" SEVERITY FAILURE; 
end Monitor_AnodeOut; 
------------------------------------------------
begin   --architectural begin
M1 : mux_4to1 PORT MAP(current_LeftSegData => current_LeftSegData, current_RightSegData => current_RightSegData, s => s, Segs_Out => Segs_Out, Anode_Out => Anode_Out); 

--stim_proc: counter 


--end process; 

stim_proc: process
begin   
wait for 10 ns; 
REPORT "Beginning the MUX test" SEVERITY NOTE; 

--current_LeftSegData <= "10000010"; 
--current_RightSegData <= "11111001";  

s <= "00";  
wait for 10 ns; 

REPORT "Anode Test 1: Input 's' begins at '00', Expected '1110', Right Segment Activated" SEVERITY NOTE; 
wait for 10 ns; 
Monitor_AnodeOut("1110");

REPORT "Segs Test 1: Right Segment input is decoded 0, Expected '1100 0000'" SEVERITY NOTE; 
current_LeftSegData <= "10110000"; 
current_RightSegData <= "11000000";  
wait for 10 ns; 
Monitor_SegsOut("11000000"); 


s <= "01"; 

REPORT "Anode Test 2: Input 's' is '01', Expected '1110', Right Segment Activated" SEVERITY NOTE; 
wait for 10 ns;
Monitor_AnodeOut("1110");

REPORT "Segs Test 2: A '1' key has been entered (31), Display 1 on Right Seg. Expected '11111001'" SEVERITY NOTE; 
current_LeftSegData <= "10110000"; current_RightSegData <= "11111001"; 
wait for 10 ns; 
Monitor_SegsOut("11111001"); 


s <= "10"; 

REPORT "Anode Test 3: Input 's' is '10', Expected '1101', Left Segment now Activated" SEVERITY NOTE; 
wait for 10 ns; 
Monitor_AnodeOut("1101");

REPORT "Segs Test 3: A 'b' key is pressed. Display 6 on the left seg, Expected '1000 0010'" SEVERITY NOTE; 
current_LeftSegData <= "10000010"; 
wait for 2 ns; 
current_RightSegData <= "10100100"; 
wait for 10 ns;
Monitor_SegsOut("10000010"); 

s <= "11"; 


REPORT "Anode Test 4: Input 's' at '11', Expected '1101', Left Segment Activated" SEVERITY NOTE; 
wait for 10 ns;
Monitor_AnodeOut("1101");

REPORT "Segs Test 4: Left Seg is ALL OFF, Rght Seg is C, Expected '1100 0110'" SEVERITY NOTE; 
current_LeftSegData <= "11000110"; current_RightSegData <= "11111111";
wait for 10 ns; 
Monitor_SegsOut("11000110");


--purposefule fail 

REPORT "Fail Test: Wrong segment data displayed" SEVERITY NOTE; 
current_LeftSegData <= "11000110"; current_RightSegData <= "11111111";
wait for 10 ns; 
Monitor_SegsOut("11111111");

wait; 
end process; 

end Behavioral;
