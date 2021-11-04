library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regs8x16bits is
    port(
        clk                    : in  STD_LOGIC;
        rst                    : in  STD_LOGIC;
        wr_en                  : in  STD_LOGIC;
        sel_in                 : in  unsigned(3 downto 0);
        sel_out_1, sel_out_2   : in  unsigned(3 downto 0);
        bank_in                : in  unsigned(15 downto 0);
        bank_out_1, bank_out_2 : out unsigned(15 downto 0)
    );
end entity regs8x16bits;

architecture a_regs8x16bits of regs8x16bits is
    component reg16bits is
        port
        (
            clk      : IN STD_LOGIC ;
            rst      : IN STD_LOGIC ;
            wr_en    : IN STD_LOGIC ;
            data_in  : IN unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    signal data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7: unsigned(15 downto 0);
    signal wr_en_1, wr_en_2, wr_en_3, wr_en_4, wr_en_5, wr_en_6, wr_en_7: STD_LOGIC;
    signal out_1, out_2: unsigned(15 downto 0);
begin

    reg0: reg16bits port map(
        clk => clk, rst => rst, wr_en => '1',
        data_in => "0000000000000000", data_out => data_0
    );
    reg1: reg16bits port map(
        clk => clk, rst => rst, wr_en => wr_en_1,
        data_in => bank_in, data_out => data_1
    );
    reg2: reg16bits port map(
        clk => clk, rst => rst, wr_en => wr_en_2,
        data_in => bank_in, data_out => data_2
    );
    
    in_selection: process(sel_in, wr_en)
    begin
        wr_en_1 <= wr_en_2 <= wr_en_3 <= wr_en_4 <= wr_en_5 <= wr_en_6 <= wr_en_7 <= '0';
        if wr_en='1' then
            if sel_in="001" then
                wr_en_1 <= '1';
            elsif sel_in="010" then
                wr_en_2 <= '1';
            elsif sel_in="011" then
                wr_en_3 <= '1';
            elsif sel_in="100" then
                wr_en_4 <= '1';
            elsif sel_in="101" then
                wr_en_5 <= '1';
            elsif sel_in="110" then
                wr_en_6 <= '1';
            elsif sel_in="111" then
                wr_en_7 <= '1';
            end if;
        end if;
    end process in_selection;
    
    out_1_selection: process(sel_out_1)
    begin
        if sel_out_1="000" then
            out_1 <= data_0;
        elsif sel_out_1="001" then
            out_1 <= data_1;
        elsif sel_out_1="010" then
            out_1 <= data_2;
        elsif sel_out_1="011" then
            out_1 <= data_3;
        elsif sel_out_1="100" then
            out_1 <= data_4;
        elsif sel_out_1="101" then
            out_1 <= data_5;
        elsif sel_out_1="110" then
            out_1 <= data_6;
        elsif sel_out_1="111" then
            out_1 <= data_7;
        end if;
    end process out_1_selection;
    
    out_2_selection: process(sel_out_2)
    begin
        if sel_out_2="000" then
            out_2 <= data_0;
        elsif sel_out_2="001" then
            out_2 <= data_1;
        elsif sel_out_2="010" then
            out_2 <= data_2;
        elsif sel_out_2="011" then
            out_2 <= data_3;
        elsif sel_out_2="100" then
            out_2 <= data_4;
        elsif sel_out_2="101" then
            out_2 <= data_5;
        elsif sel_out_2="110" then
            out_2 <= data_6;
        elsif sel_out_2="111" then
            out_2 <= data_7;
        end if;
    end process out_2_selection;
    
    bank_out_1 <= out_1;
    bank_out_2 <= out_2;

end architecture a_regs8x16bits;