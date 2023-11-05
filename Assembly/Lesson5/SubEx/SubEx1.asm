Code Segment
    assume CS: Code, DS: Data, SS: Stack

Start:
    mov di, 82h
    mov cx, 10 ;alapértelmezett V0

Keres:
    mov dl, [di]
    cmp dl, "/"
    jz ElsoSzam
    inc di
    loop Keres
    jmp Default

ElsoSzam:
    inc di
    mov dl, [di]
    cmp dl, '0'
    jz Atugor

    cmp dl, 63
    jz Kiiras

    jmp ParamKezdet

Atugor:
    inc di
    jmp ParamKezdet

ParamKezdet:

    mov bl, [di]
    sub bl, 48
    inc di

    mov bh, [di]
    sub bh, 48
    
    mov ax, 10
    mul bl

    add al, bh
    mov cx, ax

    jmp Init

Kiiras:
    mov ax,Code
    mov ds,ax

    xor di,di
    xor si,si

    xor dx,dx
		
	mov ah,00
	mov al,02
	int 10h

    mov dx, offset segitoszoveg
    mov ah, 09h
    int 21h

    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h 

	mov dx, offset segitoszoveg2
	mov ah,09h
    int 21h

    jmp Program_Vege

Default:
    mov cx, 10

Init:
    mov ax, Code
    mov ds, ax

    xor di, di ;golyó sor pozíciója
    xor si, si ;golyó sor pozíciója

    xor dx, dx
    push dx ;veremben az idő (most 0)

Torles:
    mov ax, 03h
    int 10h

Rajz:
    mov bx, di ;sor koordináta
    mov dh, bl ;di alsó bájtja tartalmazza
    mov bx, si ;oszlop koordináta
    mov dl, bl ;si alsó bájtja tartalmazza
    xor bh, bh
    mov ah, 02h
    int 10h

    mov dx, offset labda
    mov ah, 09h
    int 21h

    pop ax ;idő a veremben
    push ax

    mov bl, al
    mul bl
    shr ax, 1 
    mov di, ax

    pop ax
    inc ax
    push ax
    dec ax

    mov bl, cl 
    mul bl 
    mov si, ax

    cmp si, 80 
    jnc Var

    cmp di, 25 
    jnc Var

    jmp Rajz

Var:
    xor ax, ax
    int 16h

Program_Vege:
    pop cx
    mov ax, 4c00h
    int 21h

labda db "O$"

segitoszoveg db "A program alapvetoen 10-el dob$"

segitoszoveg2 db "A program meghivasa utan adj meg egy parametert a / jel utan$"

Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

End Start