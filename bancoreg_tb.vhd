library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bancoreg_tb is
end entity bancoreg_tb;

architecture a_bancoreg_tb of bancoreg_tb is
    component bancoreg is
        port
        (
            clk         : IN  STD_LOGIC ;
            rst         : IN  STD_LOGIC ;
            wr_en       : IN  STD_LOGIC ;
            write_reg   : IN  unsigned (2 downto 0);
            read_reg_1  : IN  unsigned (2 downto 0);
            read_reg_2  : IN  unsigned (2 downto 0);
            write_data  : IN  unsigned (15 downto 0);
            read_data_1 : OUT unsigned (15 downto 0);
            read_data_2 : OUT unsigned (15 downto 0)
        );
    end component;
    
    constant period_time                          : time      := 100 ns;
    signal   finished                             : STD_LOGIC := '0';
    signal   clk, reset, wr_en                    : STD_LOGIC;
    signal   write_reg, read_reg_1, read_reg_2    : unsigned(2 downto 0);
    signal   write_data, read_data_1, read_data_2 : unsigned(15 downto 0);
begin

    uut: bancoreg port map(
        clk => clk,
        rst => reset,
        wr_en => wr_en,
        write_reg => write_reg,
        write_data => write_data,
        read_reg_1 => read_reg_1,
        read_reg_2 => read_reg_2,
        read_data_1 => read_data_1,
        read_data_2 => read_data_2
    );

    clk_proc: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;
    
    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process sim_time_proc;
    
    process
    begin
        reset <= '1';
        wait  for period_time*2;
        reset <= '0';
        
        wr_en <= '1';
        write_reg <= "001";
        write_data <= x"00FF";
        read_reg_1 <= "000";
        read_reg_2 <= "001";
        
        wait for period_time;
        write_reg <= "010";
        write_data <= x"FFFF";
        read_reg_1 <= "010";
        
        wait for period_time;
        write_reg <= "001";
        write_data <= x"FF00";

        wait for period_time;
        write_reg <= "100";
        write_data <= x"0004";
        read_reg_1 <= "100";

        wait for period_time;
        write_reg <= "101";
        write_data <= x"0005";
        read_reg_2 <= "101";

        wait for period_time;
        wr_en <= '0';
        write_reg <= "101";
        write_data <= x"5555";

        wait for period_time;
        reset <= '1';
        
        wait;
    end process;

end architecture a_bancoreg_tb;