INCLUDE Irvine32.inc

.data
startVal DWORD 8         ; The initial value constraint from instruction (a)
outerCount DWORD ?

.code
main PROC
    mov ecx, startVal    ; Set outer loop to run 8 times (for the 8 rows)
    mov esi, 1           ; ESI will keep track of the starting digit for the current row

row_loop:
    mov outerCount, ecx  ; Save outer loop counter because inner loop will overwrite ECX
    
    ; Setup inner loop to print digits from current ESI value up to 8
    mov ecx, startVal    ; Reset ECX to 8
    sub ecx, esi         ; Number of remaining digits to print = (8 - starting digit)
    inc ecx              ; Correct the loop count to include the starting digit itself
    
    mov eax, esi         ; EAX will hold the active digit to be printed on this row

digit_loop:
    call WriteDec        ; Print the number currently stored in EAX
    inc eax              ; Increment to the next sequence digit
    loop digit_loop      ; Repeat until the row sequence completes

    call CrLf            ; Print a newline character at the end of the row
    inc esi              ; Increment starting position for the next row (e.g., 1 -> 2)
    
    mov ecx, outerCount  ; Restore outer loop counter
    loop row_loop        ; Repeat for the next row

    exit
main ENDP
END main