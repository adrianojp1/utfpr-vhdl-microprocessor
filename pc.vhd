library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
    port(
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        wr_en   :   in  std_logic;
        data_i  :   in  unsigned(7 downto 0);
        data_o  :   out unsigned(7 downto 0)
    );
end entity;


architecture a_pc of pc is
    
    signal data_s   :   unsigned(7 downto 0);
begin
    process(clk,rst,wr_en)
    begin
        if rst='1' then
            data_s<="00000000";
        elsif wr_en='1' and rising_edge(clk) then
            data_s<=data_i;
        end if;
    end process;

    data_o<=data_s;
end architecture a_pc;