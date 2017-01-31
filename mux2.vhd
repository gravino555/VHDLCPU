library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
    port ( 
	   alu_src: in  std_logic;
           a: in  std_logic_vector(31 downto 0);
           b: in  std_logic_vector(31 downto 0);
           output: out std_logic_vector(31 downto 0)
	);
end mux2;

architecture behav of mux2 is
	begin
    		output <= a when (alu_src = '0') else b;
end behav;
