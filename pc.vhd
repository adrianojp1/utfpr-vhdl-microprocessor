library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
    port(
        clk         :   in  std_logic;
        rst         :   in  std_logic;
        wr_en       :   in  std_logic;
        endereco_i  :   in  unsigned(7 downto 0);
        endereco_o  :   out unsigned(7 downto 0)
    );
end entity;


architecture a_pc of pc is
    
begin
    process(clk,rst,wr_en)
    begin
        if rst='1' then
            endereco_o <= x"00";
        elsif wr_en='1' and rising_edge(clk) then
            endereco_o<=endereco_i;
        end if;
    end process;

end architecture a_pc;