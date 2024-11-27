; task3.asm
; Assembly program to compute the factorial of a number using a subroutine

section .data
    prompt db "Enter a number: ", 0
    result_msg db "Factorial: ", 0
    error_msg db "Error: Input must be a positive integer.", 0
    newline db 10, 0

section .bss
    number resb 4       ; To store user input
    factorial resb 4    ; To store the factorial result

section .text
    global _start

_start:
    ; Prompt the user
    mov eax, 4          ; syscall for write
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, prompt     ; message to display
    mov edx, 15         ; length of message
    int 0x80            ; kernel call

    ; Read user input
    mov eax, 3          ; syscall for read
    mov ebx, 0          ; file descriptor (stdin)
    mov ecx, number     ; buffer to store input
    mov edx, 4          ; max input size
    int 0x80            ; kernel call

    ; Convert input from ASCII to integer
    mov esi, number     ; pointer to the input buffer
    xor eax, eax        ; clear eax
    xor ebx, ebx        ; clear ebx (temp register)
convert_to_integer:
    mov bl, byte [esi]  ; read the current character
    cmp bl, 10          ; check for newline
    je validate_input   ; if newline, finish conversion
    sub bl, '0'         ; convert ASCII to integer
    imul eax, eax, 10   ; multiply current value by 10
    add eax, ebx        ; add the new digit
    inc esi             ; move to the next character
    jmp convert_to_integer

validate_input:
    cmp eax, 0          ; ensure the input is positive
    jl input_error      ; jump to error handling if negative

    ; Call factorial subroutine
    push eax            ; push the number onto the stack
    call factorial      ; call the factorial subroutine
    add esp, 4          ; clean up the stack
    mov [factorial], eax; store the result

    ; Print the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 10
    int 0x80            ; write "Factorial: "

    mov eax, [factorial]
    call print_int      ; print the factorial value

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

input_error:
    ; Display error message
    mov eax, 4
    mov ebx, 1
    mov ecx, error_msg
    mov edx, 39
    int 0x80
    jmp exit_program

; Factorial Subroutine
factorial:
    push ebx            ; preserve registers
    push ecx
    mov ecx, eax        ; set ECX as the counter
    mov eax, 1          ; initialize result in EAX
factorial_loop:
    cmp ecx, 1          ; check if counter <= 1
    jle factorial_done  ; if yes, finish
    mul ecx             ; multiply EAX by ECX
    dec ecx             ; decrement counter
    jmp factorial_loop  ; repeat
factorial_done:
    pop ecx             ; restore registers
    pop ebx
    ret

; Subroutine to print an integer (basic)
print_int:
    ; Implementation to convert and print integer is omitted for simplicity
    ret
