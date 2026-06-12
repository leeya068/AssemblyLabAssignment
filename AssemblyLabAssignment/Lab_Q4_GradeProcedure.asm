INCLUDE Irvine32.inc

.data
prompt BYTE "Enter mark (0-100): ", 0  ; Prompt string matching assignment output
gradePrompt BYTE "Grade: ", 0          ; Label for displaying the result
mark DWORD ?                           ; Variable to hold user input

.code
main PROC
    ; 1. Prompt user for mark input
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt                        ; Reads integer from user console into EAX
    mov mark, eax                       ; Store input into memory variable

    ; 2. Call the custom procedure
    ; Pass input value via the EAX register
    call GetGrade

    ; 3. Display Grade Output
    mov edx, OFFSET gradePrompt
    call WriteString
    call WriteChar                      ; Print the single capital letter returned in AL
    call CrLf

    exit
main ENDP

;-------------------------------------------------------------
GetGrade PROC
; Receives: EAX = mark integer between 0 and 100
; Returns:  AL  = ASCII letter grade character ('A', 'B', 'C', 'D', 'F')
; Purpose:  Evaluates the score and returns a single capital letter based on ranges.
;-------------------------------------------------------------
    cmp eax, 90
    jae gradeA          ; If mark >= 90, jump to A [cite: 54, 55]
    
    cmp eax, 80
    jae gradeB          ; If mark >= 80 (and < 90), jump to B [cite: 56, 57]
    
    cmp eax, 70
    jae gradeC          ; If mark >= 70 (and < 80), jump to C [cite: 58, 59]
    
    cmp eax, 60
    jae gradeD          ; If mark >= 60 (and < 70), jump to D [cite: 60, 61]
    
    jmp gradeF          ; If mark < 60, default jump to F [cite: 62, 63]

gradeA:
    mov al, 'A'         ; Store 'A' into 8-bit return register AL [cite: 55]
    ret                 ; Return to caller
gradeB:
    mov al, 'B'         ; Store 'B' into 8-bit return register AL [cite: 57]
    ret
gradeC:
    mov al, 'C'         ; Store 'C' into 8-bit return register AL [cite: 59]
    ret
gradeC_end:             ; Balancing label sequence structure
gradeD:
    mov al, 'D'         ; Store 'D' into 8-bit return register AL [cite: 61]
    ret
gradeF:
    mov al, 'F'         ; Store 'F' into 8-bit return register AL [cite: 63]
    ret
GetGrade ENDP

END main