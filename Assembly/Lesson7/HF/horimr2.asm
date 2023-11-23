Code Segment
assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, AX

    ; Set initial coordinates for Line 1
    mov cx, 100
    mov dx, 100

    push dx
    push cx

    ; Set initial coordinates for Line 2
    mov cx, 50
    mov dx, 50

    push dx
    push cx

    mov ax, 13h
    int 10h

    mov ax, 0a000h
    mov es, ax

Rajz1:
    pop cx

    ; Handle input for Line 1
    xor ax, ax
    mov ax, cx

    push cx
    mov bx, 320
    mul bx

    pop cx
    pop dx
    add ax, dx
    jnc Pixel1
    inc ah

    jmp Pixel1

Rajz2:
    pop cx

    ; Handle input for Line 2
    xor ax, ax
    mov ax, cx

    push cx
    mov bx, 320
    mul bx

    pop cx
    pop dx
    add ax, dx
    jnc Pixel2
    inc ah

    jmp Pixel2

Pixel1:
    push dx
    push cx
    mov di, ax
    mov al, 1
    mov es:[di], al

    jmp Var1

Pixel2:
    push dx
    push cx
    mov di, ax
    mov al, 4
    mov es:[di], al

    jmp Var2

Var1:
    xor ax, ax
    int 16h

    ; Input handling for Line 1
    cmp al, 27
    jz JumpHelper1

    cmp ah, 75
    jz Balra1

    cmp ah, 77
    jz Jobbra1

    cmp ah, 72
    jz Felfele1

    cmp ah, 80
    jz Lefele1

    jmp Var1

Balra1:
    pop cx
    pop dx
    dec dx
    cmp dx, 1
    jnc Tarol1
    inc dx
    jmp Tarol1

Jobbra1:
    pop cx
    pop dx
    inc dx
    cmp dx, 320
    jc Tarol1
    dec dx
    jmp Tarol1

Felfele1:
    pop cx
    pop dx
    dec cx
    cmp cx, 1
    jnc Tarol1
    inc cx
    jmp Tarol1

Lefele1:
    pop cx
    pop dx
    inc cx
    cmp cx, 200
    jc Tarol1
    dec cx
    jmp Tarol1

JumpHelper1:
    jmp Program_Vege

Var2:
    xor ax, ax
    int 16h

    ; Input handling for Line 2
    cmp al, 'a'
    jz Balra2

    cmp al, 's'
    jz Lefele2

    cmp al, 'w'
    jz Felfele2

    cmp al, 'd'
    jz Jobbra2

    jmp Var2

Balra2:
    pop cx
    pop dx
    dec dx
    cmp dx, 1
    jnc Tarol2
    inc dx
    jmp Tarol2

Jobbra2:
    pop cx
    pop dx
    inc dx
    cmp dx, 320
    jc Tarol2
    dec dx
    jmp Tarol2

Felfele2:
    pop cx
    pop dx
    dec cx
    cmp cx, 1
    jnc Tarol2
    inc cx
    jmp Tarol2

Lefele2:
    pop cx
    pop dx
    inc cx
    cmp cx, 200
    jc Tarol2
    dec cx
    jmp Tarol2

Tarol1:
    push dx
    push cx
    jmp Rajz1

Tarol2:
    push dx
    push cx
    jmp Rajz2

Program_Vege:
    mov ax, 03h
    int 10h

    pop cx
    pop dx

    mov ax, 4c00h
    int 21h

Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start
