.INCLUDE <m328Pdef.inc>

 setup:
 sbi DDRD, PD2 ;configura o pino PD2 como saida

 cbi DDRD, PD7 ;configura o pino PD7 como entrada
 sbi PORTD, PD7 ;habilita o pull-up para o botao

 ;----------------------
 ;LACO PRINCIPAL
 ;----------------------
 naoPress: ;loop botao nao pressionado (pull-up)
 sbi PORTD,PD2 ;
 sbic PIND,PD7 ;verifica se o botao foi pressionado,
 rjmp naoPress ;sen~ao volta e fica preso no la¸co naoPress

 press: ;loop botao pressionado
 cbi PORTD,PD2 ;liga LED
 sbis PIND,PD7 ;verifica se o botao foi solto, senao
 rjmp press ;senao, aguarda.

 rjmp naoPress ;vai para o loop do "botao pressionado"