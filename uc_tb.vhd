library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity uc_tb is 
end entity uc_tb;

architecture a_uc_tb of uc_tb is
    component uc is
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            wr_en       :   in  std_logic;
            instr       :   in  unsigned(15 downto 0);
            pc_o        :   in  unsigned(7 downto 0);
            pc_i        :   out unsigned(7 downto 0);
            pc_wr_en    :   out STD_LOGIC;
            rom_wr_en   :   out STD_LOGIC
        );
    end component uc;

    signal period_time :   time      :=  100 ns;
    signal finished    :   std_logic := '0';
    
    signal clk         :   std_logic;
    signal rst         :   std_logic;
    signal wr_en       :   std_logic;

    signal instr       :   unsigned(15 downto 0);
    signal pc_o        :   unsigned(7 downto 0);
    signal pc_i        :   unsigned(7 downto 0);

    signal pc_wr_en    :   STD_LOGIC;
    signal rom_wr_en   :   STD_LOGIC;
begin

    uut: uc port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        instr => instr,
        pc_o => pc_o,
        pc_i => pc_i,
        pc_wr_en => pc_wr_en,
        rom_wr_en => rom_wr_en
    );

    clk_proc:   process
    begin
        while finished/='1' loop
            clk<='0';
            wait for period_time/2;
            clk<='1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

    sim_time_proc:  process
    begin
        wait for 10 us;
        finished<='1';
        wait;
    end process sim_time_proc;

    process
    begin
        rst<='1';
        wait for period_time*2;

        wait;
    end process;

end architecture a_uc_tb;