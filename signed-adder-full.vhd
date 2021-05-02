LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


entity full_adder is
port(A,B: in std_logic_vector(3 downto 0);
ADDn_SUB: in std_logic_vector(0 downto 0); -- 1 for subtract, 0 for add
Sum_Diff: out std_logic_vector(3 downto 0);
Cout_Bout: out std_logic_vector(0 downto 0);
Vout: out std_logic_vector(0 downto 0));
end entity;

architecture full_adder_arch of full_adder is

component mod_full_adder 
port (A,B,C: in std_logic;
Sum,p,g: out std_logic);
end component;

constant tgate : time := 1 ns;

signal C: std_logic_vector(4 downto 0);
signal g,p: std_logic_vector(3 downto 0); 
signal B_comp: std_logic_vector(3 downto 0);
signal Sum_Diff_sig: std_logic_vector(3 downto 0);

begin

C(0) <= ADDn_SUB(0);
adders:
for M in 0 to 3 GENERATE
	B_comp(M) <= B(M) xor ADDn_SUB(0) after 1*tgate;
	adder: mod_full_adder port map(A(M),B_comp(M),C(M),Sum_Diff_sig(M),p(M),g(M));
	C(M+1) <= g(M) or (p(M) and C(M)) after 2*tgate;
end GENERATE;


final: process(A,B_comp,C,Sum_Diff_sig)
begin
if (B_comp(3) = '0') and (A(3) = '0') and (Sum_Diff_sig(3) = '1') then
	Vout(0) <= '1';
elsif  (B_comp(3) = '1') and (A(3) = '1') and (Sum_Diff_sig(3) = '0') then
	Vout(0) <= '1';
else
	Vout(0) <= '0';
end if;

Cout_Bout(0) <= C(4);
Sum_Diff <= Sum_Diff_sig;

end process;
end architecture;
