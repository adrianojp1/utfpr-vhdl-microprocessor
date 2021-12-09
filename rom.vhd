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
        0  => B"0010_111_0_00100001",
        1  => B"0010_110_0_00000001",
        2  => B"0010_001_0_00000001",
        3  => B"1010_001_001_000000",
        4  => B"0100_001_110_000000",
        5  => B"0110_111_001_000000",
        6  => B"1000_000_0_11111100",
        7  => B"0000_0000_00000000",
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