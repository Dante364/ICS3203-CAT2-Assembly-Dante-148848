; task4.asm
; Assembly program to simulate water-level control using sensor input

section .data
    sensor_value db 0x03      ; Simulated sensor value (e.g., 3)
    motor_status db 0x00      ; Motor status: 0 (off), 1 (on)
    alarm_status db 0x00      ; Alarm status: 0 (off), 1 (on)
    prompt db "Simulating water level monitoring system...", 10, 0
    motor_on_msg db "Motor is ON", 10, 0
    motor_off_msg db "Motor is OFF", 10, 0
    alarm_on_msg db "Alarm is ON (High water level)", 10, 0
    alarm_off_msg db "Alarm is OFF", 10, 0

section .text
    global _start

_start:
    ; Display system simulation start message
    mov eax, 4              ; syscall for write
    mov ebx, 1              ; file descriptor (stdout)
    mov ecx, prompt         ; message to display
    mov edx, 40             ; message length
    int 0x80                ; kernel call

    ; Read sensor value
    mov al, [sensor_value]  ; Load the simulated sensor value

    ; Determine actions based on sensor value
    cmp al, 5               ; If sensor value > 5, trigger alarm
    jg trigger_alarm
    cmp al, 3               ; If sensor value <= 3, turn on motor
    jle turn_on_motor
    jmp turn_off_motor      ; Otherwise, turn off motor

trigger_alarm:
    mov byte [alarm_status], 1   ; Turn on alarm
    mov eax, 4
    mov ebx, 1
    mov ecx, alarm_on_msg
    mov edx, 30
    int 0x80                    ; Display "Alarm is ON"
    jmp end_program

turn_on_motor:
    mov byte [motor_status], 1   ; Turn on motor
    mov eax, 4
    mov ebx, 1
    mov ecx, motor_on_msg
    mov edx, 13
    int 0x80                    ; Display "Motor is ON"
    jmp end_program

turn_off_motor:
    mov byte [motor_status], 0   ; Turn off motor
    mov byte [alarm_status], 0   ; Turn off alarm
    mov eax, 4
    mov ebx, 1
    mov ecx, motor_off_msg
    mov edx, 14
    int 0x80                    ; Display "Motor is OFF"
    jmp end_program

end_program:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
