----------------------------------------------------------------------------------
-- Grand Valley State Universitu
-- Engineer: Joshua Johnston and Jordan Hayes
-- 
-- Create Date: 02/05/2022 06:25:49 PM
-- Design Name: Top Level 
-- Module Name: Proj1_serialDecoder
-- Project Name: Serial Decoder 
-- Target Devices: Spartan 7 Boolean Board 
--
-- Description: The prograqmmed device will receive a character entered on a
-- separate keyboard connected to a CPU, in hex. The receiver will send each 
-- 4 bit hex integer (0-F) to a separate 7-seg decoder. The decoded values are displayed 
-- on the 7-segments of he Boolean Board by cycling through anode and corresponding
-- segemnt output using a counter and multiplexer. 

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


--------------------------------------------------------
entity Proj1_serialDecoder is
    Port (clk_100M          : in std_logic;                         --inputs 
          reset             : in std_logic; 
          RxD               : in std_logic; 
          baud_Switch       : in std_logic;
          
          anode_out        : out std_logic_vector (3 downto 0);     --outputs
          Segs_out           : out std_logic_vector(7 downto 0)
          );
end Proj1_serialDecoder;




architecture Behavioral of Proj1_serialDecoder is

----------------------------------------------------------------
--COMPONENTS 

--2 bit counter 
COMPONENT counter_2bit is 
      Port (
            trigger_count, reset : in std_logic;                --inputs 
            count : out std_logic_vector(1 downto 0)            --output
         );
end COMPONENT;



--4:1 MUX
COMPONENT mux_4to1 is
     Port ( current_LeftSegData : in STD_LOGIC_VECTOR(0 to 7); -- inputs                    --input bits 
           current_RightSegData : in STD_LOGIC_VECTOR(0 to 7);                    
           
           s : in std_logic_vector(1 downto 0);                --selector 
           
           Anode_out : out STD_LOGIC_VECTOR(3 downto 0);       --outputs
           Segs_out  : out STD_LOGIC_VECTOR(0 to 7)                     
           );
end COMPONENT;


--Seg Decoder 
COMPONENT Seg_Decoder is
    Port (
           integer_4bit         : in std_logic_vector(3 downto 0);          --intput
           dout_busToSeg        : out STD_LOGIC_VECTOR (7 downto 0)         --output        
          );
end COMPONENT; 


--1K Clock Divider 
COMPONENT Clk_1K is
Port (      clk_in      : in std_logic := '0';              --input             
            reset       : in STD_LOGIC := '0'; 
            clk_out     : out STD_LOGIC                     --output
            );
end COMPONENT;


--UART Receiver 
COMPONENT UART_Receive_Data is 
  PORT (Clk_in          : in STD_LOGIC; 
        RxD             : in STD_LOGIC;
        baud_Switch     : in STD_LOGIC;
        Left_SegData    : out STD_LOGIC_VECTOR(3 downto 0);
        Right_SegData   : out STD_LOGIC_VECTOR(3 downto 0)
       );
end COMPONENT;

------------------------------------------------------------------
--signals 
signal clk_1K_input     : std_logic; 
signal Seg_select       : std_logic_vector(1 downto 0); 

signal leftSeg_decoded_out      : std_logic_vector(7 downto 0); 
signal rightSeg_decoded_out      : std_logic_vector(7 downto 0); 

signal leftSeg_data_fromSerial : std_logic_vector(3 downto 0); 
signal rightSeg_data_fromSerial : std_logic_vector(3 downto 0); 



------------------------------------------------------------------

begin

serialDecoder_1K_clk : Clk_1K PORT MAP(clk_in => clk_100M, reset => reset, clk_out => clk_1K_input);

serialDecoder_UART_Receiver : UART_Receive_Data PORT MAP(clk_in => clk_100M, RxD => RxD, baud_Switch => baud_Switch, left_SegData => leftSeg_Data_fromSerial, right_SegData => rightSeg_Data_fromSerial);

serialDecoder_leftSeg : Seg_Decoder PORT MAP(integer_4bit => leftSeg_Data_fromSerial, dout_busToSeg => leftSeg_decoded_out);
serialDecoder_rightSeg : Seg_Decoder PORT MAP(integer_4bit => rightSeg_Data_fromSerial, dout_busToSeg => rightSeg_decoded_out);

serialDecoder_2bitCounter : counter_2bit PORT MAP(trigger_count => clk_1k_input, reset => reset, count => Seg_select); 
 
serialDecoder_mux : mux_4to1 PORT MAP(current_LeftSegData => leftSeg_decoded_out, current_RightSegData => rightSeg_decoded_out, s => Seg_select, anode_Out => anode_Out, segs_Out => segs_Out);
 
 
end Behavioral;
