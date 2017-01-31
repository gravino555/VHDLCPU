library	ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_arith.all;			   
use ieee.std_logic_unsigned.all;

entity  datapath  is
port(
	reset : in std_logic;
	clk   : in std_logic;
     	rs_out, rt_out : out std_logic_vector(3 downto 0); -- output ports from reg.file
     	pc_out : out std_logic_vector(3 downto 0);
     	overflow, zero : out std_logic
); -- will not be constrained in Xilinx since not enough LEDs
end datapath;

architecture struct of datapath is

	component dff is
	port (
		clk, reset: in std_logic;
		d : in std_logic_vector(31 downto 0);
		q: out std_logic_vector(31 downto 0)
	);
	end component;

	component i_cache is
	port( 	
		in_add : in std_logic_vector(4 downto 0);
		output: out std_logic_vector(31 downto 0)
	);
	end component;

	component d_cache is
	port(
		clk, reset: std_logic;
		data_write: std_logic;
		add: std_logic_vector(4 downto 0);
		d_in: in std_logic_vector(31 downto 0);
		d_out: out std_logic_vector(31 downto 0)
	);
	end component;

	component mux1 is 
	port ( 
	   	reg_dst: in  std_logic;
           	a: in  std_logic_vector(31 downto 0);
           	b: in  std_logic_vector(31 downto 0);
           	output: out std_logic_vector(31 downto 0)
	);
	end component;

	component mux2 is 
	port ( 
	   	alu_src: in  std_logic;
           	a: in  std_logic_vector(31 downto 0);
           	b: in  std_logic_vector(31 downto 0);
           	output: out std_logic_vector(31 downto 0)
	);
	end component;

	component mux3 is 
	port ( 
	   	reg_in_src: in  std_logic;
           	a: in  std_logic_vector(31 downto 0);
           	b: in  std_logic_vector(31 downto 0);
           	output: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component sign_ex is
	port(
		func: std_logic_vector(1 downto 0);
		a: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component regfile is
	port ( 	
		din   : in std_logic_vector(31 downto 0);
      		reset : in std_logic;
      		clk   : in std_logic;
      		write : in std_logic;
      		read_a : in std_logic_vector(4 downto 0);
      		read_b : in std_logic_vector(4 downto 0);
      		write_address : in std_logic_vector(4 downto 0);
      		out_a  : out std_logic_vector(31 downto 0);
      		out_b  : out std_logic_vector(31 downto 0)
	);
	end component;

	component alu is
	port (	
     		x, y : in std_logic_vector(31 downto 0);
     		add_sub : in std_logic ;  
     		logic_func : in std_logic_vector(1 downto 0) ;
     		func       : in std_logic_vector(1 downto 0) ;
     		output     : out std_logic_vector(31 downto 0) ;
     		overflow   : out std_logic ;
     		zero       : out std_logic
	);
	end component;

	component next_address is
	port(	
     		rt, rs: in std_logic_vector(31 downto 0); -- two register inputs
     		pc: in std_logic_vector(31 downto 0);
     		target_address: in std_logic_vector(25 downto 0);
     		branch_type: in std_logic_vector(1 downto 0);
     		pc_sel: in std_logic_vector(1 downto 0);
     		next_pc: out std_logic_vector(31 downto 0)
	);		
	end component;

	signal na2rf, rf2alu1: std_logic_vector(31 downto 0); 
	signal rf2alu2, alu2na: std_logic_vector(31 downto 0);

begin		

 -- U1: smallmux port map(alu2memmux, mem_data, 
--			imm_data, RFs_dp, mux2rf);
  --U2: reg_file port map(clock_dp, rst_dp, RFwe_dp, 
--			RFr1e_dp, RFr2e_dp, 
	--		RFwa_dp, RFr1a_dp, RFr2a_dp, 
	--		mux2rf, rf2alu1, rf2alu2 );
  --U3: alu port map( rf2alu1, rf2alu2, jp_en, ALUs_dp, 
	--	    ALUz_dp, alu2memmux);
  --U4: obuf port map(oe_dp, mem_data, bufout_dp);
	
  --ALUout_dp <= alu2memmux;
  --RF1out_dp <= rf2alu1;
	
end struct;

