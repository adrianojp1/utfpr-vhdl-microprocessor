library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula_tb is
end entity ula_tb;

architecture a_ula_tb of ula_tb is
    component ula is
        port(
            in_x, in_y : IN  unsigned(15 downto 0);
            sel_op     : IN  unsigned(1  downto 0);
            saida      : OUT unsigned(15 downto 0)
        );
    end component;
    
    signal in_x, in_y, saida : unsigned(15 downto 0);
    signal sel_op            : unsigned(1  downto 0);
begin

    uut: ula port map(
        in_x=>in_x,
        in_y=>in_y,
        sel_op=>sel_op,
        saida=>saida
    );
    
    process
    begin
        ----------------------------------------
        -- Testes de soma
        sel_op <= "00";
        -- 3 + 8
        in_x <= "0000000000000011";
        in_y <= "0000000000001000";
        wait for 50 ns;
        
        -- 1024 + 20000
        in_x <= "0000010000000000";
        in_y <= "0100111000100000";
        wait for 50 ns;
        
        -- 5 + (-12)
        in_x <= "0000000000000101";
        in_y <= "1111111111110100";
        wait for 50 ns;
        
        -- 12 + (-5)
        in_x <= "0000000000001100";
        in_y <= "1111111111111011";
        wait for 50 ns;
        
        ----------------------------------------
        -- Testes de subtração
        sel_op <= "01";
        -- 8 - 3
        in_x <= "0000000000001000";
        in_y <= "0000000000000011";
        wait for 50 ns;
        
        -- 1024 - 20000
        in_x <= "0000010000000000";
        in_y <= "0100111000100000";
        wait for 50 ns;
        
        -- 5 - (-12)
        in_x <= "0000000000000101";
        in_y <= "1111111111110100";
        wait for 50 ns;
        
        -- 12 - (-5)
        in_x <= "0000000000001100";
        in_y <= "1111111111111011";
        wait for 50 ns;
        
        ----------------------------------------
        -- Testes de maior
        sel_op <= "10";
        -- 8 > 3
        in_x <= "0000000000001000";
        in_y <= "0000000000000011";
        wait for 50 ns;
        
        -- 3 > 8
        in_x <= "0000000000000011";
        in_y <= "0000000000001000";
        wait for 50 ns;
        
        -- 8 > 8
        in_x <= "0000000000001000";
        in_y <= "0000000000001000";
        wait for 50 ns;
        
        ----------------------------------------
        -- Testes de ímpar
        sel_op <= "11";
        -- 10
        in_x <= "0000000000001010";
        wait for 50 ns;
        
        -- 5
        in_x <= "0000000000000101";
        wait for 50 ns;
        
        wait;
    end process;

end architecture a_ula_tb;
