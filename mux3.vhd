library IEEE;
use IEEE.std_logic_1164.all;

entity mux3 is
    port ( 
	   reg_in_src: in  std_logic;
           a: in  std_logic_vector(31 downto 0);
           b: in  std_logic_vector(31 downto 0);
           output: out std_logic_vector(31 downto 0)
	);
end mux3;

architecture behav of mux3 is
	begin
    		output <= a when (reg_in_src = '0') else b;
end behav;
