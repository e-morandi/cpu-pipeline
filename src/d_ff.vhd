library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
	port (D, clk, reset: in std_logic;
			Q: out std_logic);
end entity d_ff;

architecture behavioral of d_ff is
begin
	flip_flop: process(clk, reset) is
	begin 
		if reset = '1' then
			Q <= '0';
		elsif clk'event and clk='1' then
			Q <= D; 
		end if;
	end process flip_flop;
end architecture behavioral;