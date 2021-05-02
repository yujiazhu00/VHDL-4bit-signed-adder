LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


entity mod_full_adder is
port (A,B,C: in std_logic;
Sum,p,g: out std_logic);
end entity;

architecture mod_full_adder_arch of mod_full_adder is

constant tgate : time := 1 ns;

begin
Sum <= A xor B xor C after 2*tgate;
g <= A and B after 1*tgate;
p <= A or B after 1*tgate;

end architecture;
