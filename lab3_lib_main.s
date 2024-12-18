// NOTES
// rax 64-bit register, eax 32-bit register, ax 16-bit register, al 8-bit register
// syffix b byte(8bit), w word(16bit), l long(32bit/64bitflyt), q quad(64bit)



.data
headMsg:    .asciz "Start av testprogram. Skriv in 5 tal!"
endMsg:     .asciz "Testprogram slut"
buf:        .space 64
inbuf:      .space 64
outbuf:     .space 64


.text
.global inImage
inImage:
	movq 	$inbuf, %rdi    # lägg i buf, där buf är en bit reserverat minne
    movq 	MAXPOS,%rsi     # högst 5-1=4 tecken (NULL räknas ju också)
    movq 	stdin, %rdx     # från standard input stdin=$0 om ej def
    call    fgets

	ret


.global outImage
outImage:

    ret

.global putText
putText:
    movq %rdi, %r10




    ret