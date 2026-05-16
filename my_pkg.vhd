library IEEE;
use IEEE.std_logic_1164.all;
package my_pkg is
component inverter is
port(
	in1 : in std_logic;
	out1 : out std_logic
);
end component;
component and_2 is
port(
	A : in std_logic_vector(1 downto 0);
	B : out std_logic
);
end component;
component and_3 is
port(
	A : in std_logic_vector(2 downto 0);
	B : out std_logic
);
end component;
component or_2 is
port(
	A : in std_logic_vector(1 downto 0);
	B : out std_logic
);
end component;
component or_3 is
port(
	A : in std_logic_vector(2 downto 0);
	B : out std_logic
);
end component;
end my_pkg;