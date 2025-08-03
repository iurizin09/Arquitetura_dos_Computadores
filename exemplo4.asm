; Configura��o: LED no PD0 e bot�o no PD2 (interruptor externo com pull-up interno)
.EQU BOTAO = PD2  ; Defini��o do pino do bot�o
.EQU LED = PD0    ; Defini��o do pino do LED
.DEF aux = r16    ; Registrador auxiliar

; Vetores de interrup��o
.org 0x000
rjmp setup         ; Salta para a configura��o

.org 0x002         ; Vetor da interrup��o externa INT0
rjmp off_led       ; Rotina de interrup��o para desligar LED

.org 0x0034        ; Endere�o inicial do programa

setup:
   ldi aux, 0b00000001   ; Configura PD0 (LED) como sa�da
   out DDRD, aux         ; Escreve no DDRD
   cbi PORTD, LED        ; Garante que o LED come�a desligado

   cbi DDRD, BOTAO       ; Configura PD2 como entrada
   sbi PORTD, BOTAO      ; Habilita pull-up interno para PD2

   ldi aux, 0b00000010   ; Configura interrup��o na borda de descida (falling edge)
   sts EICRA, aux        ; Escreve no registrador de controle da interrup��o externa
   sbi EIMSK, INT0       ; Habilita a interrup��o INT0

main:
    sbi PORTD, LED       ; Liga LED
    ldi r19, 80          ; Define tempo de atraso
    rcall delay          ; Chama rotina de atraso

    cbi PORTD, LED       ; Desliga LED
    ldi r19, 80          ; Define tempo de atraso
    rcall delay          ; Chama rotina de atraso

    rjmp main            ; Loop infinito

;--------------------------------------
;-------- ROTINA DE INTERRUP��O--------
;--------------------------------------
off_led:
   push r19
   push r16
   in r16, SREG
   push r16

   cbi PORTD, LED        ; Desliga LED imediatamente ao pressionar bot�o

   pop r16
   out SREG, r16
   pop r16
   pop r19
   reti                  ; Retorna da interrup��o

;--------------------------------
; SUB-ROTINA DE ATRASO Program�vel
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
