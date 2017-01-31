library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity control_unit is
port(
	op_con: in std_logic_vector(5 downto 0);
	func_con: in std_logic_vector(5 downto 0);
	output_con	: out std_logic_vector(13 downto 0)
);
	
end control_unit;

architecture behav of control_unit is
signal control_unit1 : std_logic_vector(13 downto 0);
begin
   control_unit1 <= 
	  "11100000100000" when func_con = "100000" 
	else
	  "11101000100000" when func_con = "100010" 
	else
	  "10100000010000" when func_con = "101010" 
	else
          "11101000110000" when func_con = "100100" 
	else
	  "11100001110000" when func_con = "100101" 
	else
	  "11100010110000" when func_con = "100110" 
	else
	  "11100011110000" when func_con = "100111" 
	else
	  "01111111000010" when func_con = "001000";

   output_con <= 
	     "10110000000000" when op_con = "001111" 
	else
   	     "10110000100000" when op_con = "001000" 
	else 
	     "10110000100000" when op_con = "001010" 
	else 
             "10110000110000" when op_con = "001100" 
	else
	     "10110001110000" when op_con = "001101" 
	else
	     "10110010110000" when op_con = "001110" 
	else
	     "10010010100000" when op_con = "100011" 
	else
	     "00010111100000" when op_con = "101011" 
	else 
	     "01111111000001" when op_con = "000010" 
	else
	     "01111111001100" when op_con = "000001" 
	else
	     "00000000000100" when op_con = "000100" 
	else
	     "00000000001000" when op_con = "000101" 
	else
	     control_unit1    when op_con = "000000";
end behav;

