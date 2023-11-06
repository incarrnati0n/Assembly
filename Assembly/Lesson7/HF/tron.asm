Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX
	;kezdő pont:
	mov bx, 480 ;oszlop_nyilak
	mov dx, 240 ;sor_nyilak
	push bx ;osz1
	push dx ;sor1
	
	mov bx, 160 ;oszlop_wasd 
	mov dx, 240 ;sor_wasd
	push bx ;osz2
	push dx ;sor2
	
	mov ah, 00h
	mov al, 12h ;grafikus mode 640*480
	int 10h
	
Rajz1:
	mov ah, 0ch ;pixel rajz
	
	pop ax;sor2 ki
	pop bx;oszlop2 ki
	
	pop dx ;sor1 ki
	pop cx ;oszlop1 ki
	push cx ;oszlop1 vissza
	push dx ;sor1 vissza
	push bx ;oszlop2 vissza
	push ax ;sor2 vissz
	
	mov ah, 0ch
	mov al, 03h 
	mov bh, 0 ;page 0
	int 10h
	
Rajz2:
	pop dx ;sor2 ki
	pop cx ;oszlop2 ki
	push cx ;oszlop2 vissza
	push dx ;sor2 vissza
	
	mov ah, 0ch ;pixel rajz
	mov al, 0dh
	mov bh, 0 ;page 0
	int 10h

Var:
	xor ah, ah
	int 16h
	
	cmp al, 27
	jz PV
	
	cmp al, 119
	jz Felfele2
	cmp al, 97
	jz Balra2
	cmp al, 115
	jz Lefele2
	cmp al, 100
	jz Jobbra2
	
	cmp ah, 75
	jz Balra1
	cmp ah, 77
	jz Jobbra1
	cmp ah, 72
	jz Felfele1
	cmp ah, 80
	jz Lefele1
	
	jmp Var

Balra1:
	pop ax ;sor2
	pop cx ;oszlop2
	pop dx ;sor1
	pop bx ;oszlop1
	dec bx
	cmp bx, 1
	jnc Tarol
	inc bx
	jmp Tarol
Jobbra1:
	pop ax ;sor2
	pop cx ;oszlop2
	pop dx ;sor1
	pop bx ;oszlop1
	inc bx
	cmp bx, 640
	jc Tarol
	dec bx
	jmp Tarol
Felfele1:
	pop ax ;sor2
	pop cx ;oszlop2
	pop dx ;sor1
	pop bx ;oszlop1
	dec dx
	cmp dx, 1
	jnc Tarol
	inc dx
	jmp Tarol
Lefele1:
	pop ax ;sor2
	pop cx ;oszlop2
	pop dx ;sor1
	pop bx ;oszlop1
	inc dx
	cmp dx, 480
	jc Tarol
	dec dx
	jmp Tarol
	;;;;;;;;;;;;
PV:
	jmp Program_Vege
	;;;;;;;;;;;;
Balra2:
	pop dx ;sor
	pop bx ;oszlop
	dec bx
	cmp bx, 1
	jnc Tarol2
	inc bx
	jmp Tarol2
Jobbra2:
	pop dx
	pop bx
	inc bx
	cmp bx, 640
	jc Tarol2
	dec bx
	jmp Tarol2
Felfele2:
	pop dx
	pop bx
	dec dx
	cmp dx, 1
	jnc Tarol2
	inc dx
	jmp Tarol2
Lefele2:
	pop dx
	pop bx
	inc dx
	cmp dx, 480
	jc Tarol2
	dec dx
	jmp Tarol2
Tarol:
	push bx ;osz1
	push dx ;sor1
	push cx ;osz2
	push ax ;sor2
	
	jmp Rajz1
Tarol2:
	push bx ;osz2
	push dx ;sor2
	
	jmp Rajz2

Program_Vege:

	mov ax, 03h ;cls
    int 10h

	pop dx
	pop bx
	
	mov	ax, 4c00h
	int	21h

Code	Ends

Data	Segment
Data	Ends

Stack	Segment
Stack	Ends
	End	Start

