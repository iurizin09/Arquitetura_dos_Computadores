   
.INCLUDE <m328Pdef.inc>

 .DSEG
 .ORG SRAM_START
 

 
 var1 : .BYTE 4 ; var de 32 bits
 var2 : .BYTE 4
 subt : .BYTE 4 
 
 ;três vetores com 10 posições de 8 bits (V0, V1 e VR).
 
 V0 : .BYTE 10
 V1 : .BYTE 10
 VR : .BYTE 10
 
 .CSEG
 main:
    
    
  ldi r26,low(var1); X
  ldi r27,high(var1) ;

     
  ldi r16,10
  ldi r17,20
  ldi r18,30
  ldi r19,40
  
  rcall init_32bits ; sub_rotina pra iniciar

 
  ldi r26,low(var1)
  ldi r27,high(var1)
  
  ldi r21 , 4 ; para para a sub_rotina o numero de bytes para zerar
  
 rcall zera_32bits ; sub_rotina zerar
    
 
 ;------------- Utilizacao Terceira sub_rotina---------------
 ;iniciei os ponteiros de X para var1 e var2 assim utilizando 
 ;apenas o ponteiro X como parametro pra utilizar a sub_rotina
 ;os iniciei utilizando a sub_rotina init_32bits
 
  ldi r26,low(var1); X
  ldi r27,high(var1) ; X
  
 rcall init_32bits ; iniciando com e armazenando em var1
  
  ldi r26,low(var2) ; V0 com 10 pos X
  ldi r27,high(var2)  ; V0 com 10 pos X
  
 rcall init_32bits  ; iniciando e armazenando em var2

 ;-----------Utilizacao Terceira sub_rotina----------
 ;apos armazenar os valores passados no reg para var1 e
 ;var 2 , irei utilizar  os ponteiros X e Y para passar
 ;como novos ponteiros para var1 e var2
 
  ldi r26,low(var1); X
  ldi r27,high(var1) ;
  ldi r28,low(var2); Y
  ldi r29,high(var2) ;
  ldi r30,low(subt); V1 com 10 pos
  ldi r31,high(subt) ; V1 com 10 pos Z
  
 rcall sub_32bits
 
 ;-------------Parte 2------------
 ;Inicialize o V0 com os valores de 10 até 19 
 ;V1 com valores de 20 até 29 utilizando as rotinas criadas.
 
 ldi r26 , low(V0)
 ldi r27 , high(V0)
 ldi r28 , low(V1)
 ldi r29 , high(V1)
 
 ;valores pra comecar
 
 ldi r16,10
 ldi r17,20
 
 ;valor tamanho do vetor
 
 ldi r21,10
 
 rcall init_vector
 
 ldi r26 , low(V0)
 ldi r27 , high(V0)
 ldi r28 , low(V1)
 ldi r29 , high(V1)
 ldi r30 , low(VR)
 ldi r31 , high(VR)
 
 rcall sum_vetor
 
 ldi r26 , low(V0)
 ldi r27 , high(V0)
 ldi r28 , low(V1)
 ldi r29 , high(V1)
 
 
 rcall zera_vetor
 

  rjmp main

;inicia a var de 32 bits com valores passados no main  
  
init_32bits: 
    st x+,r16
    st x+,r17
    st x+,r18
    st x+,r19    
ret

 ;zera a variavel de 32 bits 
 ;utilizei um loop que recebe uma variavel de um registrador
 ;que diz o tamanho de bytes que tem na variavel
zera_32bits:
   push r19 
   
   ldi r19,0
   loop_zera: 
   st x+,r19
   dec r21
   brne loop_zera
   
   pop r19
   
ret  
   
sub_32bits:
    
    push r16
    in r1,SREG
    push r1
    push r17
    push r18
    push r19
    push r20
    
    ldi r16,4
    clr r20
    clc
    
    loop_sub: ;loop para armazenar 
    ld r17,x+
    ld r18,y+
    sbc r18,r17
    st z+,r18
    dec r16
    brne loop_sub
    
    pop r20
    pop r19
    pop r18
    pop r17
    pop r1
    out SREG,r1
    pop r16 
 ret   
 
 
 init_vector:
    push r16
    push r17
    push r21
    
    loop_inc:
    st x+,r16
    st y+,r17
    inc r16
    inc r17
    
    dec r21
    brne loop_inc
    
    pop r21
    pop r17
    pop r16
    
    ret
    
    
 sum_vetor:
    
    push r21
    
    loop_soma:
    ldd r16,x+
    ldd r17,y+
    add r17,r16
    st z+,r17
    dec r21
    brne loop_soma
       
    pop r21
    
 ret
 
 zera_vetor:
    push r21
    
    ldi r16,0
    
    loop_zera:
    st x+,r16
    st y+,r16
    dec r21
    brne loop_zera
    
    
    pop r21
    
 ret   