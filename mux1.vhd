library IEEE;
use IEEE.std_logic_1164.all;

entity mux1 is
    port ( 
	   reg_dst: in  std_logic;
           a: in  std_logic_vector(31 downto 0);
           b: in  std_logic_vector(31 downto 0);
           output: out std_logic_vector(31 downto 0)
	);
end mux1;

architecture behav of mux1 is
	begin
    		output <= a when (reg_dst = '0') else b;
end behav;
