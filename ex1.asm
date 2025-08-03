start:
    ; Configuracao inicial: zera GPIOR0 para garantir estado inicial
    ldi r16, 0x00
    out GPIOR0, r16

loop:
    ; verifica se o bot�o (bit 0 do GPIOR0) está pressionado
     cbi GPIOR0, 2 ;  Desliga led2(bit2)
     cbi GPIOR0, 7 ; Desliga led1 (bit 1)
     sbic GPIOR0, 3 ; Se o bit 0 não estiver setado, pula a próxima instrução
    rcall muda_estado_led1led2

    rjmp loop               ; Loop infinito

; Alterna estados dos LEDs usando GPIOR0
muda_estado_led1led2:
   
    sbi GPIOR0, 7 ;  Liga led1 (bit 7)
    cbi GPIOR0, 2 ;  Desliga led2(bit2)
    rcall atraso1s
    
    sbi GPIOR0, 2 ; Liga led2 (bit 2)
    cbi GPIOR0, 7 ; Desliga led1 (bit 1)
    rcall atraso1s

    ret

; Atraso aproximado de 1 segundo
atraso1s:
    ldi r18, 50              ; Loop externo para gerar atraso
delay_loop:
    ldi r19, 200
inner_loop:
    dec r19
    brne inner_loop
    dec r18
    brne delay_loop
    ret
