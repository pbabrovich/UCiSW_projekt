library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library myLib;
use     work.Utilities.all;
 
entity vga_driver is
generic (
		BOARD_CLK_FREQ : natural := 50000000 -- CLK frequency in Hz
		
	);
port(
		clk: in std_logic;
		hsync, vsync: out std_logic;
		rgb: out std_logic_vector(2 downto 0);
		btn: in std_logic_vector(1 downto 0);
		btn_2: in std_logic_vector(1 downto 0);
		rst: in std_logic;
		--------------
		SEG : out std_logic_vector(7 downto 0);
		DIG : out std_logic_vector(5 downto 0);
		--------------
		led1p: out std_logic_vector(1 downto 0);
		led2p: out std_logic_vector(1 downto 0);
		beep : out STD_LOGIC--------------------------------------------

);
end vga_driver;
 
  architecture main of vga_driver is
	component led_controller is port (
		score_p1 : in  integer range 0 to 4;
		score_p2 : in  integer range 0 to 4;
      clk : in  STD_LOGIC;
		rst: in std_logic;
      led1p : out  STD_LOGIC_VECTOR (1 downto 0);
		led2p : out  STD_LOGIC_VECTOR (1 downto 0)
	);
	end component led_controller;
	

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
	
	signal paddle_x_2: integer := HSP + HFP + HBP + HAV - (paddle_width / 2);
	signal paddle_y_2: integer := 300;
	
	signal paddleClkCounter : integer range 0 to 1000000 := 0;
	signal paddleClk : STD_LOGIC := '0';
	
	constant ball_size: integer := 16;
	signal ball_x: integer := HSP + HFP + HBP + HAV / 2;
	signal ball_y: integer := VSP + VFP + VBP + VAV / 2;
	--type ball_direction_h_type is (left, right);
	--type ball_direction_v_type is (up, down);
	
	signal ball_dir_h: ball_direction_h_type := left;
	signal ball_dir_v: ball_direction_v_type := up;
	
	signal ballClkCounter : integer range 0 to 1000000 := 0;
	signal ballClk : STD_LOGIC := '0';
	
	signal score_counter_p1: integer range 0 to 4 := 0;
	signal score_counter_p2: integer range 0 to 4 := 0;
	signal score_update: boolean := false;
	-------------
	signal end_game: boolean := false;
	-----------@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-----------------------
	
	signal SEG_data_sig : std_logic_vector(7 downto 0);
	signal DIG_sel_sig : std_logic_vector(5 downto 0);

	
	------------
	type digit_test_arr is array (0 to 31) of std_logic_vector(4 downto 0);
	type digit_test_type is array (0 to 5) of std_logic_vector(4 downto 0);
	constant digit_test_const: digit_test_arr := 
		("00000", "00001", "00010", "00011", "00100", "00101", "00110", "00111",   -- 0-7 
		 "01000", "01001", "01010", "01011", "01100", "01101", "01110", "01111",   -- 8-F
		 "10000", "10001", "10010", "10011", "10100", "10101", "10110", "10111",   -- (symbols with shift=1: separate bars)
		 "11000", "11001", "11010", "11011", "11100", "11101", "11110", "11111");  -- (symbols with shift=1: H L U...)
---------------------
	-- internal signals
	signal dot_sig : std_logic_vector(5 downto 0) := "010100";
	signal digit0_sig : std_logic_vector(4 downto 0) := (others => '0');
	signal digit1_sig : std_logic_vector(4 downto 0) := (others => '0');
	signal digit2_sig : std_logic_vector(4 downto 0) := (others => '0');
	signal digit3_sig : std_logic_vector(4 downto 0) := (others => '0');
	signal digit4_sig : std_logic_vector(4 downto 0) := (others => '0');
	signal digit5_sig : std_logic_vector(4 downto 0) := (others => '0');

	-- customization constants (generics for components)
	constant interval_1sec : natural := BOARD_CLK_FREQ; -- 1 sec :: 50 MHz (T=20 ns)
	constant interval_100ms : natural := BOARD_CLK_FREQ/10; -- 100 ms
	constant interval_2ms : natural := BOARD_CLK_FREQ/500; -- 2 ms
	constant interval_5ms : natural := BOARD_CLK_FREQ/200; -- 5 ms
	constant interval_1ms : natural := BOARD_CLK_FREQ/1000; -- 1 ms
	-----------@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-----------------------

begin

left_player_score: led_controller port map (score_counter_p1, score_counter_p2, ballClk, rst, led1p, led2p);




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


end_game_logic: process(clk, rst, end_game)
begin
  if (rising_edge(clk)) then
    if ((score_counter_p1 = 4) or (score_counter_p2 = 4))  then
	  end_game <= true;
	  beep <= '0';
    end if;
	 if ((rst = '0')) then
    end_game <= false;
	 beep <= '1';
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
					(vpos > paddle_y_2 - (paddle_height / 2) and vpos < paddle_y_2 + (paddle_height / 2))  and
					(hpos > paddle_x_2 - (paddle_width / 2) and hpos < paddle_x_2 + (paddle_width / 2))
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

