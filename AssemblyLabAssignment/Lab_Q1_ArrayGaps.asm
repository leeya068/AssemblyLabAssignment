INCLUDE Irvine32.inc

.data
; Word elements sequenced in non-decreasing order
myArray WORD 0, 2, 5, 9, 10                        ; The target array [cite: 3]
arraySize = ($ - myArray) / TYPE myArray            ; Calculates number of elements (5)

.code
main PROC
    ; Clear all general-purpose registers to ensure a pristine debug window output
    mov eax, 0          ; EAX will accumulate the total sum of gaps [cite: 2]
    mov ebx, 0          ; EBX will hold the "next" element value
    mov ecx, 0          ; Clear ECX
    mov edx, 0          ; EDX will hold the "current" element value
    mov esi, 0          ; ESI acts as our index register, starting at offset 0 [cite: 2]
    mov edi, 0          ; Clear EDI
    
    ; Setup loop counter: we check gaps between adjacent pairs, so we loop (size - 1) times
    mov ecx, arraySize
    dec ecx             ; Loop counter = 4 iterations for 5 elements

gap_loop:
    ; 1. Retrieve the 'next' element using indexed addressing [cite: 2]
    ;    (esi + TYPE myArray) points 2 bytes ahead of the current index position
    movzx ebx, WORD PTR myArray[esi + TYPE myArray] 
    
    ; 2. Retrieve the 'current' element using indexed addressing [cite: 2]
    movzx edx, WORD PTR myArray[esi]                 
    
    ; 3. Calculate the gap size (Next Element - Current Element)
    sub ebx, edx                                    
    
    ; 4. Add this individual gap to our running total accumulator [cite: 2]
    add eax, ebx                                    
    
    ; 5. Move index register forward by 2 bytes (the size of a WORD) to check the next pair
    add esi, TYPE myArray                           
    loop gap_loop

    ; Display register states in the Visual Studio Debug Console
    call DumpRegs                                   
    
    exit
main ENDP
END main