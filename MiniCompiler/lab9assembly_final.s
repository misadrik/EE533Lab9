// load packet and add 1 to packet payload.
main:
    lwfw s0  #load firstword
    lwlw s1  #load lastword

sub_lastword:
    addi a4 x0 2
    nop
    nop
    nop
    sub s2 s1 a4
    nop
    nop
    nop

add_lastword
    lw a5 s2 0
    nop
    nop
    nop
    addi a5 a5 1
    nop
    nop
    nop
    sw a5 s2 0
    beq x0 x0 exit

exit:
    j exit
    nop
    nop
    nop