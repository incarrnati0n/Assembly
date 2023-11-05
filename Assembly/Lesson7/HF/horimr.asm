
Code    Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov DS, AX		

	mov cx, 100
	mov dx, 100

	push dx
	push cx

	mov cx, 200
	mov dx, 200

	push dx
	push cx

	mov ax, 13h
	int	10h
	
	mov	ax, 0a000h
	mov es, ax

Rajz:
	pop cx

	xor	ax, ax
	mov	ax, cx
		
	push cx
		
	mov	bx, 320
	mul	bx
		
	pop cx
	pop	dx
	add	ax, dx
	jnc	Pixel
	inc ah

	jmp Pixel

Rajz2:
	pop cx

	xor	ax, ax
	mov	ax, cx
		
	push cx
		
	mov	bx, 320
	mul	bx
		
	pop cx
	pop	dx
	add	ax, dx
	jnc	Pixel2
	inc ah

	jmp Pixel2

Pixel:
	push dx
	push cx
	mov	di,ax
	mov	al, 1
	mov	es:[di], al

	jmp Var
Pixel2:
	push dx
	push cx
	mov di, ax
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
	pop cx
	pop	dx
	dec	dx
	cmp	dx, 1
	jnc Tarol
	inc dx
	jmp	Tarol
	
Jobbra:
	pop	cx
	pop	dx
	inc dx
	cmp	dx, 320
	jc	Tarol
	dec	dx
	jmp	Tarol
	
Felfele:
	pop	cx
	pop	dx
	dec	cx
	cmp	cx, 1
	jnc Tarol
	inc	cx
	jmp	Tarol

Lefele:
	pop	cx
	pop	dx
	inc	cx
	cmp	cx, 200
	jc	Tarol
	dec	cx
	jmp	Tarol

JumpHelper:
	jmp Program_Vege

Balra2:
	pop cx
	pop	dx
	dec	dx
	cmp	dx, 1
	jnc Tarol2
	inc dx
	jmp	Tarol2
	
Jobbra2:
	pop	cx
	pop	dx
	inc dx
	cmp	dx, 320
	jc	Tarol2
	dec	dx
	jmp	Tarol2
	
Felfele2:
	pop	cx
	pop	dx
	dec	cx
	cmp	cx, 1
	jnc Tarol2
	inc	cx
	jmp	Tarol2

Lefele2:
	pop	cx
	pop	dx
	inc	cx
	cmp	cx, 200
	jc	Tarol2
	dec	cx
	jmp	Tarol2

Tarol:
		
	push dx
	push cx
	jmp	Rajz

Tarol2:
	push dx
	push cx
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

