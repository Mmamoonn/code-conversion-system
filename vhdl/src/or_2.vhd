library IEEE;
use IEEE.std_logic_1164.all;
entity or_2 is
port(
	A : in std_logic_vector(1 downto 0);
	B : out std_logic
);
end or_2;
architecture bhv of or_2 is
begin

	B <= A(0) or A(1);

end bhv;