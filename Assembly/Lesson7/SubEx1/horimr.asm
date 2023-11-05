
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

    mov cl, 25

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
    mov es:[di], al

Var:
    xor ah, ah
    int 16h

    cmp al, 27
    jz JumpHelper

    cmp al, 48
    jz Szin0
    cmp al, 49
    jz Szin1
    cmp al, 50
    jz Szin2
    cmp al, 51
    jz Szin3
    cmp al, 52
    jz Szin4
    cmp al, 53
    jz Szin5
    cmp al, 54
    jz Szin6
    cmp al, 55
    jz Szin7
    cmp al, 56
    jz Szin8
    cmp al, 57
    jz Szin9

    cmp ah, 75
    jz Balra

    cmp ah, 77
    jz Jobbra

    cmp ah, 72
    jz Felfele

    cmp ah, 80
    jz Lefele

    jmp Var

Szin0:
    mov cl, 0
    jmp Tarol
Szin1:
    mov cl, 25
    jmp Tarol
Szin2:
    mov cl, 50
    jmp Tarol
Szin3:
    mov cl, 75
    jmp Tarol
Szin4:
    mov cl, 100
    jmp Tarol
Szin5:
    mov cl, 125
    jmp Tarol
Szin6:
    mov cl, 150
    jmp Tarol    
Szin7:
    mov cl, 175
    jmp Tarol
Szin8:
    mov cl, 200
    jmp Tarol
Szin9:
    mov cl, 225
    jmp Tarol

JumpHelper:
    jmp Program_Vege

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