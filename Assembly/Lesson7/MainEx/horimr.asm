Code Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, AX

    mov dl, 100
    mov dh, 100
    push dx

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
    jnc Pixel
    inc ah

Pixel:
    push dx
    mov di, ax
    mov al, 128
    mov al, cl
    inc cl
    mov es:[di], al

Var:
    xor ah, ah
    int 16h

    cmp al, 27
    jz Program_Vege

    cmp ah, 75
    jz Balra

    cmp ah, 77
    jz Jobbra

    cmp ah, 72
    jz Felfele

    cmp ah, 80
    jz Lefele

    jmp Var

Balra:
    pop dx
    dec dl
    cmp dl, 1
    jnc Tarol
    inc dl
    jmp Tarol

Jobbra:
    pop dx
    inc dl
    cmp dl, 250
    jc Tarol
    dec dl
    jmp Tarol

Felfele:
    pop dx
    dec dh
    cmp dh, 1
    jnc Tarol
    inc dh
    jmp Tarol

Lefele:
    pop dx
    inc dh
    cmp dh, 200
    jc Tarol
    dec dh
    jmp Tarol

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