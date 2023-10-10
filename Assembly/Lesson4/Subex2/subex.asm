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
    int 10h   ;video mode setup 80x25

    mov dh, 10 ;sor beállítás
    mov dl, 40 ;oszlop beállítás
    xor bh, bh ;videó lap beállítás mindig 0 és xor-al elérjük

    mov ah, 02h
    int 10h ;kurzor pozíció beállítás

    mov ah, 02
    mov dl, bl ;9 belemozgatása a bl-be és karakter kiiratása
    int 21h

Delay:

    xor ah, ah

    pop cx
    push cx

    mov ax, dx
    sub dx, cx
    push ax ;talán dx, de lehet hogy nem

    cmp bl, 9
    jnc Time1
    sub si, 3
    jmp Setup

Time1:
    dec bl
    cmp bl, 6
    jl Time2
    sub si, 6
    jmp Setup

Time2:
    dec bl
    cmp bl, 4
    jl Time3
    sub si, 9     
    jmp Setup

Time3:
    dec bl
    cmp bl, 2
    jl Time4
    sub si, 12
    jmp Setup

Time4:
    sub si, 1
Setup:
    xor ah, ah
    cmp dx, ax

    pop ax

    jc Delay

    pop cx
    push ax

    cmp bl, 0
    jz Program_Vege

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