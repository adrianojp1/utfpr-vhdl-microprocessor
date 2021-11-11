library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
    port(
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        wr_en   :   in  std_logic
    );
end entity toplevel;

architecture a_toplevel of toplevel is
    component rom is 
        port( 
            clk         :   in  std_logic;
            endereco    :   in  unsigned(23 downto 0);
            mem_data    :   out unsigned(15 downto 0)
        );
    end component;
    
    component pc is 
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            wr_en       :   in  std_logic;
            endereco_i  :   in  unsigned(23 downto 0);
            endereco_o  :   out unsigned(23 downto 0)
        );
    end component pc;

    component uc is
        port(
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            wr_en       :   in  std_logic;
            pc_o        :   in  unsigned(23 downto 0);
            pc_i        :   out unsigned(23 downto 0)
        );
    end component uc;

    signal pc_i     :   unsigned(23 downto 0);
    signal pc_o     :   unsigned(23 downto 0);
    
    signal mem_data :   unsigned(15 downto 0);
begin
    rom0: rom port map(
        clk         =>  clk,
        endereco    =>  pc_o,
        mem_data    =>  mem_data
    );

    pc0: pc port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  wr_en,
        endereco_i  =>  pc_i,
        endereco_o  =>  pc_o
    );

    uc0: uc port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  wr_en,
        pc_o        =>  pc_o,
        pc_i        =>  pc_i
    );
end architecture a_toplevel;