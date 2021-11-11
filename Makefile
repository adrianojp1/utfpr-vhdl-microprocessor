SHELL:=/bin/bash
run:
	ghdl -a ula.vhd
	ghdl -a reg16bits.vhd
	ghdl -a bancoreg.vhd
	ghdl -a rom.vhd
	ghdl -a maq_estados.vhd
	ghdl -a pc.vhd
	ghdl -a processador.vhd

gtkwave:
	ghdl -a $(tb)
	ghdl -r $${tb/.*/} --wave=ondas.ghw
	gtkwave.exe ondas.ghw
clean:
	rm -f work-obj93.cf
	rm -f ondas.ghw

test:
	echo $${a/.*/}
