LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity full_adder_tb is
end entity;

architecture full_adder_tb_arch of full_adder_tb is

component full_adder
port(A,B: in std_logic_vector(3 downto 0);
ADDn_SUB: in std_logic_vector(0 downto 0); -- 1 for subtract, 0 for add
Sum_Diff: out std_logic_vector(3 downto 0);
Cout_Bout: out std_logic_vector(0 downto 0);
Vout: out std_logic_vector(0 downto 0));
end component;

signal A_TB, B_TB, Sum_Diff_TB: std_logic_vector(3 downto 0);
signal ADDn_SUB_TB: std_logic_vector(0 downto 0);
signal Cout_Bout_TB: std_logic_vector(0 downto 0);
signal Vout_TB: std_logic_vector(0 downto 0);



begin

DUT1:  full_adder port map(A => A_TB,
B => B_TB,
ADDn_SUB => ADDn_SUB_TB,
Sum_Diff => Sum_Diff_TB,
Cout_Bout => Cout_Bout_TB,
Vout => Vout_TB); 

STIM: process
variable t : signed(4 downto 0);

begin

for I in -8 to 7 loop
	for K in -8 to 7 loop
		for M in 0 to 1 loop
			A_TB <= std_logic_vector(to_signed(I, 4));
			B_TB <= std_logic_vector(to_signed(K, 4));
			ADDn_SUB_TB <= std_logic_vector(to_unsigned(M,1));
			wait for 30 ns;
			if (ADDn_SUB_TB(0) = '0') then
				t := to_signed(I, 5) + to_signed(K, 5);
			elsif (ADDn_SUB_TB(0) = '1') then
				t := to_signed(I, 5) - to_signed(K, 5);
			end if;
			if (Vout_TB(0) = '0') then
				if (t(3 downto 0) = signed(Sum_Diff_TB)) then
					assert false report "add successful" severity NOTE;
				else 
					assert false report "error" severity FAILURE;
				end if;
			elsif (Vout_TB(0) = '1') then
				assert false report "overflow" severity NOTE;
			else
				assert false report "error" severity FAILURE;
			end if;
		end loop;
	end loop;
end loop;
end process;
end architecture;
