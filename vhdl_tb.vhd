--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:33:35 05/30/2021
-- Design Name:   
-- Module Name:   C:/Users/enkor/Downloads/UCiSW_projekt-led/vhdl_tb.vhd
-- Project Name:  Pong_VGA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: vga_driver
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY vhdl_tb IS
END vhdl_tb;
 
ARCHITECTURE behavior OF vhdl_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vga_driver
    PORT(
         clk : IN  std_logic;
         hsync : OUT  std_logic;
         vsync : OUT  std_logic;
         rgb : OUT  std_logic_vector(2 downto 0);
         btn : IN  std_logic_vector(1 downto 0);
         btn_2 : IN  std_logic_vector(1 downto 0);
         rst : IN  std_logic;
         SEG : OUT  std_logic_vector(7 downto 0);
         DIG : OUT  std_logic_vector(5 downto 0);
         led1p : OUT  std_logic_vector(1 downto 0);
         led2p : OUT  std_logic_vector(1 downto 0);
         beep : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal btn : std_logic_vector(1 downto 0) := (others => '0');
   signal btn_2 : std_logic_vector(1 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal hsync : std_logic;
   signal vsync : std_logic;
   signal rgb : std_logic_vector(2 downto 0);
   signal SEG : std_logic_vector(7 downto 0);
   signal DIG : std_logic_vector(5 downto 0);
   signal led1p : std_logic_vector(1 downto 0);
   signal led2p : std_logic_vector(1 downto 0);
   signal beep : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: vga_driver PORT MAP (
          clk => clk,
          hsync => hsync,
          vsync => vsync,
          rgb => rgb,
          btn => btn,
          btn_2 => btn_2,
          rst => rst,
          SEG => SEG,
          DIG => DIG,
          led1p => led1p,
          led2p => led2p,
          beep => beep
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      
      -- insert stimulus here 

      wait;
   end process;

END;
