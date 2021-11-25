# VHDL-MICROPROCESSADOR

## Montador
Na pasta src/assembler tem um montador de códigos assembly.\
Para usar é preciso entregar um arquivo com o código assembly e passar para o montador.
``` sh
> python assembler.py input.txt
```

## Makefile
### Compilando
Para compilar basta usar o comando make para compilar todos os `.vhd` que não são `tb`.
``` sh
make
```
Para compilar e executar um `tb` é preciso executar o `make` seguido do `nome do componente`. Se tiver um arquivo de sinais salvos na pasta `generated_signals` com o mesmo nome do componente será aberto junto. Por exemplo:
``` sh
make processador
```