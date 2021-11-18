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
        0   => x"0001",
        1   => x"F005",
        2   => x"0002",
        3   => x"0003",
        4   => x"F006",
        5   => x"F002",
        6   => x"F00A",
        7   => x"0008",
        8   => x"0009",
        9   => x"000A",
        10  => x"000B",
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