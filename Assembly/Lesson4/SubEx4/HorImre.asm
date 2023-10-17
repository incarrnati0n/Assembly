Code Segment
    assume CS:Code, DS:Data, SS:Stack
Start:
    mov ax, Code
    mov ds, ax

    mov ax, 03h
    int 10h
    

    xor bl, bl
    xor di, di
    xor dx, dx
    push dx

    mov si, 2

Kiiro:
    mov di, dx
    xor bh, bh
    mov ah, 02h
    int 10h


    mov dx, '*'
    mov ah, 02h
    int 21h

Delay:
    mov ah, 01h
    int 16h
    jz Oraido

    mov ah, 00h
    int 16h
    cmp al, 27
    jz Program_Vege

Oraido:
    xor ah, ah
    int 1ah

    pop cx
    push cx
    mov ax, dx
    sub dx, cx
    push ax

Keresztezodes:
    mov ax, si
    cmp dx, ax

    pop ax

    jc Delay

    pop cx
    push ax

    mov dx, di

    cmp bl, 0
    jz Jobbra
    cmp bl, 1
    jz Lefele
    cmp bl, 2
    jz Balra
    cmp bl, 3
    jz Felfele

Jobbra:
    add dl, 1
    cmp dl, 79
    jz IranyValtoztat
    jmp Kiiro

Lefele:
    add dh, 1
    cmp dh, 23
    jz IranyValtoztat
    jmp Kiiro
Balra:
    sub dl, 1
    cmp dl, 0
    jz IranyValtoztat
    jmp Kiiro

Felfele:
    sub dh, 1
    cmp dh, 0
    jz Program_Vege
    jmp Kiiro

IranyValtoztat:
    add bl, 1
    jmp Kiiro

Program_Vege:
    pop cx
    mov ax, 4c00h
    int 21h

Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start