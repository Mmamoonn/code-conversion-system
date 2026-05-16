library IEEE;
use IEEE.std_logic_1164.all;
entity and_3 is
port(
	A : in std_logic_vector(2 downto 0);
	B : out std_logic
);
end and_3;
architecture bhv of and_3 is
begin

	B <= A(0) and A(1) and A(2);

end bhv;