library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula is
    port(
        in_x, in_y : in  unsigned(15 downto 0);
        in_sel     : in  unsigned(1  downto 0);
        saida      : out unsigned(15 downto 0)
    );
end entity ula;

architecture a_ula of ula is
begin

    saida <= in_x + in_y when in_sel = "00" else
             in_x - in_y when in_sel = "01" else
             "0000000000000001"     when in_sel = "10" and in_x > in_y else 
             "0000000000000001"     when in_sel = "11" and in_x(0) = '1' else 
             "0000000000000000";
    
end architecture a_ula;
