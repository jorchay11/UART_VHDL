----------------------------------------------------------------------------------
-- Company: Grand Valley State University
-- Engineer: Joshua Johnston and Jordan Hayes
-- Create Date: 02/05/2022 
-- Design Name: UART_Tb
-- Module Name: UART_TestReport - Behavioral
-- Project Name: UART_Project1
-- Description: UART communication protocol, receives ASCII character from the 
--              terminal and outputs a 8 bit data bus.
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
use STD.Textio.all;
use IEEE.STD_LOGIC_TEXTIO.all;

entity UART_Tb is
end UART_Tb;

architecture Behavioral of UART_Tb is

component UART_TestReport
 Port (Clk_in : in STD_LOGIC; 
       Baud_Switch : in STD_LOGIC;
       RxD : in STD_LOGIC;
       State_Sim : out STD_LOGIC_VECTOR(3 downto 0);
       Bit_Count_Sim : out INTEGER; 
       Left_SegData : out STD_LOGIC_VECTOR(3 downto 0);
       Right_SegData : out STD_LOGIC_VECTOR(3 downto 0)
       );
end component;

signal Clk_in : STD_LOGIC := '0';
signal RxD : STD_LOGIC := '1'; 
Signal Right_SegData : STD_LOGIC_VECTOR(3 downto 0);
Signal Left_SegData : STD_LOGIC_VECTOR(3 downto 0);
Signal Baud_Switch : STD_LOGIC := '0';
Signal State_sim : STD_LOGIC_VECTOR(3 downto 0);
Signal Bit_Count_Sim : INTEGER;

PROCEDURE MonitorOut(dout_Shouldbe : in STD_LOGIC_VECTOR(3 downto 0)) is 
variable lout: line;
begin 
    WRITE(lout, NOW, right, 1, ns);
    WRITE(lout, string '("  State -->"));
    WRITE(lout, State_sim);
    WRITE(lout, string '("  Bit Count -->"));
    WRITE(lout, Bit_Count_Sim);
    WRITELINE(OUTPUT, lout);
    ASSERT State_sim = dout_Shouldbe REPORT "*******State Test Failed********" SEVERITY FAILURE;
end MonitorOut;

PROCEDURE MonitorOutBit(dout2_Shouldbe : in INTEGER) is 
variable lout: line;
begin 
    WRITE(lout, NOW, right, 1, ns);
    WRITE(lout, string '("  State -->"));
    WRITE(lout, State_sim);
    WRITE(lout, string '("  Bit Count -->"));
    WRITE(lout, Bit_Count_Sim);
    WRITELINE(OUTPUT, lout);
    ASSERT Bit_Count_Sim = dout2_Shouldbe REPORT "*******Bit Count Test Failed********" SEVERITY FAILURE;
end MonitorOutBit;

begin
U1 : UART_TestReport Port Map(Clk_in => Clk_in, RxD => RxD, Left_SegData => Left_SegData, Right_SegData => Right_SegData, baud_switch => baud_switch, State_sim => State_sim, Bit_Count_sim => Bit_Count_sim);
    Clk_Proc : Process
    begin
    REPORT "Beginning the STATE and Bit Count test" SEVERITY NOTE;
        wait for 100ns;
          
        loop
            wait for 1ns;
            Clk_in <= '1';
            wait for 1ns;
            Clk_in <= '0'; 
            
        end loop;
     end process;
     
     Data_Trans : Process
     begin
          wait for 100ns;
          RxD <= '1';             --Starting High
          REPORT "State Test 1: Expecting Bit Count = 0 and MARK State = 0000" SEVERITY NOTE; 
          MonitorOut("0000"); 
          wait for 20000ns;
          RxD <= '0'; 
          wait for 10400ns;          --Start Bit
          REPORT "State Test 2: Expecting Bit Count = 0 and START State = 0001" SEVERITY NOTE; 
          MonitorOut("0001");           
          wait for 10400ns;
          RxD <= '1';           --Bit 1
          wait for 20800ns;
          REPORT "Bit Count Test 1: Expecting Bit Count = 1 and DELAY State = 0100" SEVERITY NOTE;
          MonitorOutBit(1);
          RxD <= '0';           --Bit 2
          wait for 20800ns;
          RxD <= '1';           --Bit 3
          wait for 20800ns;
          RxD <= '0';           --Bit 4, 1010
          wait for 20800ns;
          RxD <= '1';           --Bit 5
          wait for 20800ns; 
          RxD <= '0';           --Bit 6
          wait for 20800ns;
          RxD <= '1';           --Bit 7
          wait for 20800ns;
          RxD <= '1';           --Bit 8 and Stop, 1011  
          wait for 20800ns;
          REPORT "Bit Count Test 2: Expecting Bit Count = 8 and DELAY State = 0010 DELAY" SEVERITY NOTE;
          MonitorOutBit(8);                 
          wait for 20800ns; 
          REPORT "State Test 3: Expecting Bit Count = 0 and MARK State = 0000" SEVERITY NOTE; 
          MonitorOut("0000"); 
          RxD <= '0';           --Start Bit
          wait for 10400ns;      
          REPORT "State Test 4: Expecting Bit Count = 0 and START State = 0001" SEVERITY NOTE; 
          MonitorOut("0001");           
          wait for 10400ns;
          RxD <= '0';           --Bit 1
          wait for 20800ns; 
          RxD <= '0';           --Bit 2
          wait for 20800ns;
          RxD <= '1';           --Bit 3
          wait for 20800ns;
          RxD <= '1';           --Bit 4, 0011
          wait for 20800ns;
          RxD <= '1';           --Bit 5
          wait for 20800ns; 
          RxD <= '0';           --Bit 6
          wait for 20800ns;
          RxD <= '1';           --Bit 7
          wait for 20800ns;
          RxD <= '0';           --Bit 8, 1010
          wait for 20800ns;     --Fail Test by changing MonitorOutBit(8) to MonitorBit(7) 
          REPORT "Bit Count Test 3: Expecting Bit Count = 8 and DELAY State = 0010" SEVERITY NOTE;
          MonitorOutBit(6);     --change to something not equal to 8 to fail             
          wait for 10400ns; 
          RxD <= '1';           --Stop Bit     
          wait for 20800ns;     
          REPORT "State Test 5: Expecting Bit Count = 1 and DELAY State = 0100" SEVERITY NOTE; 
          MonitorOut("0000");   
      wait;    
     end Process;
end Behavioral;
