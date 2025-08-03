; Configuração: LED no PD0 e botão no PD2 (interruptor externo com pull-up interno)
.EQU BOTAO = PD2  ; Definição do pino do botão
.EQU LED = PD0    ; Definição do pino do LED
.DEF aux = r16    ; Registrador auxiliar

; Vetores de interrupção
.org 0x000
rjmp setup         ; Salta para a configuração

.org 0x002         ; Vetor da interrupção externa INT0
rjmp off_led       ; Rotina de interrupção para desligar LED

.org 0x0034        ; Endereço inicial do programa

setup:
   ldi aux, 0b00000001   ; Configura PD0 (LED) como saída
   out DDRD, aux         ; Escreve no DDRD
   cbi PORTD, LED        ; Garante que o LED começa desligado

   cbi DDRD, BOTAO       ; Configura PD2 como entrada
   sbi PORTD, BOTAO      ; Habilita pull-up interno para PD2

   ldi aux, 0b00000010   ; Configura interrupção na borda de descida (falling edge)
   sts EICRA, aux        ; Escreve no registrador de controle da interrupção externa
   sbi EIMSK, INT0       ; Habilita a interrupção INT0

main:
    sbi PORTD, LED       ; Liga LED
    ldi r19, 80          ; Define tempo de atraso
    rcall delay          ; Chama rotina de atraso

    cbi PORTD, LED       ; Desliga LED
    ldi r19, 80          ; Define tempo de atraso
    rcall delay          ; Chama rotina de atraso

    rjmp main            ; Loop infinito

;--------------------------------------
;-------- ROTINA DE INTERRUPÇÃO--------
;--------------------------------------
off_led:
   push r19
   push r16
   in r16, SREG
   push r16

   cbi PORTD, LED        ; Desliga LED imediatamente ao pressionar botão

   pop r16
   out SREG, r16
   pop r16
   pop r19
   reti                  ; Retorna da interrupção

;--------------------------------
; SUB-ROTINA DE ATRASO Programável
; Ex.: - R19 = 16 --> 200ms
;       - R19 = 80 --> 1s
;--------------------------------
delay:
 push r17
 push r18
 in r17, SREG
 push r17

 ldi R17, 255   ; Ajustado para atraso maior
 ldi R18, 255

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
