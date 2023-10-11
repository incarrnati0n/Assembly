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
    int 1ah

    pop cx
    push cx

    mov ax, dx
    sub dx, cx
    push ax ;talán dx, de lehet hogy nem

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