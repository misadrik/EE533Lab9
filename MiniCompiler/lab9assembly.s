main:
    lwfw s0  #load firstword
    lwlw s1  #load lastword
    nop
    nop
    nop
data_process:
    lw a5 s0 0
    nop
    nop
    nop
    sw a5 s0 0

add_first_addr:
    beq s0 s1 exit
    addi s0 s0 1 #first_word_addr = first_word_addr+1
    nop
    nop
    j data_process
    nop
    nop
    nop

exit:
    j exit
    nop
    nop
    nop
