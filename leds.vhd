--a simple program to turn on 4 leds in order over a time interval of 1 second. 

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:38:40 04/29/2017 
-- Design Name: 
-- Module Name:    leds - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity leds is
    Port ( led_out : out  STD_LOGIC_VECTOR (3 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC);
end leds;

architecture Behavioral of leds is
signal cnt: STD_LOGIC_VECTOR (25 DOWNTO 0);
signal leds: STD_LOGIC_VECTOR (3 downto 0);

begin

process(clk,rst)
	variable step:integer range 0 to 4;
	begin
		if(rst='0') then
			leds <= "0000";
			step:= 0;
			cnt <=(others=>'0');
		elsif (clk'event and clk='1') then  -- could also be "if rising_edge(clk) then"
			if (cnt = "11111110010100000011001100") then --195 MHz, count from 0 to this cost around 1 seconds
				case step is  
					when 0=>leds<=(others=>'0');         -- countrol the order of the led that should be on
					when 1=>leds<=(0=>'1', others=>'0');
					when 2=>leds<=(1=>'1', others=>'0');
					when 3=>leds<=(2=>'1', others=>'0');
					when 4=>leds<=(3=>'1', others=>'0');
				end case;
				step := step + 1;
				if (step >= 4) then
					step := 0;
				end if;
				cnt<=(others=>'0');
		   else
				cnt<= cnt+1; --Must include in the code in order to use "+" to do the addition:
							 --use IEEE.STD_LOGIC_ARITH.ALL; 
				             --use IEEE.STD_LOGIC_UNSIGNED.ALL;
			end if;
	  end if;
end process;

led_out <= leds;

end Behavioral;

