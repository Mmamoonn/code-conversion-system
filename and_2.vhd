library IEEE;
use IEEE.std_logic_1164.all;
entity and_2 is
port(
	A : in std_logic_vector(1 downto 0);
	B : out std_logic
);
end and_2;
architecture bhv of and_2 is
begin

	B <= A(0) and A(1);

end bhv;