library IEEE;
use IEEE.std_logic_1164.all;
entity or_3 is
port(
	A : in std_logic_vector(2 downto 0);
	B : out std_logic
);
end or_3;
architecture bhv of or_3 is
begin

	B <= A(0) or A(1) or A(2);

end bhv;