library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is 
    port(
        clk     : in  std_logic;
        rst     : in  std_logic;
        wr_en   : in  STD_LOGIC;
        cte_in  : in  unsigned(15 downto 0);
        ula_out : out unsigned(15 downto 0)
    );
end entity;

architecture a_processador of processador is
    component bancoreg 
        port(
            clk                    : in  STD_LOGIC;
            rst                    : in  STD_LOGIC;
            wr_en                  : in  STD_LOGIC;
            sel_in                 : in  unsigned(2 downto 0);
            sel_out_1, sel_out_2   : in  unsigned(2 downto 0);
            bank_in                : in  unsigned(15 downto 0);
            bank_out_1, bank_out_2 : out unsigned(15 downto 0)
        );
    end component;

    component ula
        port(
            in_x, in_y : in  unsigned(15 downto 0);
            in_sel     : in  unsigned(1  downto 0);
            saida      : out unsigned(15 downto 0)
        );
    end component;

    signal  banco_wr_en     :   std_logic;
    signal  read_data_a     :   unsigned(15 downto 0);
    signal  read_data_b     :   unsigned(15 downto 0);
    signal  banco_sel_out_1 :   unsigned(2 downto 0);
    signal  banco_sel_out_2 :   unsigned(2 downto 0);
    signal  banco_sel_in    :   unsigned(2 downto 0);
    
    signal  cte             :   unsigned(15 downto 0);
    signal  ula_y           :   unsigned(15 downto 0);
    signal  ula_y_sel       :   std_logic;
    signal  ula_sel         :   unsigned(1 downto 0);
    signal  saida_ula       :   unsigned(15 downto 0);

begin 
    banco: bancoreg port map(
        clk         => clk,
        rst         => rst,
        wr_en       => banco_wr_en,
        sel_in      => banco_sel_in,
        sel_out_1   => banco_sel_out_1,
        sel_out_2   => banco_sel_out_2,
        bank_in     => saida_ula,
        bank_out_1  => read_data_a,
        bank_out_2  => read_data_b
    );
    
    ula0: ula port map(
        in_x    => read_data_a,
        in_y    => ula_y,
        in_sel  => ula_sel,
        saida   => saida_ula
    );

    ula_y <= read_data_b when ula_y_sel = '0' else
                cte when ula_y_sel = '1' else
                "0000000000000000";
end architecture;