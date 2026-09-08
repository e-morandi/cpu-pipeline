library ieee;
use ieee.std_logic_1164.all;

entity reg is 
	-- generic mapping (deafult 32 bit register)
	generic(register_width: integer := 32);

	port(data_in: in std_logic_vector(register_width - 1 downto 0);
		  clk, reset: in std_logic;
		  data_out: out std_logic_vector(register_width - 1 downto 0));
end entity reg;

architecture behavioral of reg is
begin
	-- Generate register from D flip flops
	gen: for i in 0 to register_width - 1 generate
	begin
		instance: entity work.d_ff
			port map(
				clk => clk,
				reset => reset,
				D => data_in(i),
				Q => data_out(i)
			);
	end generate gen;
end architecture behavioral;