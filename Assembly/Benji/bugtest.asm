Code Segment
    assume CS: Code, DS: Data, SS: Stack

Start:
    mov ax, Code
    mov ds, ax

    mov dl, 10
    mov dh, 10
    push dx

    mov cx, 10

    mov ax, 13h
    int 10h

    mov ax, 0a000h
    mov es, ax

Rajz:
    pop dx
    xor ah, ah
    mov al, dh
    push dx
    mov bx, 320
    mul bx
    pop dx
    add al, dl
    jnc SorCalc
    inc ah

SorCalc:
    push ax

    xor ah, ah
    mov al, dh
    mov bl, 2

    div bl

    cmp ah, 1
    jz Pixel2

    pop ax

Pixel:
    push dx
    mov di, ax
    mov al, 15
    mov es:[di], al

    jmp KockaX

Pixel2:
    pop ax
    push dx
    mov di, ax
    mov al, 10
    mov es:[di], al

KockaX: 
    cmp dl, 20
    jc IncX

    mov dl, 9
    inc dh

    loop KockaX

    jmp Kilep

IncX:
    inc dl
    jmp Tarol

Kilep:
    xor ah, ah
    int 16h

    jmp Program_Vege

Tarol:
    push dx
    jmp Rajz

Program_Vege:
    mov ax, 03h
    int 10h

    pop dx

    mov ax, 4c00h
    int 21h

Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

End Start