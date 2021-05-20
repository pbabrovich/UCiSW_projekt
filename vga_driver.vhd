library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity vga_driver is
port(
		clk: in std_logic;
		hsync, vsync: out std_logic;
		rgb: out std_logic_vector(2 downto 0);
		btn: in std_logic_vector(1 downto 0);
		rst: in std_logic
);
end vga_driver;
 
architecture main of vga_driver is
	constant HAV : integer := 800;
	constant HSP : integer := 56;
	constant HFP : integer := 120;
	constant HBP : integer := 64;
	
	constant VAV : integer := 600;
	constant VSP : integer := 37;
	constant VFP : integer := 6;
	constant VBP : integer := 23;

	signal hpos : integer range 0 to HAV + HSP + HFP + HBP := 0;	-- 1040
	signal vpos : integer range 0 to VAV + VSP + VFP + VBP := 0;	-- 666
	
	constant paddle_width : integer := 20;
	constant paddle_height : integer := 150;
	signal paddle_x : integer := HSP + HFP + HBP;
	signal paddle_y : integer := 300;
	
	signal paddleClkCounter : integer range 0 to 1000000 := 0;
	signal paddleClk : STD_LOGIC := '0';
	
	constant ball_size: integer := 16;
	signal ball_x: integer := HSP + HFP + HBP + HAV / 2;
	signal ball_y: integer := VSP + VFP + VBP + VAV / 2;
	type ball_direction_h_type is (left, right);
	type ball_direction_v_type is (up, down);
	
	signal ball_dir_h: ball_direction_h_type := left;
	signal ball_dir_v: ball_direction_v_type := up;
	
	signal ballClkCounter : integer range 0 to 1000000 := 0;
	signal ballClk : STD_LOGIC := '0';
begin
 
process(clk)
begin
	if (rising_edge(clk)) then
		if (hpos < HAV + HSP + HFP + HBP) then
			hpos <= hpos + 1;				-- in range of hpos, cycle through
		else
			hpos <= 0;						-- reset to the beginning of horizonal line
			
			if (vpos < VAV + VSP + VFP + VBP) then
				vpos <= vpos + 1;			-- in range of vpos, cycle through
			else
				vpos <= 0;					-- reset to the beginning of horizontal line
			end if;
		end if;
	end if;
end process;

h_sync: process(clk, hpos)
begin
	if (rising_edge(clk)) then
		if (hpos > HSP and hpos < HSP + HFP) then
			hsync <= '0';
		else
			hsync <= '1';
		end if;
	end if;
end process;

v_sync: process(clk, vpos)
begin
	if (rising_edge(clk)) then
		if (vpos > VSP and vpos < VSP + VFP) then 	-- check if in out of sync range
			vsync <= '0';
		else	
			vsync <= '1';
		end if;
	end if;
end process;

draw_paddle: process(clk, hpos, vpos)
begin
	if (rising_edge(clk)) then
		if (
					(vpos > paddle_y - (paddle_height / 2) and vpos < paddle_y + (paddle_height / 2))  and
					(hpos > paddle_x - (paddle_width / 2) and hpos < paddle_x + (paddle_width / 2))
		) then
			rgb <= "111";
		elsif (
					(vpos > ball_y - (ball_size / 2) and vpos < ball_y + (ball_size / 2))  and
					(hpos > ball_x - (ball_size / 2) and hpos < ball_x + (ball_size / 2))
		) then
			rgb <= "100";
		else
			rgb <= "000";
		end if;
	end if;
end process;

paddleClkScaler : process(clk)
begin
	if clk'event and clk = '1' then
		paddleClkCounter <= paddleClkCounter + 1;
			
		if (paddleClkCounter = 50000) then
			paddleClk <= not paddleClk;
			paddleClkCounter <= 0;
		end if;
	end if;
end process paddleClkScaler;

move_paddle: process(paddleClk)
begin
	if (rising_edge(paddleClk)) then
		if (paddle_y + (paddle_height / 2) < VAV + VSP + VBP + VFP and btn = "01") then
			paddle_y <= paddle_y + 1;
		elsif (paddle_y - (paddle_height / 2) > VSP + VBP + VFP and btn = "10") then
			paddle_y <= paddle_y - 1;
		end if;
	end if;
end process;

ballClkScaler : process(clk)
begin
	if (rising_edge(clk)) then
		ballClkCounter <= ballClkCounter + 1;
			
		if (ballClkCounter = 50000) then
			ballClk <= not ballClk;
			ballClkCounter <= 0;
		end if;
	end if;
end process ballClkScaler;

move_ball: process(ballClk)
begin
	if (rst = '0') then
		ball_x <= HSP + HFP + HBP + HAV / 2;
		ball_y <= VSP + VFP + VBP + VAV / 2;
	elsif (rising_edge(ballClk)) then
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
end process;

ball_collision: process(ballClk)
begin
	if (rst = '0') then
		ball_dir_h <= left;
		ball_dir_v <= up;
	elsif (rising_edge(ballClk)) then
		if (ball_x < HSP + HFP + HBP + paddle_width) then
			if (
				(ball_x > paddle_x - (paddle_width / 2)) and
				(ball_y > paddle_y - (paddle_height / 2)) and 
				(ball_y < paddle_y + (paddle_height / 2))
				) then
				ball_dir_h <= right;
			end if;
		elsif (ball_x + ball_size > HSP + HFP + HBP + HAV) then
			ball_dir_h <= left;
		end if;
		
		if (ball_y - (ball_size / 2) < VSP + VBP + VFP) then
			ball_dir_v <= down;
		elsif (ball_y  + (ball_size / 2) > VSP + VBP + VFP + VAV) then
			ball_dir_v <= up;
		end if;
	end if;
end process;

end architecture main;