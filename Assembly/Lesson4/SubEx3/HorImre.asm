Code Segment
    assume CS:Code, DS:Data, SS:Stack
Start:
    mov ax, Code
    mov ds, ax

    mov bl, '9'

    jmp Readclock

Write:
    mov ax, 03h
    int 10h

    mov dl, bl
    mov ah, 02
    int 21h

    dec bl

    cmp bl, '0'
    jnz Readclock

    jmp Terminate

Readclock:
    xor ah, ah 
    int 1ah

    pop cx 
    push cx 
    mov ax, dx 
    sub dx, cx 
    push ax

    cmp bl, '7'
    jc Ido1 
    mov al, 16 
    jmp Beallit

Ido1:
    cmp bl, '4' 
    jc Ido2 
    mov al, 8 
    jmp Beallit

Ido2:
    mov al, 4 

Beallit:
    xor ah, ah 
    cmp dx, ax

    pop ax

    jc Readclock

    pop cx
    push ax

    jmp Write

Terminate:
    mov ax, 4c00h
    int 21h

Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start
