library ieee;
use ieee.std_logic_1164.all;

entity subtractor is
	port(x, y, borrow_in: in std_logic;
		  output, borrow_out: out std_logic
	);
end entity subtractor;

architecture behavioral of subtractor is
begin
	output <= (x xor y) xor borrow_in;
	borrow_out <= (borrow_in and (not(x xor y))) or (not x and y);
end architecture behavioral;