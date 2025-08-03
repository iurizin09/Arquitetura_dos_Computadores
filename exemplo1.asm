.INCLUDE <m328Pdef.inc>

 setup:
 sbi DDRB, PB5 ;configura o pino PB5 como sa?da

 loop:
 sbi PORTB, PB5 ;coloca o pino PB5 em 5V liga led
 cbi PORTB, PB5 ;coloca o pino PB5 em 0V desliga led

 rjmp loop