library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity alu is

port(
     x, y : in std_logic_vector(31 downto 0);
     add_sub : in std_logic ;  
     logic_func : in std_logic_vector(1 downto 0) ;
     func       : in std_logic_vector(1 downto 0) ;
     output     : out std_logic_vector(31 downto 0) ;
     overflow   : out std_logic ;
     zero       : out std_logic);
end alu ;

architecture arch_alu of alu is
signal output1: std_logic_vector(31 downto 0);
signal y1: signed(31 downto 0);
signal x1: signed(31 downto 0);
signal overflow_flag: std_logic;
signal zero1: std_logic;
begin
   y1 <= signed(y);
   x1 <= signed(x);

   process(func, x, y, logic_func, output1)
   begin
                case func is
                   when "00" =>
			output1 <= y;
		
                   when "01" =>
			if(y >= x) then
				output1 <= (others => '0');
			else
				output1 <= (others=> '0');
				output1(31) <= '1'; 
			end if;

                   when "10" =>
	    		if(add_sub = '0')then
			   output1 <= std_logic_vector(x1 + y1);
			   if(x1(31) = y1(31) and (output1(31) /= x1(31)))then
                	      overflow_flag <= '1';
                	   else
                    	      overflow_flag <= '0';
               		   end if;
				
            		else
			   output1 <= std_logic_vector(x1 - y1);
			   if(x1(31) /= y1(31) and (y1(31) = output1(31)))then
                	      overflow_flag <= '1';
               		   else
                    	      overflow_flag <= '0';
               		   end if;
			
			end if;

			if(output1 = "00000000000000000000000000000000") then
			   zero1 <= '1';
			else
			   zero1 <= '0';
			end if;
			
                   when others =>
			if(logic_func = "00")then
			   output1 <= x AND y;

			elsif(logic_func = "01")then
			   output1 <= x OR y;

			elsif(logic_func = "10")then
			   output1 <= x XOR y;

			else
			   output1 <= x NOR y;
			end if;
 		end case;
    end process;
    output <= output1;
    overflow <= overflow_flag when func = "10";
    zero <= zero1 when func = "10";
end arch_alu;

