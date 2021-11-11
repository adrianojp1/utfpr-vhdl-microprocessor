library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port( 
        clk         : in std_logic;
        endereco    : in unsigned(23 downto 0);
        mem_data    : out unsigned(15 downto 0)
    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(15 downto 0); --TODO: Checar o tamanho da memória do processador escolhido
    constant conteudo_rom : mem := (
        0   => x"1111",
        1   => x"2222",
        2   => x"3333",
        3   => x"4444",
        4   => x"5555",
        5   => x"6666",
        6   => x"7777",
        7   => x"8888",
        8   => x"9999",
        9   => x"00AA",
        10  => x"BB00",
        others => (others=>'0')
    );

begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            mem_data <= conteudo_rom(to_integer(endereco));
        end if;
    end process;
end architecture;