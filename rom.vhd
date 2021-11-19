library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        clk         : in  std_logic;
        endereco    : in  unsigned(7 downto 0);
        mem_data    : out unsigned(15 downto 0)
    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(15 downto 0);
    constant conteudo_rom : mem := (
        0   => B"0010_011_0_00000101",
        1   => B"0010_100_0_00001000",
        2   => B"0011_101_011_000000",
        3   => B"0100_101_100_000000",
        4   => B"0010_001_0_00000001",
        5   => B"0101_101_001_000000",
        6   => B"0001_0000_00010100",
        7   => B"0000_0000_00011111",
        20  => B"0011_011_101_000000",
        21  => B"0001_0000_00000010",
        others => (others=>'0')
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            mem_data <= conteudo_rom(to_integer(endereco));
        end if;
    end process;
end architecture;