





;==========================================================================
;N�v:
;Neptun k�d:
;D�tum:
;
;==========================================================================
Code	Segment
	assume CS:Code, DS:Data, SS:Stack


Start:
	mov	ax, Code
	mov	DS, AX

	mov ax,3
	int 10h


;==========================================================================
;1. feledat: 
;Karakteres �zemm�dban rajzoljon egy der�ksz�g� h�romsz�get.
;A h�romsz�g egyik cs�csa legyen a 10,10 koordin�t�n.
;
;A h�romsz�g m�rete �s elhelyezked�se az al�bbi v�zlatnak megfelel� legyen! 
;x
;xx
;x x
;x  x
;x   x
;x    x
;x     x
;xxxxxxxx
;==========================================================================

	mov	dx, offset feladat1
	mov	ah,9
	int	21h
;**************************************************************************
;Ide �rja a megfelel� programr�szt!

	mov ah, 02h
	mov bh, 0
	mov dl, 10
	mov dh, 10
	int 10h
	push dx

	mov cx, 8
	Oldal1:
		mov dl, 'x'
		mov ah, 02
		int 21h

		pop dx
		inc dl
		inc dh
		int 10h
		push dx

		loop Oldal1

pop dx
dec dl
dec dh
int 10h
push dx

mov cx, 8

	Oldal2:
		mov dl, 'x'
		mov ah , 02h
		int 21h
		pop dx
		dec dl
		int 10h
		push dx
		loop Oldal2

pop dx
inc dl
int 10h
push dx
mov cx, 8

	Oldal3:
		mov dl, 'x'
		mov ah , 02h
		int 21h
		pop dx
		dec dh
		int 10h
		push dx
		loop Oldal3

;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h
;==========================================================================
;2. feledat: 
;Karakteres �zemm�dban �rja ki a k�perny�re SI �rt�k�t hexa form�ban!
;==========================================================================
	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,12		;DH:Y koordinata
	int	10h

	mov	dx, offset feladat2
	mov	ah,9
	int	21h

	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,14		;DH:Y koordinata
	int	10h

	mov	si,65534
;**************************************************************************
;Ide �rja a megfelel� programr�szt!




;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h
;==========================================================================
;3. feledat: 
;D�ntse el a megnyomott bilenty�r�l, hogy sz�mot, vagy egy�b karaktert
;"vitt" be! A ciklusb�l "ESC" billenty� le�t�s�vel lehet kil�pni.
;Haszn�lja a program el�re meg�rt �zeneteit!
;==========================================================================
	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,15		;DH:Y koordinata
	int	10h

	mov	dx, offset feladat3
	mov	ah,9
	int	21h

bevitel1:
	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,17		;DH:Y koordinata
	int	10h

;**************************************************************************
;Ide �rja a megfelel� programr�szt!

Beker:
	xor ax, ax
	int 16h

	cmp al, 27
	jz Feladat3_Vege

	cmp al, '0'
	jl NemSzam

	cmp al, '9'
	jg NemSzam

	jmp Szam

Szam:
	mov dx, offset uzenetszam
	mov ah, 09	
	int 21h

	jmp Beker

NemSzam:
	mov dx, offset uzenetnemszam
	mov ah, 09
	int 21h

	jmp Beker

;Eddig
;**************************************************************************
Feladat3_Vege:
;==========================================================================
;4. feledat: 
;Karakteres �zemm�dban �rja ki a k�perny�re SI �rt�k�t decim�lis form�ban!
;==========================================================================
	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,19		;DH:Y koordinata
	int	10h

	mov	dx, offset feladat4
	mov	ah,9
	int	21h

	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,21		;DH:Y koordinata
	int	10h

	mov	si,256
;**************************************************************************
;Ide �rja a megfelel� programr�szt!

	mov bx, si
	mov cx, 16

SiBinaris:
	rcl bx, 1
	jc Egyes

	mov dl, '0'
	mov ah, 02
	int 21h

	loop SiBinaris

	jmp Feladat4_vege

Egyes:
	mov dl, '1'
	mov ah, 02h
	int 21h

	dec cx
	cmp cx, 0
	jz Feladat4_vege

	jmp SiBinaris


Feladat4_vege:
;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h

	mov ax,3
	int 10h

;==========================================================================
;5. feledat: 
;Karakteres �zemm�dban �rja ki a "Indul a gorog aludni!" uzenetet!
;Haszn�lja a megl�v� "uzenet5" sztringet! Ne �rja ki az "x" karakter, 
;ami t�bbsz�r is lehet egym�s ut�n.
;==========================================================================
	mov	dx, offset feladat5
	mov	ah,9
	int	21h

	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,2		;DH:Y koordinata
	int	10h

;**************************************************************************
;Ide �rja a megfelel� programr�szt!

	mov di, offset uzenet5

Vegere:
	mov al, [di]

	cmp al, 'I'
	jz Vissza

	inc di
	jmp Vegere

Vissza:
	mov dl, [di]
	cmp dl, '!'
	jz Feladat5_vege

	cmp dl, 'x'
	jz Atugras

	mov ah, 02
	int 21h

	dec di
	jmp Vissza

Atugras:
	dec di

	jmp Vissza

Feladat5_vege:
	mov dl, '!'
	mov ah, 02
	int 21h


;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h
;==========================================================================
;6. feledat: 
;Sz�m�tsa ki a "muvelet1" sztringben megadott szorz�st.
;A k�t sz�jegyet elv�laszt� "*" szimb�lumot nem kell feldolgozni!
;A szorzat eredm�ny�nek megfelel� karaktert jelen�tse meg a k�perny�n.
;==========================================================================
	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,4		;DH:Y koordinata
	int	10h

	mov	dx, offset feladat6
	mov	ah,9
	int	21h

	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,6		;DH:Y koordinata
	int	10h

;**************************************************************************
;Ide �rja a megfelel� programr�szt!

	xor ax, ax
	xor bx, bx
	mov di, offset muvelet1
	mov al, [di]
	sub al, '0'

	inc di
	inc di

	mov bl, [di]
	sub bl, '0'

	mul bl

	mov dl, al
	mov ah, 02
	int 21h	

;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h

Program_Vege:
	mov	ax, 4c00h
	int	21h

uzenetszam	db	"Szamjegy lett leutve!    $"
uzenetnemszam	db	"Nem szamjegy lett leutve!$"
uzenet5		db	"x!xixnxdxuxxxxxlxax xgxxxxoxrxoxgxxx xax xlxuxdxxnxI"
muvelet1	db	"5*7"
	
feladat1	db	"Elso feladat: derekszogu haromszog.$" 
feladat2	db	"Masodik feladat: SI erteke binarisan.$" 
feladat3	db	"Harmadik feladat: szamjegy bevitele.(ESC=kilepes)$" 
feladat4	db	"Negyedik feladat: SI erteke decimalisan.$" 
feladat5	db	"Otodik feladat: uzenet kiiras.$" 
feladat6	db	"Hatodik feladat: szamolas.$" 

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

