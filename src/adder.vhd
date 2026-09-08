library ieee;
use ieee.std_logic_1164.all;

entity adder is
	port(x, y, carry_in: in std_logic;
		  output, carry_out: out std_logic);
end entity adder;

architecture behavioral of adder is
begin
	output <=  (x xor y) xor carry_in;
	carry_out <= (x and y) or (carry_in and (x xor y));
end architecture behavioral;