library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula is
    port(
        in_x, in_y  : in  unsigned(15 downto 0);
        sel_op      : in  unsigned(1  downto 0);
        saida       : out unsigned(15 downto 0);
        carry       : out std_logic
    );
end entity ula;

architecture a_ula of ula is
    signal sum_17   : unsigned(16 downto 0);
begin

    sum_17  <=  ('0' & in_x) + ('0' & in_y);

    saida   <=  sum_17(15 downto 0) when sel_op = "00" else
                in_x - in_y         when sel_op = "01" else
                x"0000";

    carry   <=  sum_17(16)  when sel_op = "00" else
                '1'         when sel_op = "01" and in_x < in_y else
                '1'         when sel_op = "10" and in_x > in_y else
                '1'         when sel_op = "11" and in_x = in_y else
                '0';

end architecture a_ula;
