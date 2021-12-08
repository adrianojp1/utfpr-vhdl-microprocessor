library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end entity;

architecture a_ram_tb of ram_tb is
    component ram is
        port(
            clk         :   in std_logic;
            wr_en       :   in std_logic;
            endereco    :   in unsigned(7 downto 0);
            dado_in     :   in unsigned(15 downto 0);
            dado_out    :   out unsigned(15 downto 0)
        );
    end component ram;

    signal  clk         :   std_logic;
    signal  wr_en       :   std_logic;
    signal  endereco    :   unsigned(7 downto 0);
    signal  dado_in     :   unsigned(15 downto 0);
    signal  dado_out    :   unsigned(15 downto 0);

    signal  finished    :   std_logic   := '0';
    signal  period_time :   time        := 100 ns;

begin

    uut: ram port map(
        clk         =>  clk,
        wr_en       =>  wr_en,
        endereco    =>  endereco,
        dado_in     =>  dado_in,
        dado_out    =>  dado_out
    );

    clk_proc:   process
    begin
        while finished /= '1' loop
            clk<='0';
            wait for period_time/2;
            clk<='1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

    sim_time_proc: process
    begin
        wait for 10 us;
        finished<='1';
        wait;
    end process sim_time_proc;
    
    process
    begin
        wait for period_time*2;
        wr_en <= '1';
        endereco <= x"01";
        dado_in <= x"00F1";
        
        wait for period_time*2;
        endereco <= x"0F";
        dado_in <= x"00FF";
        
        wait for period_time*2;
        endereco <= x"32";
        dado_in <= x"03F2";

        wait for period_time*2;
        wr_en <= '0';
        endereco <= x"67";
        dado_in <= x"06F7";

        wait for period_time*4;
        wr_en <= '1';
        
        wait for period_time*2;
        endereco <= x"B3";
        dado_in <= x"0BF3";
        
        wait for period_time*2;
        endereco <= x"F5";
        dado_in <= x"0FF5";
        
        wait for period_time*2;
        wr_en <= '0';
        endereco <= x"FF";
        dado_in <= x"0FFF";
        
        wait for period_time*2;
        endereco <= x"32";
        
        wait for period_time*2;
        endereco <= x"B3";

        wait for period_time*2;
        endereco <= x"01";

        wait;
    end process;

end architecture;
