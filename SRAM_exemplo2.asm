.INCLUDE <m328Pdef.inc>

 .DSEG
 .ORG SRAM_START
 uint: .BYTE 2

 .CSEG
 start:
 ldi r16,0xCD ; carrega 0xCD em r16
 ldi r17,0xAB ; carrega 0xAB em r17

 sts uint,r16 ; inicializa uint com
 sts uint+1,r17 ; o valor 0xABCD

 lds r0,uint ; carrega o valor de
 lds r1,uint+1 ; int em r1:r0

 rjmp start
