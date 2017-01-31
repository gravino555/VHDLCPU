library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std.all;

entity d_cache is
port(
	clk, reset: std_logic;
	data_write: std_logic;
	add: std_logic_vector(4 downto 0);
	d_in: in std_logic_vector(31 downto 0);
	d_out: out std_logic_vector(31 downto 0)
	);
end d_cache;

architecture behav of d_cache is
type data is array (0 to 31) of std_logic_vector(31 downto 0);
signal data_array: data;
begin
	process(clk, reset, add, data_array, data_write, d_in)
	begin	
		if(reset = '1') then
			for j in 0 to 31 loop
				data_array(j) <= (others => '0');
			end loop;
		elsif(clk'event and clk = '1' and data_write = '1') then
			data_array(to_integer(unsigned(add))) <= d_in;
		end if;
	end process;
d_out <= data_array(to_integer(unsigned(add)));
end behav;
	
