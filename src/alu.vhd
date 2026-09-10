library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port(
		-- selection lines for operations
		sel: in std_logic_vector(2 downto 0);
		-- two 32 bit (register) inputs and one 32 bit output
		input_1, input_2: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
	);
end entity alu;

architecture behavioral of alu is

	signal d0: std_logic_vector(31 downto 0);
	signal d1: std_logic_vector(31 downto 0);
	signal d2: std_logic_vector(31 downto 0);
	signal d3: std_logic_vector(31 downto 0);
	signal d4: std_logic_vector(31 downto 0);
	signal d5: std_logic_vector(31 downto 0);
	signal d6: std_logic_vector(31 downto 0);
	signal d7: std_logic_vector(31 downto 0);
	
	signal carry: std_logic_vector(31 downto 0);
	signal borrow: std_logic_vector(31 downto 0);
	signal carry_out_last: std_logic;
	signal borrow_out_last: std_logic;
begin
	
	-- generate 32 bit adder
	gen_adder: for i in 0 to 31 generate
	begin
		adder_instance: if i = 0 generate
			-- Assignment for first adder (no carry in)
			first: entity work.adder
			port map(
				x => input_1(i),
				y => input_2(i),
				carry_in => '0',
				output => d4(i),
				carry_out => carry(i)
			);
		elsif i = 31 generate
			-- Assignment for last adder (carry out to status)
			last: entity work.adder
			port map(
				x => input_1(i),
				y => input_2(i),
				carry_in => carry(i - 1),
				output => d4(i),
				carry_out => carry_out_last
			);
		else generate
			-- Assignments for every other adder
			els: entity work.adder
			port map(
				x => input_1(i),
				y => input_2(i),
				carry_in => carry(i - 1),
				output => d4(i),
				carry_out => carry(i)
			);
		end generate;
	end generate gen_adder;
	
	-- generate 32 bit subtractor
	gen_sub: for i in 0 to 31 generate
	begin
		sub_instance: if i = 0 generate
			-- first subtractor instance (no borrow in)
			first: entity work.subtractor
			port map(
				x => input_1(i),
				y => input_2(i),
				borrow_in => '0',
				output => d5(i),
				borrow_out => borrow(i)
			);
			elsif i = 31 generate
			-- last subtractor instance (borrow out to status)
			last: entity work.subtractor
			port map(
				x => input_1(i),
				y => input_2(i),
				borrow_in => borrow(i - 1),
				output => d5(i),
				borrow_out => borrow_out_last
			);
			else generate
			-- rest of the subtractor instances
			els: entity work.subtractor
			port map(
				x => input_1(i),
				y => input_2(i),
				borrow_in => borrow(i - 1),
				output => d5(i),
				borrow_out => borrow(i)
			);
			end generate;
	end generate gen_sub;

	-- d0 -> and operation
	d0 <= input_1 and input_2;
	-- d1 -> or operation
	d1 <= input_1 or input_2;
	-- d2 -> xor operation
	d2 <= input_1 xor input_2;
	-- d3 -> ones' compliment (of input_1)
	d3 <= not input_1;
	-- d4 -> addition operation
	-- d5 -> subtraction operation
	-- d6 -> shift left
	shift_l: process(all)
	begin
		shift_loop: for i in 0 to 31 loop
			if i = 0 then
				d6(i) <= '0';
			else
				d6(i) <= input_1(i - 1);
			end if;
		end loop shift_loop;
	end process shift_l;
	-- d7 -> shift right
	shift_r: process(all)
	begin
		shift_loop: for i in 0 to 31 loop
			if i = 31 then
				d7(i) <= '0';
			else 
				d7(i) <= input_1(i + 1);
			end if;
		end loop shift_loop;
	end process shift_r;
	
	mux: process(all)
	begin
		case sel is 
			when "000" => output <= d0;
			when "001" => output <= d1;
			when "010" => output <= d2;
			when "011" => output <= d3;
			when "100" => output <= d4;
			when "101" => output <= d5;
			when "110" => output <= d6;
			when "111" => output <= d7;
			when others => output <= input_1;
		end case;
	end process mux;
	
end architecture behavioral;

