   
.INCLUDE <m328Pdef.inc>

 .DSEG
 .ORG SRAM_START
 
;Declare três vetores com
 ;10 posições de 8 bits (V0, V1 e VR).
 
 V0 : .BYTE 10 ; var de 32 bits
 V1 : .BYTE 10
 VR : .BYTE 10
 .CSEG

 
start:
    ldi XL,LOW(V0)
    ldi XH,HIGH(V0)
    ldi YL,LOW(V1)
    ldi YH,HIGH(V1)
    ldi ZL,LOW(VR)
    ldi ZH,HIGH(VR)
    
;Inicialize o V0 com os valores de 10 até 19 e o 
;V1 com valores de 20 até 29 utilizando as rotinas criadas.    
    
  ldi r16,10
  ldi r17,20
  ldi r18,10	    
  
  loop1:
    st X+,r16
    st Y+,r17
    inc r16
    inc r17
    dec r18
    brne loop1
    
    ldi r18,10
    
    ldi XL,LOW(V0)
    ldi XH,HIGH(V0)
    ldi YL,LOW(V1)
    ldi YH,HIGH(V1)
    
    ldi r18,10
    
    
  soma_loop:
    ld r16,X+
    ld r17,Y+
    add r16,r17
    st Z+,r16
    dec r18
    brne soma_loop
    
    ldi XL,LOW(V0)
    ldi XH,HIGH(V0)
    ldi YL,LOW(V1)
    ldi YH,HIGH(V1)
    
    
    ldi r17,10
    ldi r18,0
  
  zera_loop:
    st X+,r18
    st Y+,r18
    dec r17
    brne zera_loop
   
    rjmp start
 
