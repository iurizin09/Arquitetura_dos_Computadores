.INCLUDE <m328Pdef.inc>

 start:
 sbi DDRB, PB5 ;configura o pino PB5 como saida

 main:
 sbi PORTB, PB5 ;coloca o pino PB5 em 5V

 ;atraso de aprox. 200ms
 ldi R19, 16
 rcall delay

 cbi PORTB, PB5 ;coloca o pino PB5 em 0V

 ;atraso de aprox. 200ms
 ldi R19, 80
 rcall delay

 rjmp main
 
 ;SUB-ROTINA DE ATRASO Program´avel
 ; Ex.: - R19 = 16 --> 200ms
 ; - R19 = 80 --> 1s
 ;--------------------------------
 delay:
 push r17
 push r18
 in r17,SREG
 push r17

 clr r17
 clr r18
 loop:
 dec R17
 brne loop
 dec R18
 brne loop
 dec R19
 brne loop

 pop r17
 out SREG, r17
 pop r18
 pop r17

 ret