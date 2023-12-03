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
	mov ah, 02h
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
	mov ah, 02h
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
	mov ah, 02h
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

	mov bx, si
	mov cx, 16

Binaris:
	rcl bx, 1
	jc Egyesek

	mov dx, '0'
	mov ah, 02h
	int 21h

	loop Binaris

	jmp Hexara0

Egyesek:	
	mov dl, '1'
	mov ah, 02h
	int 21h

	dec cx

	cmp cx, 0
	jz Hexara0

	jmp Binaris


Hexara0:
	mov ah, 02h
	mov bh, 0
	mov dl, 0
	mov dh, 16
	int 10h

Hexara:
	mov dx, si
	and dx, 1111000000000000b
	mov cl, 12
	shr dx, cl
	call HexaPrint

	mov dx, si
	and dx, 0000111100000000b
	mov cl, 8
	shr dx, cl
	call HexaPrint

	mov dx, si
	and dx, 0000000011110000b
	mov cl, 4
	shr dx, cl
	call HexaPrint

	mov dx, si
	and dx, 0000000000001111b
	call HexaPrint

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

	xor ah,ah
	int 16h
	cmp al,27
	jz Feladat3_Vege
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

NemSzam:
	mov dx, offset uzenetnemszam
	mov ah, 09h
	int 21h

	jmp Beker

Szam:
	mov dx, offset uzenetszam
	mov ah, 09h
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
	mov ah, 02h
	int 21h

	loop SiBinaris

	jmp Feladat4_Vege

Egyes:
	mov dl, '1'
	mov ah, 02h
	int 21h

	cmp cx, 0
	jz Feladat4_Vege

	dec cx

	jmp SiBinaris

Feladat4_Vege:

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
	mov bl, 0

Vegere:
	mov al, [di]

	cmp al, '$'
	jz Visszaallit

	inc di
	inc bl

	jmp Vegere

Visszaallit:
	dec di
	dec bl
	mov cl, bl
	jmp Vissza

Vissza:
	mov al, [di]

	cmp al, 'x'
	jz Atugor

	mov dl, al
	mov ah, 02h
	int 21h

	dec di

	loop Vissza

	jmp Feladat5_Vege

Atugor:
	dec di
	dec cl
	jmp Vissza

Feladat5_Vege:


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

	mov di, offset muvelet1

	mov al, [di]

	inc di
	inc di

	mov bl, [di]

	sub al, '0'
	sub bl, '0'

	mul bl

	;mov bl, 10
	
	;div bl

	;mov cl, ah

	mov dl, al
	;add dl, '0'
	mov ah, 02h
	int 21h

	;mov dl, cl
	;add dl, '0'
	;mov ah, 02h
	;int 21h



;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h

Program_Vege:
	mov	ax, 4c00h
	int	21h


Methods:
	HexaPrint:
		cmp dl, 9
		jg Betu

		add dl, '0'

		jmp Kiir

		Betu:
			add dl, 55
		Kiir:
			mov ah, 02h
			int 21h
	ret

uzenetszam	db	"Szamjegy lett leutve!    $"
uzenetnemszam	db	"Nem szamjegy lett leutve!$"
uzenet5		db	"x!xixnxdxuxxxxxlxax xgxxxxoxrxoxgxxx xax xlxuxdxxnxI$"
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

