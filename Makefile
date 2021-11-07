run:
	ghdl -a ula.vhd
	ghdl -a reg16bits.vhd
	ghdl -a bancoreg.vhd
	ghdl -a processador.vhd
	ghdl -a rom.vhd

clean:
	rm -f work-obj93.cf