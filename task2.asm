; task2.asm
; Assembly program to reverse an array of integers in place

section .data
    prompt db "Enter 5 integers separated by spaces: ", 0
    result_msg db "Reversed array: ", 0
    space db " ", 0
    newline db 10, 0

section .bss
    array resb 20    ; Array to hold 5 integers (4 bytes each)

section .text
    global _start

_start:
    ; Prompt the user
    mov eax, 4          ; syscall for write
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, prompt     ; message to display
    mov edx, 35         ; message length
    int 0x80            ; call kernel

    ; Read user input
    mov eax, 3          ; syscall for read
    mov ebx, 0          ; file descriptor (stdin)
    mov ecx, array      ; buffer for input
    mov edx, 20         ; max input size
    int 0x80            ; call kernel

    ; Reverse the array in place
    lea esi, [array]    ; Pointer to start of array
    lea edi, [array+16] ; Pointer to end of array (5 integers * 4 bytes)

reverse_loop:
    cmp esi, edi        ; Check if pointers have crossed
    jge done_reversing  ; Exit loop if complete
    mov eax, [esi]      ; Swap elements
    mov ebx, [edi]
    mov [esi], ebx
    mov [edi], eax
    add esi, 4          ; Move start pointer forward
    sub edi, 4          ; Move end pointer backward
    jmp reverse_loop

done_reversing:
    ; Print the reversed array
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 18
    int 0x80

    lea esi, [array]    ; Reset pointer to the start of the array
    mov ecx, 5          ; Counter for 5 integers

print_loop:
    mov eax, [esi]      ; Get the current integer
    push ecx            ; Preserve counter
    call print_int      ; Print the integer
    pop ecx             ; Restore counter
    lea eax, [space]
    mov edx, 1
    mov ebx, 1
    int 0x80
    add esi, 4          ; Move to the next integer
    loop print_loop

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Subroutine to print an integer (placeholder for now)
print_int:
    ; Convert integer to string and print (not implemented for simplicity)
    ret
