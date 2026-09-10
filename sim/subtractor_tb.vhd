library ieee;
use ieee.std_logic_1164.all;

entity subtractor_tb is
end entity subtractor_tb;

architecture sim of subtractor_tb is
	-- signals for subtractor
	signal x_tb: std_logic := '0';
	signal y_tb: std_logic := '0';
	signal borrow_in_tb: std_logic := '0';
	signal borrow_out_tb: std_logic;
	signal output_tb: std_logic;
begin

	-- DUT (adder)
	dut: entity work.subtractor
	port map(
		x => x_tb,
		y => y_tb,
		borrow_in => borrow_in_tb,
		borrow_out => borrow_out_tb,
		output => output_tb
	);
	
		stimulus: process
	begin
		x_tb <= '0';
		y_tb <= '0';
		borrow_in_tb <= '0';
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
		borrow_in_tb <= '1';
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