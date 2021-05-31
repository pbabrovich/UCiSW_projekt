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
library myLib;
use     work.Utilities.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity move_ball_test is
    Port ( score_counter_p1 :buffer integer;
			  score_counter_p2 :buffer integer;
			  rst: in STD_LOGIC;
           ballclk : in  STD_LOGIC;
			  ball_x : buffer integer;
			  ball_y : buffer integer;
			  paddle_x : in integer;
			  paddle_x_2 : in integer;
			  ball_dir_h  : in  ball_direction_h_type;
			  ball_dir_v  : in  ball_direction_v_type;
			  end_game : in boolean
			  );
end move_ball_test;




architecture move_ball_arch of move_ball_test is

constant HAV : integer := 800;
constant HSP : integer := 56;
constant HFP : integer := 120;
constant HBP : integer := 64;
	
constant VAV : integer := 600;
constant VSP : integer := 37;
constant VFP : integer := 6;
constant VBP : integer := 23;
constant paddle_width : integer := 20;
constant paddle_height : integer := 150;


begin

ball_moving: process(ballClk, end_game, rst, ball_x, ball_y)
begin
	
	
  if (rising_edge(ballClk) and (end_game = false)) then
    if ((rst = '0') or (ball_x < paddle_x - paddle_width) or (ball_x > paddle_x_2 + paddle_width))  then
      ball_x <= HSP + HFP + HBP + HAV / 2;
      ball_y <= VSP + VFP + VBP + VAV / 2;
		--score_counter <= 0;	
		if (ball_x < paddle_x - paddle_width) then
		score_counter_p1 <= score_counter_p1 + 1;
		end if;
		if (ball_x > paddle_x_2 + paddle_width) then
		score_counter_p2 <= score_counter_p2 + 1;
		end if;
		if (((ball_x < paddle_x - paddle_width) and ((score_counter_p1 = 4) or (score_counter_p2 = 4))) or (rst = '0')) then
		score_counter_p1 <= 0;
		score_counter_p2 <= 0;
		end if;	
    else
      case ball_dir_h is
        when left =>
          ball_x <= ball_x - 1;
        when right =>
          ball_x <= ball_x + 1;
      end case;
      
      case ball_dir_v is
        when up =>
          ball_y <= ball_y - 1;
        when down =>
          ball_y <= ball_y + 1;
      end case;
    end if;
  end if;
	
	
end process;

end move_ball_arch;
