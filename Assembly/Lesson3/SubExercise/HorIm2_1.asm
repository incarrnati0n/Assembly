
Code    Segment
        assume CS:Code, DS:Data, SS:Stack
Start:
        mov ax, Code
        mov DS, AX

        mov ax,03
        int 10h
KiirMenu:

		mov ah, 02h
		mov bh,0
		mov dh,10
		
		int 10h
		
		mov dl,10
		mov ah,02h
		int 21h
		mov dl,13
		mov ah,02h
		int 21h
		
		mov dx,offset ertek
        mov ah,09h
        int 21h
		
		mov dl,10
		mov ah,02h
		int 21h
		mov dl,13
		mov ah,02h
		int 21h
		
		mov dx,offset ertek2
        mov ah,09h
        int 21h
				
		mov dl,10
		mov ah,02h
		int 21h
		mov dl,13
		mov ah,02h
		int 21h
		
		mov dx,offset menu1
        mov ah,09h
        int 21h
		
		mov dl,10
		mov ah,02h
		int 21h
		mov dl,13
		mov ah,02h
		int 21h
		
		mov dx,offset menu2
        mov ah,09h
        int 21h
		
		mov dl,10
		mov ah,02h
		int 21h
		mov dl,13
		mov ah,02h
		int 21h
		
		
		mov dx,offset menu3
        mov ah,09h
        int 21h
		
		jmp MenuValaszt
JumpMeu:
		jmp KiirMenu
MenuValaszt:

		mov ah,00
		int 16h

        cmp di, 0
        jnz SiNullaCheck

        cmp si, 0
        jnz DiNullaCheck

SiNullaCheck:
        cmp si, 0
        jnz MindkettoNulla
DiNullaCheck:
        cmp di, 0
        jnz MindkettoNulla

		cmp al,27
		jz JumpHelper
		
		cmp al, '1'
		jz ElsoErtek
		
		cmp al, '2'
		jz JumpHelper3



        jmp HibaJump

MindkettoNulla:
    jmp JumpHelper

HibaJump:
        mov dl,10
		mov ah,02h
		int 21h
		mov dl,13
		mov ah,02h
		int 21h

        mov dx, offset hiba
        mov ah, 09h
        int 21h

        jmp MenuValaszt
		
ElsoErtek:
		mov di, offset ertek
BevitelElso:

		mov ah,00
		mov al,02
		int 10h
		
		mov dx,offset elsoszam
        mov ah,09h
        int 21h
		
		mov dl,10
		mov ah,02h
		int 21h
		mov dl,13
		mov ah,02h
		int 21h
		
        xor ax,ax
        int 16h

        mov bx,ax
        mov ax,03
        int 10h
        mov ax,bx

        cmp al,27
        jz JumpMeu

        mov cx,10
        mov ah,"0"
		
		jmp Vizsgelso

Vizsgelso:
        cmp al,ah
        jz Tarolelso
        inc ah
        loop Vizsgelso

        mov ah,02h
        mov bh,0
        mov dh,10
        mov dl,0
        int 10h

        mov dx,offset hiba
        mov ah,9
        int 21h

        jmp Bevitelelso
JumpHelper3:
		jmp MasodikErtek
JumpHelper:
		jmp Program_Vege
JumpHelper2:
		jmp KiirMenu
Tarolelso:
        mov [di],al
        inc di
        mov al,"$"
        mov [di],al

        mov ah,02h
        mov bh,0
        mov dh,5
        mov dl,28
        int 10h

        mov dx, offset ertek
        mov ah,9
        int 21h

        mov ax, offset ertek
        add ax,4
        cmp ax,di
        jnz Bevitelelso

        mov ah,02h
        mov bh,0
        mov dh,7
        mov dl,0
        int 10h
		
        mov ah,00
	    mov al,02
	    int 10h
		
	    jmp KiirMenu
MasodikErtek:
	    mov si, offset ertek2
BevitelMasodik:

	    mov ah,00
	    mov al,02
	    int 10h
		
	    mov dx,offset masodikszam
        mov ah,09h
        int 21h
		
        mov dl,10
        mov ah,02h
        int 21h
        mov dl,13
        mov ah,02h
        int 21h
		
        xor ax,ax
        int 16h

        mov bx,ax
        mov ax,03
        int 10h
        mov ax,bx

        cmp al,27
        jz JumpHelper2

        mov cx,10
        mov ah,"0"
Vizsgmasodik:
        cmp al,ah
        jz Tarolmasodik
        inc ah
        loop Vizsgmasodik

        mov ah,02h
        mov bh,0
        mov dh,10
        mov dl,0
        int 10h

        mov dx,offset hiba
        mov ah,9
        int 21h

        jmp Bevitelmasodik

Tarolmasodik:
        mov [si],al
        inc si
        mov al,"$"
        mov [si],al

        mov ah,02h
        mov bh,0
        mov dh,5
        mov dl,28
        int 10h

        mov dx, offset ertek2
        mov ah,9
        int 21h

        mov ax, offset ertek2
        add ax,4
        cmp ax,si
        jnz Bevitelmasodik

        mov ah,02h
        mov bh,0
        mov dh,7
        mov dl,0
        int 10h

        mov ah,00
	    mov al,02
	    int 10h
		
	    jmp JumpHelper2
Program_Vege:
        mov ax,4c00h
        int 21h
elsoszam:
	db "Adja meg az elso szamot $"
masodikszam:
	db "Adja meg a masodik szamot $"
menu1:
	db "1 elso szam $"
menu2:
	db "2 masodik szam $"
menu3:
	db "3 ESC $"
ertek:
        db "****$"
ertek2:
		db "****$"

hiba:
        db "Nem megengedett karakter!$"

uzenet:
        db "Vege a bevitelnek!$"

Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

        End Start
