.EQU AJU = PB0    ; Botão AJU no pino PB0
.EQU SEL = PB1    ; Botão SEL no pino PB1

setup:
    ; Configura todos os pinos de PORTD como saída para LEDs
    ldi r16 , 0b1111_1111
    out DDRD, r16

    ; Configura os botões como entrada
    cbi DDRB, AJU
    cbi DDRB, SEL

    ; Habilita pull-up interno para os botões
    sbi PORTB, AJU
    sbi PORTB, SEL

main:
    ; Verifica se o botão AJU foi pressionado
    sbis PINB, AJU   ; Se AJU estiver em 1, pula
    rjmp AJU_PRESS
    
    ; Verifica se o botão AJU foi solto
    sbic PINB, AJU   ; Se AJU estiver em 0, pula
    rjmp AJU_INPRESS

AJU_PRESS:
    SBI PORTD , PD3
    SBI PORTD , PD2
    SBI PORTD , PD1
    SBI PORTD , PD0
    rjmp AJU_FIM

AJU_INPRESS:
    CBI PORTD , PD3
    CBI PORTD , PD2
    CBI PORTD , PD1
    CBI PORTD , PD0
    rjmp AJU_FIM

AJU_FIM:
    ; Verifica se o botão SEL foi pressionado
    sbis PINB, SEL  
    rjmp SEL_PRESS

    ; Verifica se o botão SEL foi solto
    sbic PINB, SEL  
    rjmp SEL_INPRESS

SEL_PRESS:
    SBI PORTD , PD7
    SBI PORTD , PD6
    SBI PORTD , PD5
    SBI PORTD , PD4    
    rjmp SEL_FIM

SEL_INPRESS:
    CBI PORTD , PD7
    CBI PORTD , PD6
    CBI PORTD , PD5
    CBI PORTD , PD4    
    rjmp SEL_FIM

SEL_FIM:
    rjmp main
