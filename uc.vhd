library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
    port(
        clk         :   in  std_logic;
        rst         :   in  std_logic;
        wr_en       :   in  std_logic;
        pc_o        :   in  unsigned(23 downto 0);
        pc_i        :   out unsigned(23 downto 0)
    );
end entity uc;

architecture a_uc of uc is
begin
    pc_i<=pc_o+1 when wr_en='1' else pc_o;

end architecture a_uc;