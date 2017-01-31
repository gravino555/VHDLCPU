library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity next_address is
port(rt, rs: in std_logic_vector(31 downto 0); -- two register inputs
     pc: in std_logic_vector(31 downto 0);
     target_address: in std_logic_vector(25 downto 0);
     branch_type: in std_logic_vector(1 downto 0);
     pc_sel: in std_logic_vector(1 downto 0);
     next_pc: out std_logic_vector(31 downto 0));
end next_address;

architecture na_arch of next_address is
signal br_true: std_logic_vector(31 downto 0);
signal sign_extend : std_logic_vector(31 downto 0);
signal adder_in : std_logic_vector(31 downto 0);
signal adder_out : std_logic_vector(31 downto 0);
begin

	process(branch_type, br_true, rs, rt)
	begin
		case branch_type is
		when "00" => -- no branch
			br_true <= "00000000000000000000000000000000";
		when "01" =>
			if (rs = rt) then -- beq
				br_true <= "11111111111111111111111111111111";
			else
				br_true <="00000000000000000000000000000000";
			end if;
		when "10" =>
			if (rs /= rt) then -- bne
				br_true <= "11111111111111111111111111111111";
			else
				br_true <="00000000000000000000000000000000";
			end if;
		when others =>
			if (rs(31) = '1') then -- bltz
				br_true <= "11111111111111111111111111111111";
			else
				br_true <= "00000000000000000000000000000000";
			end if;
			
		end case;

	end process;

sign_extend <= "0000000000000000" & target_address(15 downto 0) when target_address(15) = '0' else
               "1111111111111111" & target_address(15 downto 0);

adder_in <= br_true and sign_extend;
adder_out <= std_logic_vector(unsigned(adder_in) + unsigned(pc) + 1);

next_pc <= adder_out when pc_sel = "00" else
           "000000" & target_address when pc_sel = "01" else
           rs when pc_sel = "10" else
           (others=>'-'); 


end na_arch;
