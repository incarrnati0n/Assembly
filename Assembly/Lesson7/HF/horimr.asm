
Code    Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov DS, AX		

	mov cx, 100 ;X1 
	mov dx, 100 ;Y1

	push dx ;Y1 be
	push cx ;X1 be

	mov cx, 200 ;X2
	mov dx, 200 ;Y2

	push dx ;Y2 be
	push cx ;X2 be

	mov ax, 13h
	int	10h
	
	mov	ax, 0a000h
	mov es, ax

Rajz: ;X1, Y1
	
	pop cx ;X2 ki
	pop dx ;Y2 ki
	pop bx ;X1 ki
	pop ax ;Y1 ki
		
	push ax
	push bx
	push dx
	push cx
		
	mov dx, 320
	mul	dx
		
	add	ax, bx
	mov di, ax
	;jnc	Pixel
	;inc ah

	jmp Pixel

Rajz2:
	pop bx
	pop ax

	push ax
	push bx
		
	mov	dx, 320
	mul	dx
		
	add	ax, bx
	mov di, ax
	;jnc	Pixel2
	;inc ah

	jmp Pixel2

Pixel:
	mov	al, 1
	mov	es:[di], al

	jmp Var
Pixel2:
	mov al, 4
	mov es:[di], al

	jmp Var
Var:
	xor	ax,ax
	int	16h
	
	cmp	al, 27
	jz	JumpHelper
	
	cmp	ah, 75
	jz	Balra
		
	cmp	ah, 77
	jz	Jobbra
		
	cmp	ah, 72
	jz	Felfele

	cmp	ah, 80
	jz	Lefele
	
	cmp al, 'a'
	jz Balra2

	cmp al, 's'
	jz Lefele2

	cmp al, 'w'
	jz Felfele2

	cmp al, 'd'
	jz Jobbra2

	jmp	Var

Balra:
	pop cx ;X2 ki
	pop dx ;Y2 ki
	pop bx ;X1 ki
	pop ax ;Y1 ki
		
	;push ax
	;push bx
	;push dx
	;push cx

	dec	bx
	cmp	bx, 1
	jnc Tarol
	inc bx
	jmp	Tarol
	
Jobbra:
	pop cx ;X2 ki
	pop dx ;Y2 ki
	pop bx ;X1 ki
	pop ax ;Y1 ki
		
	;push ax
	;push bx
	;push dx
	;push cx

	inc bx
	cmp	bx, 320
	jc	Tarol
	dec	bx
	jmp	Tarol
	
Felfele:
	pop cx ;X2 ki
	pop dx ;Y2 ki
	pop bx ;X1 ki
	pop ax ;Y1 ki
		
	;push ax
	;push bx
	;push dx
	;push cx

	dec	ax
	cmp	ax, 1
	jnc Tarol
	inc	ax
	jmp	Tarol

Lefele:

	pop cx ;X2 ki
	pop dx ;Y2 ki
	pop bx ;X1 ki
	pop ax ;Y1 ki
		
	;push ax
	;push bx
	;push dx
	;push cx

	inc	ax
	cmp	ax, 200
	jc	Tarol
	dec	ax
	jmp	Tarol

JumpHelper:
	jmp Program_Vege

Balra2:
	pop bx
	pop ax

	;push ax
	;push bx

 	dec	bx
	cmp	bx, 1
	jnc Tarol2
	inc bx
	jmp	Tarol2
	
Jobbra2:
	pop bx
	pop ax

	;push ax
	;push bx

	inc bx
	cmp	bx, 320
	jc	Tarol2
	dec	bx
	jmp	Tarol2
	
Felfele2:
	pop bx
	pop ax

	;push ax
	;push bx

	dec	ax
	cmp	ax, 1
	jnc Tarol2
	inc	ax
	jmp	Tarol2

Lefele2:
	pop bx
	pop ax

	;push ax
	;push bx

	inc	ax
	cmp	ax, 200
	jc	Tarol2
	dec	ax
	jmp	Tarol2

Tarol:
	push ax
	push bx
	push dx
	push cx
	jmp	Rajz

Tarol2:
	push ax
	push bx
	jmp Rajz2

Program_Vege:
	mov	ax, 03h
	int	10h
		
	pop	cx
	pop	dx
	
	mov	ax, 4c00h
	int	21h
		

Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
	End	Start

