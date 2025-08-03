; PARA LIGAR E DESLIGAR O BOTÃO É PRECISO LIGAR E DESLIGAR O PULL-UP (PORTD)
    
; DEFINIÇÕES
.equ ON = PD2       ; PD2 sempre INT0
.equ OFF = PD3      ; PD3 sempre INT1
.equ L0 = PB0       ; LED 0
.equ L1 = PB1       ; LED 1
.def AUX = R16      ; Registrador auxiliar
  
.ORG 0x0000         ; Reset vector
  RJMP setup

.ORG 0x0002         ; Vetor (endereço na Flash) da INT0 (ON)
  RJMP isr_on
  
.ORG 0x0004         ; Vetor (endereço na Flash) da INT1 (OFF)
  RJMP isr_off

.ORG 0x0034         ; Primeira end. livre depois dos vetores

setup:
  ldi AUX, 0x00000011    ; 0b00000011 - Configura PB0 e PB1 como saída
  out DDRB, AUX     
  out PORTB, AUX    ; Desliga os LEDs

  cbi DDRD, ON      ; Configura o PD2 como entrada
  sbi PORTD, ON     ; Habilita pull-up do PD2
  cbi DDRD, OFF     ; Configura o PD3 como entrada
  sbi PORTD, OFF    ; Habilita pull-up do PD3

  ldi AUX, 0b00001010    ; Configura INT0 e INT1 para borda de descida
  sts EICRA, AUX
  sbi EIMSK, INT0   ; Habilita INT0
  sbi EIMSK, INT1   ; Habilita INT1
                    
  sei               ; Habilita interrupção global

main:
  sbi PORTB, L0     ; Liga LED L0
  ldi r19, 80 
  rcall delay       ; Delay 1s
  cbi PORTB, L0     ; Desliga LED L0
  ldi r19, 80 
  rcall delay       ; Delay 1s

  rjmp main

;-------------------------------------------------
; Rotina de Interrupção (ISR) do botão ON
;-------------------------------------------------
isr_on:
  push R16
  in R16, SREG
  push R16

  sbi PORTB, L1   ; Liga LED L1

  ldi AUX, 10     ; Debounce
  rcall delay

  pop R16
  out SREG, R16
  pop R16
  reti

;-------------------------------------------------
; Rotina de Interrupção (ISR) do botão OFF
;-------------------------------------------------
isr_off:
  push R16
  in R16, SREG
  push R16

  cbi PORTB, L1   ; Desliga LED L1

  ldi AUX, 10     ; Debounce
  rcall delay

  pop R16
  out SREG, R16
  pop R16
  reti

;------------------------------------------------------------
; SUB-ROTINA DE ATRASO Programável
; Ex.: - R19 = 16 --> 200ms 
;      - R19 = 80 --> 1s 
;------------------------------------------------------------
delay:           
  push r17
  push r18
  in r17,SREG
  push r17

  clr r17
  clr r18
loop:            
  dec  R17       
  brne loop     
  dec  R18       
  brne loop      
  dec  R19       
  brne loop      

  pop r17
  out SREG, r17
  pop r18
  pop r17

  ret
