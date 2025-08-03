   
.INCLUDE <m328Pdef.inc>

 .DSEG
 .ORG SRAM_START
 
 ;Declare três vetores com 12 posições de 8 bits (A1, A2 e A3) e um 
 ;vetor de 3 posições de 8 bits (A4).
 
 A1 : .BYTE 12 ; vetor de 12 pos
 A2 : .BYTE 12
 A3 : .BYTE 12 
 A4 : .BYTE 3 ; vetor de 3 pos 
 .CSEG

 start:
 ;Inicialize os vetores A2 e A3 com os valores de 1 até 12.
 
 ldi XL ,LOW(A2)
 ldi XH ,HIGH(A2)
 ldi YL ,LOW(A3)
 ldi YH ,HIGH(A3)
 
 ldi r16 , 1
 ldi r17 , 12
 
 loop1:
    st X+ , r16
    st Y+ , r16
    inc r16
    dec r17
    brne loop1
    
  ; Some a primeira posição do A2 com a última do 
  ;A3 e armazene na primeira do A1. Faça isso sucessivamente 
  ;até que todas as posições sejam operadas. 
  
 ldi XL ,LOW(A2)
 ldi XH ,HIGH(A2)
 ldi YL ,LOW(A3 + 12)
 ldi YH ,HIGH(A3 + 12)
 ldi ZL ,LOW(A1)
 ldi ZH ,HIGH(A1)
 
 ldi r17 , 12
 
 loop2:
   ld r16 , X+
   ld r18 , -Y
   add r16,r18
   st Z+ , r16
   dec r17
   brne loop2
   
  ; Some A2(2) e A3(5), A2(3) e A3(4), A2(8) e A3(9) e salve consecutivamente no A4.
   
 ldi XL ,LOW(A2)
 ldi XH ,HIGH(A2)
 ldi YL ,LOW(A3)
 ldi YH ,HIGH(A3)
 ldi ZL ,LOW(A4)
 ldi ZH ,HIGH(A4)
 
  
  
;ldd r16 , X + 1 ; nao esta funcionando o ldd 
 ;ldd r17 , Y + 4
 ;add r16,r17
 ;st Z+,r16
 
; Acessar A2(2) e A3(5)
adiw XL, 1       ; X = A2 + 1 (A2[2])
ld r16, X
adiw YL, 4       ; Y = A3 + 4 (A3[5])
ld r17, Y
add r16, r17
st Z+, r16

; Acessar A2(3) e A3(4)
adiw XL, 1       ; X = A2 + 2 (A2[3])
ld r16, X
sbiw YL, 1       ; Y = A3 + 3 (A3[4])
ld r17, Y
add r16, r17
st Z+, r16

; Acessar A2(8) e A3(9)
adiw XL, 5       ; X = A2 + 7 (A2[8])
ld r16, X
adiw YL, 5       ; Y = A3 + 8 (A3[9])
ld r17, Y
add r16, r17
st Z+, r16
 
 
    rjmp start