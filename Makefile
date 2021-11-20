
WSLENV ?= notwsl
ifndef WSLENV
    gtkwave:=gtkwave.exe
else
	gtkwave:=gtkwave
endif

.PHONY: run clean test

SRCS := $(wildcard *[^_tb].vhd)

run:
	ghdl -a ${SRCS}
	
clean:
	rm -f work-obj93.cf
	rm -f ondas.ghw


%: %_tb.vhd clean run 
	ghdl -a $@_tb.vhd
	ghdl -r $@_tb --wave=ondas.ghw

	@if [ -f "$(wildcard generated_signals/$@_tb.gtkw)" ]; then\
		${gtkwave} ondas.ghw -a $(wildcard generated_signals/$@_tb.gtkw);\
	else\
		${gtkwave} ondas.ghw;\
	fi
