INCLUDE Irvine32.inc

.data
prompt BYTE "Enter 32-bit integer : ", 0             ; Input prompt text matching example
resultPrompt BYTE "The sum of 32-bit integrs is : ", 0 ; Result text matching example
array DWORD 3 DUP(?)                                  ; Array container to hold three 32-bit values

.code
main PROC
    ; 1. Clear active registers to ensure clean environment
    mov eax, 0
    mov ebx, 0
    mov ecx, 3          ; Set loop counter to prompt for exactly 3 integers
    mov esi, 0          ; Array index offset pointer (starts at 0)

    ; 2. User Input Loop
input_loop:
    mov edx, OFFSET prompt
    call WriteString    ; Display "Enter 32-bit integer : "
    call ReadInt        ; Read 32-bit signed integer into EAX
    
    mov array[esi], eax ; Store the user input directly into the array at current offset
    add esi, TYPE array ; Advance index pointer by 4 bytes (size of a DWORD)
    loop input_loop

    ; 3. Cumulative Summation Step
    mov eax, 0          ; Clear EAX accumulator to zero out old loop tracking data
    mov ecx, 3          ; Reset loop counter to cycle through the array elements
    mov esi, 0          ; Reset array index pointer back to the beginning element

sum_loop:
    add eax, array[esi] ; Add the array element value to our EAX total accumulator
    add esi, TYPE array ; Advance index pointer by 4 bytes to point to next integer
    loop sum_loop

    ; 4. Display Results
    mov edx, OFFSET resultPrompt
    call WriteString    ; Display "The sum of 32-bit integrs is : "
    call WriteInt       ; Displays the calculated sum prefixed with a explicit '+' or '-' sign
    call CrLf           ; Print newline

    exit
main ENDP
END main