Code Segment
    assume CS:Code, DS:Data, SS:Stack
Start:
    mov ax, Code
    mov ds, ax

    jmp Beker

Bekerhiba:

    mov dx, offset hibauzenet
    mov ah, 02h
    int 21h

Beker:

    xor ax, ax
    int 16h

    cmp al, 1
    jl Bekerhiba

    cmp al, 3
    jg Bekerhiba

    sub al, 0

    mov cl, al
    
    mov al, 1
    mov bl, 4

Szorzo:
    mul bl
    loop Szorzo

    mov cl, 8
    div cl

    mov bl, al
    add bl, '0'
    mov dl, bl

    mov ah, 02h
    int 21h


hibauzenet db "Hibas karakter!$"

kezdoszoveg db "(4^N / 8) fuggveny eredmenye: $"

Program_Vege:
    mov ax, 4c00h
    int 21h

Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start