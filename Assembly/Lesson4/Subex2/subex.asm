Code Segment 
assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, ax

    xor di, di
    mov si, 30 ;tick number
    xor dx, dx

    push dx

    mov bl, '9'

Draw:
    mov ax, 03h
    int 10h

    mov dh, 10
    mov dl, 40
    xor bh, bh
    mov ah, 02h
    int 10h

    mov ah, 02
    mov dl, bl
    int 21h

Delay:
    xor ah, ah
    pop cx
    push cx

    mov ax, dx
    sub dx, cx
    push dx

    

Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends
    End Start