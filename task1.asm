; task1.asm
; Assembly program to classify a number as POSITIVE, NEGATIVE, or ZERO

section .data
    prompt db "Enter a number: ", 0
    positive db "The number is POSITIVE", 0
    negative db "The number is NEGATIVE", 0
    zero db "The number is ZERO", 0

section .bss
    number resb 5  ; Reserve space for the number input

section .text
    global _start

_start:
    ; Prompt the user
    mov eax, 4          ; syscall for write
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, prompt     ; message to display
    mov edx, 16         ; message length
    int 0x80            ; call kernel

    ; Read user input
    mov eax, 3          ; syscall for read
    mov ebx, 0          ; file descriptor (stdin)
    mov ecx, number     ; buffer for input
    mov edx, 5          ; max input size
    int 0x80            ; call kernel

    ; Convert input from ASCII to integer
    mov esi, number     ; pointer to input buffer
    xor eax, eax        ; clear eax
    xor ebx, ebx        ; clear ebx
convert_to_integer:
    mov bl, byte [esi]  ; load the next byte
    cmp bl, 10          ; check for newline
    je classify_number  ; if newline, end conversion
    sub bl, '0'         ; convert ASCII to integer
    imul eax, eax, 10   ; shift current value left
    add eax, ebx        ; add the new digit
    inc esi             ; move to the next byte
    jmp convert_to_integer

classify_number:
    ; Compare the number
    cmp eax, 0
    je print_zero        ; jump if number is zero
    jl print_negative    ; jump if number is negative
    jmp print_positive   ; otherwise, it’s positive

print_positive:
    mov eax, 4
    mov ebx, 1
    mov ecx, positive
    mov edx, 22
    int 0x80
    jmp exit_program

print_negative:
    mov eax, 4
    mov ebx, 1
    mov ecx, negative
    mov edx, 22
    int 0x80
    jmp exit_program

print_zero:
    mov eax, 4
    mov ebx, 1
    mov ecx, zero
    mov edx, 18
    int 0x80

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80
