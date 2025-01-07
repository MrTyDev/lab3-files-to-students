.section .data
headMsg:    .asciz  "Start av testprogram. Skriv in 5 tal!"
endMsg:     .asciz  "Testprogram slut"
buf:        .space  64
sum:        .quad   0
temp:       .quad   0
count:      .quad   0
inpos:      .quad   0
MAXPOS:     .quad   64
inbuf:      .space  64
outbuf:     .space  64
buf_empty:  .quad   1
outpos:     .quad   0

.section .text
.global main_start

main_start:
    # Call putText with headMsg
    movq    $headMsg, %rdi
    call    putText

    # Call outImage
    call    outImage

    # Call inImage
    call    inImage

    # Exit the program
    movq    $60, %rax       # syscall: exit
    xorq    %rdi, %rdi      # status: 0
    syscall

# Function: putText
.global putText
putText:
    movq    %rdi, %r15
clean_blank:
    cmpb    $' ', (%r15)
    jne     iter
    incq    %r15
    jmp     clean_blank
iter:
    cmpb    $0, (%r15)
    je      end_iter
    movb    (%r15), %dil
    call    putChar
    incq    %r15
    jmp     iter
end_iter:
    ret

# Function: outImage
.global outImage
outImage:
    pushq   %rbp
    movq    %rsp, %rbp
    movq    $outbuf, %rdi
    call    puts
    movq    $0, outpos
    popq    %rbp
    ret

# Function: inImage
.global inImage
inImage:
    movq    $inbuf, %rdi
    movq    $MAXPOS, %rsi
    movq    stdin, %rdx          # stdin
    call    fgets
    movq    $0, inpos
    ret

# Function: putChar
.global putChar
putChar:
    call    check_outpos
    movq    $outbuf, %r8
    addq    outpos, %r8
    movb    %dil, (%r8)
    incq    outpos
    ret

# Function: check_outpos
.global check_outpos
check_outpos:
    movq    outpos, %rax
    cmpq    MAXPOS, %rax
    jl      less
    call    outImage
less:
    ret

# Implement missing functions
.global getInt, getOutPos, setOutPos, putInt, getText

getInt:
    # Dummy implementation
    movq $0, %rax
    ret

getOutPos:
    # Dummy implementation
    movq outpos, %rax
    ret

setOutPos:
    # Dummy implementation
    movq %rdi, outpos
    ret

putInt:
    # Dummy implementation
    ret

getText:
    # Dummy implementation
    ret
