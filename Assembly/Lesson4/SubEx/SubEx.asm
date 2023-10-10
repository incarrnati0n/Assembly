Code Segment 
assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, ax

    xor di, di
    mov si, 1

    xor dx, dx
    push dx

Torles:
    mov ax, 03h
    int 10h

    mov dx, di
    mov dh, dl

    mov dl, 40
    xor bh, bh
    mov ah, 02h
    int 10h

    mov dx, offset labda
    mov ah, 09h
    int 21h

Kesleltet: 
    mov ah, 01h
    int 16h
    jnz Program_Vege

    jz nincsbill
    mov ah, 00h
    int 16h
    cmp al, 27
    jz Program_Vege

nincsbill:
    xor ah, ah
    int 1ah

    pop cx
    push cx
    mov ax, dx
    sub dx, cx
    push ax

    cmp di, 5
    jnc Ido1
    mov al, 16
    jmp Beallit

Ido1:
    cmp di, 10
    jnc Ido2
    mov al, 8
    jmp Beallit

Ido2:
    cmp di, 15
    jnc Ido3
    mov al, 8
    jmp Beallit

Ido3:
    cmp di, 20
    jnc Ido4
    mov al, 2
    jmp Beallit

Ido4:
    mov al, 1

Beallit:

    xor ah, ah
    cmp dx, ax

    pop ax

    jc Kesleltet

    pop cx
    push ax

    cmp di, 0
    jz Lefele

    cmp di, 24
    jz Felfele

Mozgas:

    mov dx, di
    mov dh, dl

    mov dl, 40

    mov ah, 02h
    int 10h

    mov dx, offset Szokoz
    mov ah, 09h
    int 21h

    add di, si
    jmp Torles
Lefele:
    mov si, 1
    jmp Mozgas

Felfele:
    mov si, -1
    jmp Mozgas

Program_Vege:
    pop cx
    mov ax, 4c00h
    int 21h

labda:
    db 'O$'

Szokoz:
    db ' $'

Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends
    End Start