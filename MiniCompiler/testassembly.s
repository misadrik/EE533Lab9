//testversion2
main 
    lwfw s0  #load firstword
    lwlw s1  #load lastword
    nop
    nop
    nop

loop:
    beq s1 s0 exit
    addi s0 s0 1
    nop
    nop
    j loop
    nop
    nop
    nop

exit:
    j exit
    nop
    nop
    nop
