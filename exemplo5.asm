.EQU BOTAO = PD1  ; Botão no pino PD1 (INT1)
.EQU LED = PD3    ; LED no pino PD3
.DEF aux = r16    ; Registrador auxiliar

.ORG 0x0000       ; Reset vector
    RJMP setup

.ORG 0x0004       ; Vetor da interrupção INT1 (PD1)
    RJMP interrupcao_led

.ORG 0x0034       ; Primeira posição livre depois dos vetores

setup:
    ; Configura PD3 (LED) como saída
    SBI DDRD, LED   ; Define PD3 como saída
    SBI PORTD, LED  ; Liga o LED (fica sempre aceso) || OUT seria pra comecar com o led ligado

    ; Configura PD1 (BOTÃO) como entrada e ativa pull-up interno
    CBI DDRD, BOTAO   ; Define PD1 como entrada
    SBI PORTD, BOTAO  ; Ativa pull-up interno para evitar estados flutuantes

    ; Configuração da Interrupção INT1 na borda de subida
    LDI aux, 0b00001100  ; ISC11 = 1, ISC10 = 1 ? Interrupção na borda de subida
    STS EICRA, aux       ; Configura o modo da interrupção
    LDI aux, 0b00000010  ; Habilita interrupção INT1 (bit 1)
    OUT EIMSK, aux       ; Escreve no registrador EIMSK

    SEI                  ; Habilita interrupções globais

main:
    RJMP main            ; Loop infinito aguardando interrupção

;-----------------------------------------
;---- Interrupção (INT1) - Pisca LED 4 vezes e volta a ficar ligado
;-----------------------------------------
interrupcao_led:
    PUSH r19
    PUSH r16
    IN r16, SREG
    PUSH r16

    ; Pisca LED 4 vezes (1s aceso, 1s apagado)
    LDI r19, 4
piscar:
    CBI PORTD, LED  ; Apaga o LED
    LDI R19, 160
    RCALL delay

    SBI PORTD, LED  ; Liga o LED
    LDI R19, 160
    RCALL delay

    DEC r19
    BRNE piscar  ; Repete 4 vezes

    SBI PORTD, LED  ; Garante que o LED fica ligado no final

fim:
    POP r16
    OUT SREG, r16
    POP r16    
    POP r19
    RETI

;--------------------------------
; SUB-ROTINA DE ATRASO Programável
;--------------------------------
delay:
    PUSH r17
    PUSH r18
    IN r17, SREG
    PUSH r17

    LDI R17, 255   ; Ajustado para atraso maior
    LDI R18, 255

loop:
    DEC R17
    BRNE loop
    DEC R18
    BRNE loop
    DEC R19
    BRNE loop

    POP r17
    OUT SREG, r17
    POP r18
    POP r17
    RET
