.INCLUDE <m328Pdef.inc>

 .DSEG
 .ORG SRAM_START
 char: .BYTE 1

 .CSEG
 start:
 ldi r16,0xFF ; carrega 0xFF em r16
 
 ldi XL,LOW(char) ; inicializa o ponteiro X
 ldi XH,HIGH(char) ; com o endere¸co de char

 st X,r16 ; armazena o valor de R16 no char
 rjmp start