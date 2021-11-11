library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_controle is
    port(
        clk         :   in  std_logic;
        rst         :   in  std_logic;
        enable      :   in  std_logic;
        data_o      :   out unsigned(7 downto 0)
    );
end entity proto_controle;

architecture a_proto_controle of proto_controle is
    component pc is 
        port(
            clk     :   in  std_logic;
            rst     :   in  std_logic;
            wr_en   :   in  std_logic;
            data_i  :   in  unsigned(7 downto 0);
            data_o  :   out unsigned(7 downto 0)
        );
    end component pc;
    signal data_i   :   unsigned(7 downto 0);
    signal data_s   :   unsigned(7 downto 0);
begin
    pc0: pc port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  '1',
        data_i      =>  data_i,
        data_o      =>  data_s
    );

    pogram_counter_proc: process(clk)
    begin 
        if rising_edge(clk) and enable='1' then
            data_i<=data_s+1;
        end if;
    end process pogram_counter_proc;
    data_o<=data_s;
end architecture a_proto_controle;