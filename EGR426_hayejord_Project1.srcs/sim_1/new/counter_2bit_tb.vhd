----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
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



entity counter_2bit_tb is
--  Port ( );
end counter_2bit_tb;


architecture Behavioral of counter_2bit_tb is

------------------------------------------------------------------
--COMPONENT 
COMPONENT  counter_2bit 
   Port (
            trigger_count, reset : in std_logic;
            count : out std_logic_vector(1 downto 0) 
         );
end COMPONENT;
----------------------------------------------------------------
--SIGNALS

--input
signal trigger_count : std_logic := '0'; 
signal reset : std_logic := '0'; 

--output
signal count : std_logic_vector (1 downto 0); 

--
--signal count_temp : std_logic_vector(1 downto 0); 

-------------------------------------------------------------------
 PROCEDURE MonitorOut(count_ShouldBe : in std_logic_vector (1 downto 0)) is 
 VARIABLE lout: line; 
 begin
--WRITE(lout, NOW, right, 10, ns); 
WRITE(lout, string'("  Clk Trigger -->")); 
WRITE(lout, trigger_count);
WRITE(lout, string'("  reset -->")); 
WRITE(lout, reset);

WRITE(lout, string'("  Count -->")); 
WRITE(lout, count);
WRITELINE(OUTPUT, lout); 
ASSERT count = count_ShouldBe REPORT "Test Failed" SEVERITY FAILURE; 
end MonitorOut; 
          
------------------------------------------------
begin
counter1 : counter_2bit PORT MAP(trigger_count => trigger_count, reset => reset, count => count); 

stim_proc: process
begin 
    wait for 100 ns; 
    --100 ns
    REPORT "Beginning the 2 Bit Counter test" SEVERITY NOTE; 
    
    reset <= '1'; 
    wait for 1 ns;
    trigger_count <= '1'; 
    wait for 1 ns; 
    
    
    REPORT "Test 1: Reset set high, then trigger set high. Count should Reset and be initialized to zero" SEVERITY NOTE;
    MonitorOut("00"); 
    --110
    
    reset <= '0'; 
    wait for 1 ns; 
    trigger_count <= '0';
    --wait for 1 ns; 
    --MonitorOut("00"); 
    wait for 10 ns;             --without MonitorOut(), need 10 ns delay
    --123
    ---------------------------   go through iterations of counting 
    REPORT "Test 2: Trigger set high, count should be 1" SEVERITY NOTE; 
    trigger_Count <= '1'; 
    wait for 1 ns; 
    MonitorOut("01");           --is this how to do it? 
    --135 ns                            -- count = 1
    
    REPORT "Test 3: Trigger set LOW, count should still be 1" SEVERITY NOTE; 
    trigger_Count <= '0'; 
    wait for 1 ns; 
    MonitorOut("01");
    --140
    
    REPORT "Test 4: Trigger set High, count should be 2" SEVERITY NOTE; 
    trigger_Count <= '1';       -- count = 2
    wait for 1 ns; 
    MonitorOut("10");
    
    trigger_Count <= '0'; 
    wait for 10 ns;
    
    REPORT "Test 5: Trigger set High, count should be 3" SEVERITY NOTE; 
    trigger_Count <= '1';       -- count = 3
    wait for 1 ns; 
    MonitorOut("11");
    
    trigger_Count <= '0'; 
    wait for 10 ns; 
   
    REPORT "Test 6: Overflow. Trigger set High, count should be 0 again" SEVERITY NOTE; 
    trigger_Count <= '1';       -- count = 0
    wait for 1 ns; 
    MonitorOut("00");
    
    trigger_Count <= '0'; 
    wait for 10 ns; 
    ------------------------------------------------------------
    
    REPORT "Test 7: Trigger a count, then reset to 0, clk LOW" SEVERITY NOTE;
    trigger_Count <= '1'; 
    wait for 10 ns;
    trigger_count <= '0';
    wait for 1 ns;
    MonitorOut("01"); 
    
    reset <= '1'; 
    wait for 10 ns; 
    trigger_count <= '1'; 
    wait for 10 ns;
    trigger_Count <= '0'; 
    wait for 10 ns;
    reset <= '0';
    MonitorOut("00"); 
    ---------------------------add purposeful failure 
    REPORT "Test 8: Purposeful Fail, Expected 0 but Count is 1" SEVERITY NOTE;
    trigger_Count <= '1'; 
    wait for 1 ns;
    MonitorOut("00"); 
    
    
end process; 
            
end Behavioral;
