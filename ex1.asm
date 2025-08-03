
.def valor1 = r16
.def valor2 = r17
.equ const = 22
    
start :
    ldi valor1 , 10
    ldi valor2 , 20
    add valor2,valor1
    mov r18 , valor2
    
    rjmp start 