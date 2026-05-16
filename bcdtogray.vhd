library IEEE;
use IEEE.std_logic_1164.all;
use work.my_pkg.all;

entity bcdtogray is
port(
    B : in std_logic_vector(3 downto 0);
    G : out std_logic_vector(3 downto 0)
);
end bcdtogray;

architecture bhv of bcdtogray is
    signal o : std_logic_vector(3 downto 0);
    signal s : std_logic_vector(3 downto 0);
begin

    U1: inverter 
    PORT MAP(
        in1  => B(0),
        out1 => o(0)
    );
    
    U2: inverter 
    PORT MAP(
        in1  => B(1),
        out1 => o(1)
    );
    
    U3: inverter 
    PORT MAP(
        in1  => B(2),
        out1 => o(2)
    );
    
    U4: inverter 
    PORT MAP(
        in1  => B(3),
        out1 => o(3)
    );

    G(3) <= B(3);

    U5: or_2
    PORT MAP(
        A(0) => B(3),
        A(1) => B(2),
        B    => G(2)
    );

	 U6: and_2
    PORT MAP(
        A(0) => B(2),
        A(1) => o(1),
        B    => s(0)
    );

    U7: and_2
    PORT MAP(
        A(0) => o(2),
        A(1) => B(1),
        B    => s(1)
    );

    U8: or_2
    PORT MAP(
        A(0) => s(0),
        A(1) => s(1),
        B    => G(1)
    );

    U9: and_2
    PORT MAP(
        A(0) => B(1),
        A(1) => o(0),
        B    => s(2)
    );

    U10: and_2
    PORT MAP(
        A(0) => o(1),
        A(1) => B(0),
        B    => s(3)
    );

    U11: or_2
    PORT MAP(
        A(0) => s(2),
        A(1) => s(3),
        B    => G(0)
    );

end bhv;