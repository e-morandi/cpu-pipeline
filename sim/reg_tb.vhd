library ieee;
use ieee.std_logic_1164.all;

entity reg_tb is
end entity reg_tb;

architecture sim of reg_tb is 
	constant WIDTH: integer := 8;
	constant clk_period: time := 10 ns;
	
	signal clk_tb: std_logic := '0';
	signal reset_tb: std_logic := '0';
	signal data_in_tb: std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal data_out_tb: std_logic_vector(WIDTH - 1 downto 0);
begin

	-- DUT (register)
	dut: entity work.reg 
		generic map(register_width => WIDTH)
		port map(
			clk => clk_tb,
			reset => reset_tb,
			data_in => data_in_tb,
			data_out => data_out_tb
		);
		
	-- Clock generator
	clock_gen: process
	begin
		while now < 200 ns loop
			clk_tb <= '0';
			wait for clk_period / 2;
			clk_tb <= '1';
			wait for clk_period / 2;
		end loop;
		wait;
	end process clock_gen;
	
	stimulus: process
	begin
		reset_tb <= '1';
		data_in_tb <= (others => '0');
		wait for clk_period * 2;
		
		reset_tb <= '0';
		data_in_tb <= "11000101";
		wait for clk_period * 2;
		
		data_in_tb <= "00011110";
		wait for clk_period * 2;
		
		reset_tb <= '1';
		wait for clk_period * 2;
		
		reset_tb <= '0';
		data_in_tb <= "10101010";
		wait for clk_period * 2;
		
		wait;
	end process stimulus;
	
end architecture sim;