; boot.asm
[BITS 16]
[ORG 0x7C00]       ; Boot sector is loaded at 0x7C00

; Print a simple message
mov si, msg        ; Load the address of the message
call print_string  ; Call the function to print

; Hang the system
jmp $

; Function to print string
print_string:
    mov ah, 0x0E   ; BIOS teletype function
.next_char:
    lodsb          ; Load byte at DS:SI into AL
    test al, al    ; Check if end of string (0)
    jz .done       ; If zero, we are done
    int 0x10       ; Call BIOS to print character
    jmp .next_char ; Loop to next character
.done:
    ret

msg db 'Hello, World!', 0

times 510-($-$$) db 0  ; Fill the rest of the sector with zeros
dw 0xAA55              ; Boot signature
