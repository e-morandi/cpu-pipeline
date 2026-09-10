library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity alu_tb;

architecture sim of alu_tb is
	signal sel_tb: std_logic_vector(2 downto 0) := "000";
	signal input_1_tb: std_logic_vector(31 downto 0) := (others => '0');
	signal input_2_tb: std_logic_vector(31 downto 0) := (others => '0');
	signal output_tb: std_logic_vector(31 downto 0); 
begin

	--DUT (ALU)
	dut: entity work.alu
	port map(
		sel => sel_tb,
		input_1 => input_1_tb,
		input_2 => input_2_tb,
		output => output_tb
	);
	
	stimulus: process
	begin
		-- and operation (000)
		sel_tb <= "000";
		input_1_tb <= "01110110100010100111100011011101";
		input_2_tb <= "00110000010100000110011111001110";
		wait for 1 ns;
		assert (output_tb = (input_1_tb and input_2_tb))
			report "Error: AND functionality failed"
			severity error;
		wait for 5 ns;
		
		-- or operation (001)
		sel_tb <= "001";
		input_1_tb <= "11110101001111110011100100110011";
		input_2_tb <= "01000100011100010011111010001111";
		wait for 1 ns;
		assert (output_tb = (input_1_tb or input_2_tb))
			report "Error OR functionailty failed"
			severity error;
		wait for 5 ns;
		
		-- xor operation (010)
		sel_tb <= "010";
		wait for 1 ns;
		assert (output_tb = (input_1_tb xor input_2_tb))
			report "Error XOR functionailty failed"
			severity error;
		wait for 5 ns;
		
		-- ones' complement (011)
		sel_tb <= "011";
		input_1_tb <= "11110110110110101101110011011101";
		wait for 1 ns;
		assert (output_tb = not input_1_tb)
			report "Error INVERSE functionailty failed"
			severity error;
		wait for 5 ns;
		
		-- addition (100)
		sel_tb <= "100";
		input_1_tb <= "00000000000000000000000001100100";
		input_2_tb <= "00000000000000000000000001100111";
		wait for 1 ns;
		assert (to_integer(unsigned(output_tb)) = (to_integer(unsigned(input_1_tb))) + to_integer(unsigned(input_2_tb)))
			report "Error ADD functionailty failed"
			severity error;
		wait for 5 ns;
		
		-- subtraction (101)
		sel_tb <= "101";
		input_1_tb <= "00000000000000000000000100001111";
		input_2_tb <= "00000000000000000000000010110110";
		wait for 1 ns;
		assert (to_integer(unsigned(output_tb)) = (to_integer(unsigned(input_1_tb))) - to_integer(unsigned(input_2_tb)))
			report "Error SUB functionailty failed"
			severity error;
		wait for 5 ns;
		
		-- shift left (110)
		sel_tb <= "110";
		input_1_tb <= "10110110101101100001001010000100";
		wait for 1 ns;
		assert (output_tb = std_logic_vector(shift_left((unsigned(input_1_tb)), 1)))
			report "Error SHL functionailty failed"
			severity error;
		wait for 5 ns;
		
		-- shift right (111)
		sel_tb <= "111";
		input_1_tb <= "11101110100000111100000011100110";
		wait for 1 ns;
		assert (output_tb = std_logic_vector(shift_right((unsigned(input_1_tb)), 1)))
			report "Error SHL functionailty failed"
			severity error;
		wait for 5 ns;
		
		wait;
	end process stimulus;

end architecture sim;