.data
headMsg:
    .asciz "Start av testprogram. Skriv in 5 tal!"  # En sträng som innehåller ett meddelande som ska visas i början av programmet
endMsg:
    .asciz "Testprogram slut"  # En sträng som innehåller ett meddelande som ska visas i slutet av programmet
buf:
    .space 64  # En buffert med 64 bytes utrymme för att lagra inmatad text
max:
    .quad 64  # En variabel för att lagra maxvärden
sum:
    .quad 0  # En variabel för att lagra summan av inmatade tal
temp:
    .quad 0  # En temporär variabel
pos:
    .long 0  # En variabel för att hålla reda på den aktuella positionen i bufferten
count:
    .long 0  # En variabel för att hålla reda på antalet inmatade tal

.text
.global inImage
inImage:
    movq    $buf, %rdi     # Ladda adressen till bufferten i register %rdi
    movq    max, %rsi      # Ladda max antal tecken att läsa in i register %rsi
    movq    stdin, %rdx    # Ladda filbeskrivaren för standardinmatning (stdin) i register %rdx
    call    fgets          # Anropa fgets för att läsa in en rad från standardinmatning och lagra den i bufferten
    movl    $0, pos        # Nollställ den aktuella positionen i bufferten genom att sätta variabeln pos till 0
    ret                    # Återvänd från funktionen

.global outImage
outImage:
    subq    $8, %rsp       # Flytta stackpekaren 8 bytes nedåt för att göra plats för en temporär variabel
    movq    $buf, %rdi     # Ladda adressen till bufferten i %rdi
    call    puts           # Anropa puts för att skriva ut innehållet i bufferten
    movl    $0, pos        # Nollställ utmatningspositionen
    addq    $8, %rsp       # Återställ stackpekaren
    ret                    # Återvänd från funktionen

.global getInt
getInt:
    # Placeholder implementation
    movq    $0, %rax
    ret

.global putInt
putInt:
    # Placeholder implementation
    ret

.global getText
getText:
    pushq   %rbx                # Save %rbx on the stack
    pushq   %rdi                # Save %rdi on the stack
    pushq   %rsi                # Save %rsi on the stack
    pushq   %rdx                # Save %rdx on the stack

    movq    pos, %rbx           # Load the current position in the input buffer
    movq    max, %rsi           # Load the maximum buffer size
    cmpq    %rsi, %rbx          # Compare current position with maximum buffer size
    jge     call_inImage        # If current position >= max, call inImage to read a new string

    movq    %rdi, %r15          # Save the destination buffer address in %r15
    movq    %rsi, %rdi          # Save the maximum number of characters to read in %rdi
    movq    $buf, %rsi          # Load the address of the input buffer
    addq    %rbx, %rsi          # Calculate the address of the current position in the input buffer

    movq    %rdi, %rcx          # Copy the maximum number of characters to read to %rcx
    movq    max, %rdx           # Load the maximum buffer size
    subq    %rbx, %rdx          # Calculate the remaining characters in the buffer
    cmpq    %rdx, %rcx          # Compare with the remaining characters in the buffer
    cmovg   %rdx, %rcx          # If remaining characters are less, use that value

    xorq    %rax, %rax          # Clear %rax (used for counting transferred characters)
copy_loop:
    cmpq    %rcx, %rax          # Compare counter with the number of characters to read
    jge     done                # If counter >= number of characters to read, exit the loop
    movb    (%rsi, %rax), %dl   # Load a byte from the input buffer
    movb    %dl, (%r15, %rax)   # Store the byte in the destination buffer
    incq    %rax                # Increment the counter
    cmpb    $0, %dl             # Check if the byte is NULL
    je      done                # If NULL, exit the loop
    jmp     copy_loop           # Repeat the loop

call_inImage:
    call    inImage             # Call inImage to read a new string
    movq    $0, pos             # Reset the current position to 0
    jmp     getText             # Retry getText

done:
    addq    %rax, %rbx          # Update the current position by adding the number of characters copied
    movq    %rbx, pos           # Save the updated position
    movq    %rax, %rax          # Move the result to %rax (return value)

    popq    %rdx                # Restore %rdx from the stack
    popq    %rsi                # Restore %rsi from the stack
    popq    %rdi                # Restore %rdi from the stack
    popq    %rbx                # Restore %rbx from the stack
    ret  

.global putText
putText:
    movq    %rdi, %rsi     # Kopiera pekaren till strängen till %rsi
    movq    $buf, %rdi     # Ladda adressen till bufferten i %rdi
    call    strcpy         # Kopiera strängen till bufferten
    ret                    # Återvänd från funktionen

.global getChar
getChar:
    
    # Placeholder implementation
    ret

.global putChar
putChar:
    # Placeholder implementation
    ret

.global getInPos
getInPos:
    # Placeholder implementation
    movq    $0, %rax
    ret

.global getOutPos
getOutPos:
    # Placeholder implementation
    movq    $0, %rax
    ret

.global setInPos
setInPos:
    
    ret


.global setOutPos
setOutPos:
    # Placeholder implementation
    ret
    