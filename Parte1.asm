   
.INCLUDE <m328Pdef.inc>

 .DSEG
 .ORG SRAM_START
 

 
 VAR1 : .BYTE 4 ; var de 32 bits
 VAR2 : .BYTE 4
 subt : .BYTE 4
 .CSEG

main:
    ldi XL , LOW(VAR1)
    ldi XH , HIGH(VAR1)
    
    ldi r16 , 10
    ldi r17 , 20
    ldi r18 , 30
    ldi r19 , 40
    
    rcall init_32bits
    
    ldi XL , LOW(VAR1)
    ldi XH , HIGH(VAR1)
    
    rcall zera_32bits
    
     ldi XL , LOW(VAR1)
     ldi XH , HIGH(VAR1)
     ldi YL , LOW(VAR2)
     ldi YH , HIGH(VAR2)
     ldi ZL , LOW(subt)
     ldi ZH , HIGH(subt)
     
    rcall sub_32bits
    
    rjmp main 

    init_32bits:
    
    st X+,r16
    st X+,r17
    st X+,r18
    st X+,r19
   
    ret
   
    
    zera_32bits:
    
    ldi r20,0
    st X+,r20
    st X+,r20
    st X+,r20
    st X+,r20
    
    
    ret
    
    sub_32bits:
    
  
    
    push r16
    push r17
    push r18
    push r19
    push r20
    push r21
    
    
    ldi r20,4
    clr r21
    
    
    loop_sub:
    ld r16 ,X+
    ld r17 ,Y+
    sub r16,r17
    st Z+,r16
    sbc r21,r21
    dec r20
    brne loop_sub
    
    
    ret