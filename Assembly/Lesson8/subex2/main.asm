Code Segment
    assume CS:Code, DS:Data, SS:Stack
Start:
    mov ax, Code
    mov ds, ax

    mov ax, 03h
    int 10h

    mov ah, 02h
    mov bh, 0
    mov dl, 40
    mov dh, 13
    int 10h

    mov dx, offset felirat
    mov ah, 09h
    int 21h



Animal:
    inc dl


    push dx

    mov dx, offset felirat
    mov ah, 09h
    int 21h

    pop dx

    cmp al, 69
    jz input 

    jmp Readclock

Input:
    xor ax, ax
    int 16h

    cmp al, 27
    jz Program_Vege

    cmp al, 'w'
    jz Felfele

    cmp al, 's'
    jz Lefele

    jmp Input


Felfele:



Lefele:


Readclock:
    xor ax, ax
    int 1ah

    pop cx 
    push cx 
    mov ax, dx 
    sub dx, cx 
    push ax

    mov al, 5

Beallit:
    xor ah, ah 
    cmp dx, ax

    pop ax

    jc Readclock

    pop cx
    push ax

    jmp Animal
    



felirat db "Wow, mozog!$"

Program_Vege:
    mov ax, 4c00h
    int 21h


Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start