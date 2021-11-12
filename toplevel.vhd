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
            wr_en       :   in  STD_LOGIC;
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
            clk      : IN  std_logic ;
            rst      : IN  std_logic ;
            wr_en    : IN  std_logic ;
            instr    : IN  unsigned (15 downto 0);
            pc_o     : IN  unsigned (23 downto 0);
            pc_i     : OUT unsigned (23 downto 0);
            pc_wr_en : OUT STD_LOGIC;
            rom_wr_en: OUT STD_LOGIC
        );
    end component;
    
    signal mem_data :   unsigned(15 downto 0);
    signal rom_wr_en:   STD_LOGIC;
    
    signal pc_i     :   unsigned(23 downto 0);
    signal pc_o     :   unsigned(23 downto 0);
    signal pc_wr_en :   STD_LOGIC;
begin
    rom0: rom port map(
        clk         =>  clk,
        wr_en       =>  rom_wr_en,
        endereco    =>  pc_o,
        mem_data    =>  mem_data
    );

    pc0: pc port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  pc_wr_en,
        endereco_i  =>  pc_i,
        endereco_o  =>  pc_o
    );

    uc0: uc port map(
        clk         =>  clk,
        rst         =>  rst,
        wr_en       =>  wr_en,
        pc_o        =>  pc_o,
        pc_i        =>  pc_i,
        instr       =>  mem_data,
        pc_wr_en    =>  pc_wr_en,
        rom_wr_en   =>  rom_wr_en
    );
end architecture a_toplevel;