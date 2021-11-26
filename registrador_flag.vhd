library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registrador_flag is
    port(
        clk         :   in  std_logic;
        rst         :   in  std_logic;
        wr_en       :   in  std_logic;
        data_in     :   in  std_logic;
        data_out    :   out std_logic
    );
end entity registrador_flag;

architecture a_registrador_flag of registrador_flag is
    signal registro : std_logic;
begin
    process(clk,rst,wr_en)
    begin
        if rst='1' then
            registro <= '0';
        elsif wr_en='1' then
            if rising_edge(clk) then
                registro <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= registro;
end architecture a_registrador_flag;
