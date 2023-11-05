
Code    Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov DS, AX
		
	mov dx, 100 ;x dl
	mov cx, 100	;y dh
	push dx
	push cx
		
	mov ax, 13h
	int	10h
		
	mov	ax, 0a000h
	mov es, ax

Rajz:
	pop	cx
		
	xor	ax, ax
	mov	ax, cx
		
	push cx
	mov	dx, 320
	mul	dx
	pop	cx
	pop	dx
	add	ax, dx
	jnc	Pixel
	inc ax
Pixel:
	push dx
	push cx
	mov	di,ax
	mov	al, 255
    mov al, cl
    inc cl
	mov	es:[di], al
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
	
	jmp	Var
JumpHelper:
	jmp Program_Vege
Balra:
	pop	cx
	pop	dx
	dec	dx
	cmp	dx, 1
	jnc	Tarol
	inc	dx
	jmp	Tarol
		
Jobbra:
	pop	cx
	pop	dx
	inc	dx
	cmp	dx, 320
	jc Tarol
	dec	dx
	jmp	Tarol
 		
Felfele:
	pop	cx
	pop	dx
	dec cx
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
		
Tarol:
	push dx
	push cx
	jmp	Rajz
		
Program_Vege:
	mov	ax, 03h
	int	10h
	
	pop	dx
	
	mov	ax, 4c00h
	int	21h
		

Code	Ends
Data	Segment
Data	Ends
Stack	Segment
Stack 	Ends
	End		Start