move_paddle_2: process(paddleClk)
begin
	if (rising_edge(paddleClk)) then
		if (paddle_y_2 + (paddle_height / 2) < VAV + VSP + VBP + VFP and btn_2 = "01") then
			paddle_y_2 <= paddle_y_2  + 1;
		elsif (paddle_y_2 - (paddle_height / 2) > VSP + VBP + VFP and btn_2 = "10") then
			paddle_y_2  <= paddle_y_2  - 1;
		end if;
	end if;
end process;

--ai_paddle: process(paddleClk)
--begin
--	if (rising_edge(paddleClk)) then
--		if (ball_y + (paddle_height / 2) < VAV + VSP + VBP + VFP) and (ball_y - (paddle_height / 2) > VSP + VBP + VFP) then
--			paddle_y_2 <= ball_y;
--		end if;
--	end if;
--end process;

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


--move_ball: process(ballClk, end_game, rst, ball_x, ball_y)
--begin
--  if (rising_edge(ballClk) and (end_game = false)) then
--    if ((rst = '0') or (ball_x < paddle_x - paddle_width) or (ball_x > paddle_x_2 + paddle_width))  then
--      ball_x <= HSP + HFP + HBP + HAV / 2;
--      ball_y <= VSP + VFP + VBP + VAV / 2;
--		--score_counter <= 0;	
--		if (ball_x < paddle_x - paddle_width) then
--		score_counter_p1 <= score_counter_p1 + 1;
--		end if;
--		if (ball_x > paddle_x_2 + paddle_width) then
--		score_counter_p2 <= score_counter_p2 + 1;
--		end if;
--		if (((ball_x < paddle_x - paddle_width) and ((score_counter_p1 = 4) or (score_counter_p2 = 4))) or (rst = '0')) then
--		score_counter_p1 <= 0;
--		score_counter_p2 <= 0;
--		end if;	
--    else
--      case ball_dir_h is
--        when left =>
--          ball_x <= ball_x - 1;
--        when right =>
--          ball_x <= ball_x + 1;
--      end case;
--      
--      case ball_dir_v is
--        when up =>
--          ball_y <= ball_y - 1;
--        when down =>
--          ball_y <= ball_y + 1;
--      end case;
--    end if;
--  end if;
--end process;



ball_collision: process(ballClk, rst, ball_x, ball_y)
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
		elsif (ball_x + ball_size > HSP + HFP + HBP + HAV - paddle_width) then
			if (
				(ball_x > paddle_x_2 - (paddle_width / 2)) and
				(ball_y > paddle_y_2 - (paddle_height / 2)) and 
				(ball_y < paddle_y_2 + (paddle_height / 2))
				) then
				ball_dir_h <= left;
			end if;
		end if;
		
		if (ball_y - (ball_size / 2) < VSP + VBP + VFP) then
			ball_dir_v <= down;
		elsif (ball_y  + (ball_size / 2) > VSP + VBP + VFP + VAV) then
			ball_dir_v <= up;
		end if;
	end if;
end process;


	hexled_drv: entity work.hexled_driver(hexled_driver_arch)
		generic map (
			CNT_LIMIT => interval_1ms
		)
		port map (
			CLK => CLK,
			RST => not RST,
			DT0 => dot_sig(0),
			DT1 => dot_sig(1),
			DT2 => dot_sig(2),
			DT3 => dot_sig(3),
			DT4 => dot_sig(4),
			DT5 => dot_sig(5),
			DDI0 => digit0_sig,
			DDI1 => digit1_sig,
			DDI2 => digit2_sig,
			DDI3 => digit3_sig,
			DDI4 => digit4_sig,
			DDI5 => digit5_sig,
			SEG_DAT => SEG_data_sig,
			DIG_SEL => DIG_sel_sig
		);
		
	
	move_ball_t: entity work.move_ball_test(move_ball_arch)
	port map ( score_counter_p1 => score_counter_p1,
			  score_counter_p2 => score_counter_p2,
			  rst => rst,
           ballclk => ballclk,
			  ball_x => ball_x,
			  ball_y => ball_y,
			  paddle_x => paddle_x,
			  paddle_x_2 => paddle_x_2,
			  ball_dir_h  => ball_dir_h,
			  ball_dir_v  => ball_dir_v,
			  end_game => end_game
			  );
		

	SEG <= not SEG_data_sig;
	DIG <= not DIG_sel_sig;
	digit0_sig <= digit_test_const(score_counter_p2);
	digit1_sig <= "00000";
	digit2_sig <= "10011";
	digit3_sig <= "10011";
	digit4_sig <= digit_test_const(score_counter_p1);
	digit5_sig <= "00000";



	
	

end architecture main;