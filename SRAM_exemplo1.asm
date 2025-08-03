.INCLUDE <m328Pdef.inc>

 .DSEG ; Segmento da Memoria RAM (dados)
 .ORG SRAM_START ; 0x0100 para o ATmega328p

 var1: .BYTE 1 ; aloca 1 byte no rotulo var1.
 ; var1 e o rotulo do endereco (0x0100)
 ; do byte alocado.

 var2: .BYTE 2 ; aloca 2 bytes a partir do r´otulo var2.
 ; var2 ´e o r´otulo do endere¸co (0x0101)
 ; do PRIMEIRO byte alocado.
 ; O endere¸co do segundo byte e var2+1 (0x0103)

 var3: .BYTE 1 ; outra variavel

 .CSEG ; Segmento da Memoria de Flash (programa)
 start:
 ldi r19,15
 sts var1,r19 ; inicializa o endere¸co var1 com 15

 rjmp start
