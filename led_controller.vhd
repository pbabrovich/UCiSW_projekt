----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:07 05/28/2021 
-- Design Name: 
-- Module Name:    led_controller - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_controller is
    Port ( score_p1 : in  integer range 0 to 4;
			  score_p2 : in  integer range 0 to 4;
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           led1p : out  STD_LOGIC_VECTOR (1 downto 0);
			  led2p : out  STD_LOGIC_VECTOR (1 downto 0)			 
			  );
end led_controller;

architecture Behavioral of led_controller is

begin

led_out: process(clk, score_p1, score_p2)
begin
	if (rising_edge(clk)) then
		if (rst = '0') then
			led1p <= "00";
			led2p <= "00";
		end if;
		
		case score_p1 is
			when 0 => 
				led1p <= "00";				
			when 1 =>
				led1p <= "10";				
			when 2 => 
				led1p <= "01";		
			when 3 =>
				led1p <= "11";
			--when 4 =>		
			when others =>
				led1p <= "00";
								
		end case;
		case score_p2 is
			when 0 => 
				led2p <= "00";
			when 1 =>
				led2p <= "10";
			when 2 => 
				led2p <= "01";
			when 3 =>
				led2p <= "11";
			--when 4 =>		
			when others =>
				led2p <= "00";
				
			end case;
	end if;
end process;

end Behavioral;

