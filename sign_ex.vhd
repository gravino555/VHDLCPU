library IEEE;
use IEEE.std_logic_1164.all;

entity sign_ex is
port(
	func: std_logic_vector(1 downto 0);
	a: in std_logic_vector(15 downto 0);
	output: out std_logic_vector(31 downto 0)
	);
end sign_ex;

architecture behav of sign_ex is
signal output1: std_logic_vector(31 downto 0);
begin
	process(func, output1, a)
	begin
		case func is
		when "00" =>
			output1 <= a & "0000000000000000";
		when "01" =>
			if(a(15) = '1') then
				output1 <= "1111111111111111" & a;
			elsif(a(15) = '0') then
				output1 <= "0000000000000000" & a;
			end if;
		when "10" =>
			if(a(15) = '1') then
				output1 <= "1111111111111111" & a;
			elsif(a(15) = '0') then
				output1 <= "0000000000000000" & a;
			end if;
		when others =>
			output1 <= "0000000000000000" & a;
		end case;
	end process;
output <= output1;
end behav;
