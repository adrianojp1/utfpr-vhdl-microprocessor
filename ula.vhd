library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula is
    port(
        in_x, in_y : in  unsigned(15 downto 0);
        sel_op     : in  unsigned(1  downto 0);
        saida      : out unsigned(15 downto 0)
    );
end entity ula;

architecture a_ula of ula is
begin

    saida <= in_x + in_y when sel_op = "00" else
             in_x - in_y when sel_op = "01" else
             "0000000000000001"     when sel_op = "10" and in_x > in_y else 
             "0000000000000001"     when sel_op = "11" and in_x(0) = '1' else 
             "0000000000000000";
    
end architecture a_ula;
