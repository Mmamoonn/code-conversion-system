library IEEE;
use IEEE.std_logic_1164.all;
use work.my_pkg.all;
entity bcdtoex3 is
port(
	B : in std_logic_vector(3 downto 0);
	X : out std_logic_vector(3 downto 0)
);
end bcdtoex3;
architecture bhv of bcdtoex3 is
signal o : std_logic_vector(3 downto 0);
signal s: std_logic_vector(6 downto 0);
begin
-- Defining Inverter for each input
	U1: inverter 
	PORT MAP(
		in1 => B(0),
		out1 => o(0)
	);
	U2: inverter 
	PORT MAP(
		in1 => B(1),
		out1 => o(1)
	);
	U3: inverter 
	PORT MAP(
		in1 => B(2),
		out1 => o(2)
	);
	U4: inverter 
	PORT MAP(
		in1 => B(3),
		out1 => o(3)
	);
	-- Output 1
	X(0) <= o(0);
	-- Output 2
	U5: and_2
	PORT MAP(
		A(0) => o(0),
		A(1) => o(1),
		B => s(0)
	);
	U6: and_2
	PORT MAP(
		A(0) => B(0),
		A(1) => B(1),
		B => s(1)
	);
	U7: or_2
	PORT MAP(
		A(0) => s(0),
		A(1) => s(1),
		B => X(1)
	);
	-- Output 3
	U8: and_2
	PORT MAP(
		A(0) => B(1),
		A(1) => o(2),
		B => s(2)
	);
	U9: and_2
	PORT MAP(
		A(0) => B(0),
		A(1) => o(2),
		B => s(3)
	);
	U10: and_3
	PORT MAP(
		A(0) => o(0),
		A(1) => o(1),
		A(2) => B(2),
		B => s(4)
	);
	U11: or_3
	PORT MAP(
		A(0) => s(2),
		A(1) => s(3),
		A(2) => s(4),
		B => X(2)
	);
	-- Output 4
	U12: and_2
	PORT MAP(
		A(0) => B(0),
		A(1) => B(2),
		B => s(5)
	);
	U13: and_2
	PORT MAP(
		A(0) => B(1),
		A(1) => B(2),
		B => s(6)
	);
	U14: or_3
	PORT MAP(
		A(0) => s(5),
		A(1) => s(6),
		A(2) => B(3),
		B => X(3)
	);
end bhv;