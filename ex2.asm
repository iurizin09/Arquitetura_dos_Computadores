;somar Faça um programa que some duas variáveis de 8 bits:
   
.INCLUDE <m328Pdef.inc>

 .DSEG
 .ORG SRAM_START
 
 A : .BYTE 2
 B : .BYTE 2
 C : .BYTE 2
 
 .CSEG

 
 start:
    
    ldi XL , LOW(A)
    ldi XH , HIGH(A)
    ldi YL , LOW(B)
    ldi YH , HIGH(B)
    ldi ZL , LOW(C)
    ldi ZH , HIGH(C)
    
    
    ldi r16,0x10
    st X+,r16
    st Y+,r16
    st X+,r16
    st Y+,r16
    
    ldi XL , LOW(A)
    ldi XH , HIGH(A)
    ldi YL , LOW(B)
    ldi YH , HIGH(B)
    
    ld r16 , X+
    ld r17 , X+
    add r16,r17
    st Z+,r16
    
    ld r16 , Y+
    ld r17 , Y+
    add r16,r17
    st Z+,r16
        
    rjmp start
   
