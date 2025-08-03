    ; Implementar um sistema com um bot�o (PD3) e dois LEDs, L0 (PB0) e L1 (PB1).
    ; O sistema deve piscar o L0 a cada 2s e, quando o bot�o for pressionado, o L1 deve acender.

    .EQU L0 = PB0
    .EQU L1 = PB1
    .EQU BOTAO = PD3  ; Bot�o est� no PD3 (INT1)
    .DEF AUX = r16

    .ORG 0x0000        ; Vetor de reset
        RJMP setup

    .ORG 0x0004        ; Vetor da interrup��o INT1 (PD3)
        RJMP isr_int1

    .ORG 0x0034        ; Primeira posi��o livre ap�s vetores

setup:
    LDI AUX, 0b00000011  ; Configura PB1 e PB0 como sa�da
    OUT DDRB, AUX        ; Configura PORTB
    OUT PORTB, AUX       ; Inicialmente, os LEDs est�o desligados

    CBI DDRD, BOTAO      ; Configura PD3 como entrada
    SBI PORTD, BOTAO     ; Habilita pull-up interno no PD3

    LDI AUX, 0b00001000  ; Configura INT1 sens�vel a borda de descida
    STS EICRA, AUX       ; Configura o modo da interrup��o
    SBI EIMSK, INT1      ; Habilita a interrup��o INT1

    SEI                  ; Habilita interrup��es globais

main:
    SBI PORTB, L0        ; Liga L0
    LDI R19, 80
    RCALL delay          ; Delay 1s
    CBI PORTB, L0        ; Desliga L0
    LDI R19, 80
    RCALL delay          ; Delay 1s
    RJMP main

;-------------------------------------------------
; Rotina de Interrup��o (ISR) do bot�o (PD3 - INT1)
;-------------------------------------------------
isr_int1:
    PUSH R16
    IN R16, SREG
    PUSH R16

    SBIC PIND, BOTAO     ; Verifica se o bot�o est� pressionado
    RJMP desliga         ; Se estiver solto, apaga o LED

    SBI PORTB, L1        ; Acende L1
    RJMP fim

desliga:
    CBI PORTB, L1        ; Apaga L1

fim:
    POP R16
    OUT SREG, R16
    POP R16
    RETI                 ; Retorna da interrup��o

;------------------------------------------------------------
; Sub-rotina de atraso program�vel
;------------------------------------------------------------
delay:
    PUSH R17
    PUSH R18
    IN R17, SREG
    PUSH R17

    CLR R17
    CLR R18

loop:
    DEC R17
    BRNE loop
    DEC R18
    BRNE loop
    DEC R19
    BRNE loop

    POP R17
    OUT SREG, R17
    POP R18
    POP R17

    RET
