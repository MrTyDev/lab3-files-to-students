# NOTES
# rax 64-bit register, eax 32-bit register, ax 16-bit register, al 8-bit register
# syffix b for byte, w for word, l for long, q for quad
#
#
#


.global maxNum

maxNum:
    movl (%rdi), %eax
loop:
    addq $4, %rdi
    cmpl %eax, (%rdi)
    jl label
    movl (%rdi), %eax

label:
    decl %esi
    cmpl $1, %esi
    jg loop

    ret
