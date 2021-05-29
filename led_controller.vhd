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
    Port ( score : in  integer range 0 to 3;
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           led : out  STD_LOGIC_VECTOR (3 downto 0));
end led_controller;

architecture Behavioral of led_controller is

begin

led_out: process(clk, score)
begin
	if (rising_edge(clk)) then
		if (rst = '0') then
			led <= "0000";
		end if;
		
		case score is
			when 0 => 
				led <= "0000";
			when 1 =>
				led <= "0001";
			when 2 => 
				led <= "0010";
			when 3 =>
				led <= "0011";
			when others =>
				led <= "0000";
		end case;
	end if;
end process;

end Behavioral;

