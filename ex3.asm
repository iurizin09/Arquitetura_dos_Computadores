   
.INCLUDE <m328Pdef.inc>

 .DSEG
 .ORG SRAM_START
 

 
 VAR1 : .BYTE 4 ; var de 32 bits
 VAR2 : .BYTE 4
 soma : .BYTE 4
 .CSEG

start:
    ldi XL , LOW(VAR1)
    ldi XH , HIGH(VAR1)
    ldi YL , LOW(VAR2)
    ldi YH , HIGH(VAR2)
    ldi ZL , LOW(soma)
    ldi ZH , HIGH(soma)
    
    
    ldi r16 , 10
    ldi r17 , 20
    ldi r18 , 30 
    ldi r19 , 40
    
    st X+,r16
    st Y+,r16
    st X+,r17
    st Y+,r17
    st X+,r18
    st Y+,r18
    st X+,r19
    st Y+,r19
    
    
    ldi XL , LOW(VAR1)
    ldi XH , HIGH(VAR1)
    ldi YL , LOW(VAR2)
    ldi YH , HIGH(VAR2)
    
    
    rcall soma_32_bits 
    
    rjmp start
    
    
    soma_32_bits:
    push r16
    push r17
    push r18
    push r19
    push r20
    push r21
    
    ldi r20,4
    clr r21
    
    loop1:
    ld r16,X+
    ld r18,Y+
    add r16,r18
    adc r21,r21
    st Z+,r16
    dec r20
    brne loop1
    
    
    
    
    pop r21
    pop r20
    pop r19
    pop r18
    pop r17
    pop r16
    
    
    
    ret