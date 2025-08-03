  .EQU BOTAO = 3
  .EQU LED1 = 7
  .DEF COUNT = r17

start:
  ;:SETUP   
botao_a:
    sbis GPIOR0,BOTAO ; SALTA SE O BOTAO ESTA PRESSIONADO
    rjmp botao_a               ; Loop infinito
   
    ldi r17,0
    pisca_led1:
    
    ; ACENDE LED
    
    SBI GPIOR0,LED1
    LDI R19 ,40
    CALL delay
    
    ;APAGA LED
    CBI GPIOR0,LED1
    LDI R19 ,40
    CALL delay
    
    inc count
    cpi count,5
    brne  pisca_led1
    rjmp botao_a
    
 ;--------------------------------------------------------------
 ;SUB-ROTINA DE ATRASO Program´avel
 ; Depende do valor de R19 carregado antes da chamada.
 ; Ex.: - R19 = 16 --> 200ms
 ; - R19 = 80 --> 1s
 ;--------------------------------------------------------------
delay:
 push r17 ; Salva os valores de r17,
 push r18 ; ... r18,
 in r17,SREG ; ...
 push r17 ; ... e SREG na pilha.

 ; Executa sub-rotina :
 clr r17
 clr r18
 loop:
 dec R17 ;decrementa R17, come¸ca com 0x00
 brne loop ;enquanto R17 > 0 fica decrementando R17
 dec R18 ;decrementa R18, come¸ca com 0x00
 brne loop ;enquanto R18 > 0 volta decrementar R18
 dec R19 ;decrementa R19
 brne loop ;enquanto R19 > 0 vai para volta

 pop r17
 out SREG, r17 ; Restaura os valores de SREG,
 pop r18 ; ... r18
 pop r17 ; ... r17 da pilha

 ret    