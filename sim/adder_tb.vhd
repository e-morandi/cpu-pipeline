library ieee;
use ieee.std_logic_1164.all;

entity adder_tb is
end entity adder_tb;


architecture sim of adder_tb is
	-- signals for adder
	signal x_tb: std_logic := '0';
	signal y_tb: std_logic := '0';
	signal carry_in_tb: std_logic := '0';
	signal carry_out_tb: std_logic;
	signal output_tb: std_logic;

begin
	
	-- DUT (adder)
	dut: entity work.adder
	port map(
		x => x_tb,
		y => y_tb,
		carry_in => carry_in_tb,
		carry_out => carry_out_tb,
		output => output_tb
	);
	
	stimulus: process
	begin
		x_tb <= '0';
		y_tb <= '0';
		carry_in_tb <= '0';
		wait for 5 ns;
		
		x_tb <= '1';
		wait for 5 ns;
		
		x_tb <= '0';
		y_tb <= '1';
		wait for 5 ns;
		
		x_tb <= '1';
		wait for 5 ns;
		
		x_tb <= '0';
		y_tb <= '0';
		carry_in_tb <= '1';
		wait for 5 ns;
		
		x_tb <= '1';
		wait for 5 ns;
		
		x_tb <= '0';
		y_tb <= '1';
		wait for 5 ns;
		
		x_tb <= '1';
		wait for 5 ns;
		
		wait;
	end process stimulus;
end architecture sim;