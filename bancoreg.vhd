library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoreg is 
    port(
        in_sel_a,in_sel_b   :   in unsigned(2 downto 0);
        wr_data             :   in unsigned(15 downto 0);
        out_sel             :   in unsigned(2 downto 0);
        wr_en,clk,rst       :   in std_logic;
        rd_data_a,rd_data_b :   out unsigned(15 downto 0)
    );
end entity;

architecture a_bancoreg of bancoreg is 
    component registrador is
        port(
            clk     :   in  std_logic;
            rst     :   in  std_logic;
            wr_en   :   in  std_logic;
            data_in :   in  unsigned(15 downto 0);
            data_out:   out unsigned(15 downto 0)
        );
    end component;

    signal wr_en0,wr_en1,wr_en2,wr_en3,wr_en4,wr_en5,wr_en6,wr_en7  :   std_logic;
    signal data0,data1,data2,data3,data4,data5,data6,data7          :   unsigned(15 downto 0);
    signal zero                                                     :   unsigned(15 downto 0) := "0000000000000000";
begin

    registrador0: registrador port map(clk=>clk,rst=>rst,wr_en=>wr_en0,data_in=>zero   ,data_out=>data0);
    registrador1: registrador port map(clk=>clk,rst=>rst,wr_en=>wr_en1,data_in=>wr_data,data_out=>data1);
    registrador2: registrador port map(clk=>clk,rst=>rst,wr_en=>wr_en2,data_in=>wr_data,data_out=>data2);
    registrador3: registrador port map(clk=>clk,rst=>rst,wr_en=>wr_en3,data_in=>wr_data,data_out=>data3);
    registrador4: registrador port map(clk=>clk,rst=>rst,wr_en=>wr_en4,data_in=>wr_data,data_out=>data4);
    registrador5: registrador port map(clk=>clk,rst=>rst,wr_en=>wr_en5,data_in=>wr_data,data_out=>data5);
    registrador6: registrador port map(clk=>clk,rst=>rst,wr_en=>wr_en6,data_in=>wr_data,data_out=>data6);
    registrador7: registrador port map(clk=>clk,rst=>rst,wr_en=>wr_en7,data_in=>wr_data,data_out=>data7);


    wr_en0 <= '1';
    wr_en1 <= wr_en when out_sel = "001" else '0';
    wr_en2 <= wr_en when out_sel = "010" else '0';
    wr_en3 <= wr_en when out_sel = "011" else '0';
    wr_en4 <= wr_en when out_sel = "100" else '0';
    wr_en5 <= wr_en when out_sel = "101" else '0';
    wr_en6 <= wr_en when out_sel = "110" else '0';
    wr_en7 <= wr_en when out_sel = "111" else '0';


    rd_data_a <= data0 when in_sel_a="000" else 
                    data1 when in_sel_a="001" else 
                    data2 when in_sel_a="010" else 
                    data3 when in_sel_a="011" else 
                    data4 when in_sel_a="100" else 
                    data5 when in_sel_a="101" else
                    data6 when in_sel_a="110" else 
                    data7 when in_sel_a="111" else 
                    "0000000000000000";

    rd_data_b <= data0 when in_sel_b="000"  else
                    data1 when in_sel_b="001" else
                    data2 when in_sel_b="010" else
                    data3 when in_sel_b="011" else
                    data4 when in_sel_b="100" else
                    data5 when in_sel_b="101" else
                    data6 when in_sel_b="110" else
                    data7 when in_sel_b="111" else
                    "0000000000000000";


end architecture;