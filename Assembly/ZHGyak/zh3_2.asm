;==========================================================================
;N�v: Horváth Imre Sándor
;Neptun k�d: UJYA04
;D�tum: 2023.11.24.
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
;Karakteres �zemm�dban rajzoljon egy rombuszt.
;A rombusz egyik cs�csa legyen a 10,10 koordin�t�n.
;
;A rombusz m�rete �s elhelyezked�se az al�bbi v�zlatnak megfelel� legyen! 
;
;    x
;   x x
;  x   x
; x     x
;x       x
; x     x
;  x   x
;   x x
;    x
;
;
;==========================================================================

	mov	dx, offset feladat1
	mov	ah,9
	int	21h
;**************************************************************************
;Ide �rja a megfelel� programr�szt!


	mov	ah, 02h
	mov	bh, 0
	mov	dl, 10		
	mov	dh, 10		
	int	10h

	push dx

	mov cx, 5

Oldal1:

	mov dx, 'x'
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

mov cx, 5

Oldal2:

	mov dx, 'x'
	mov ah, 02h
	int 21h

	pop dx
	dec dl
	inc dh
	int 10h
	push dx

	loop Oldal2

pop dx
inc dl
dec dh
int 10h
push dx

mov cx, 5

Oldal3:

	mov dx, 'x'
	mov ah, 02h
	int 21h

	pop dx
	dec dl
	dec dh
	int 10h
	push dx

	loop Oldal3

pop dx
inc dl
inc dh
int 10h
push dx

mov cx, 5

Oldal4:

	mov dx, 'x'
	mov ah, 02h
	int 21h

	pop dx
	inc dl
	dec dh
	int 10h
	push dx

	loop Oldal4


;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h
;==========================================================================
;2. feledat: 
;D�ntse el a megnyomott bilenty�r�l, hogy sz�mot, vagy bet� karaktert
;"vitt" be! A ciklusb�l "ESC" billenty� le�t�s�vel lehet kil�pni.
;Haszn�lja a program el�re meg�rt �zeneteit!
;==========================================================================
	mov	ah, 02h
	mov	bh, 0
	mov	dl, 0		;DL:X koordinata
	mov	dh, 15		;DH:Y koordinata
	int	10h

	mov	dx, offset feladat2
	mov	ah, 9
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
	jz Feladat2_Vege
;**************************************************************************
;Ide �rja a megfelel� programr�szt!

Beker:
	xor ax, ax
	int 16h

	cmp al, 27
	jz Feladat2_Vege

	cmp al, '0'
	jl NemSzam

	cmp al, '9'
	jg NemSzam

	jmp EzSzam

NemSzam:
	mov dx, offset uzenetnemszam
	mov ah, 09h
	int 21h

	jmp Beker

EzSzam:
	mov dx, offset uzenetszam
	mov ah, 09h
	int 21h

	jmp Beker

;Eddig
;**************************************************************************
Feladat2_Vege:
;==========================================================================
;3. feledat: 
;Karakteres �zemm�dban �rja ki a k�perny�re SI:DI �rt�k�t bin�ris form�ban!
;(Haszn�lja a balra rot�l� (RCL) utas�t�st, amely a Carry bitet �ll�tja!)
;==========================================================================
	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,19		;DH:Y koordinata
	int	10h

	mov	dx, offset feladat3
	mov	ah,9
	int	21h

	mov	ah, 02h
	mov	bh, 0
	mov	dl,0		;DL:X koordinata
	mov	dh,21		;DH:Y koordinata
	int	10h

	mov	si, 682
	mov	di, 682
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

	jmp KoviBinaris

Egyes:
	mov dl, '1'
	mov ah, 02h
	int 21h

	dec cx

	cmp cx, 0
	jz KoviBinaris

	jmp SiBinaris

KoviBinaris:
	mov dl, ' '
	mov ah, 02h
	int 21h

	mov dl, ':'
	mov ah, 02h
	int 21h

	mov dl, ' '
	mov ah, 02h
	int 21h

	mov bx, di
	mov cx, 16

DiBinaris:
	rcl bx, 1
	jc Egyes2

	mov dl, '0'
	mov ah, 02h
	int 21h

	loop DiBinaris

	jmp Feladat3_Vege

Egyes2:
	mov dl, '1'
	mov ah, 02h
	int 21h

	dec cx

	cmp cx, 0
	jz Feladat3_Vege

	jmp DiBinaris


Feladat3_Vege:

;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h

	mov ax,3
	int 10h

;==========================================================================
;5. feledat: 
;Karakteres �zemm�dban �rja ki a "Indul a g�r�g aludni!" uzenetet!
;Haszn�lja a megl�v� "uzenet5" sztringet!
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

Elore:
	mov ax, [di]

	cmp al, 'I'
	jz Vissza

	inc di

	jmp Elore

Vissza:
	mov dx, [di]
	mov ah, 02h
	int 21h

	cmp dl, '!'
	jz Feladat5_vege

	dec di

	jmp Vissza

Feladat5_vege:


;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h
;==========================================================================
;6. feledat: 
;Sz�m�tsa ki a "muvelet1" sztringben megadott oszt�st.
;A k�t sz�jegyet elv�laszt� "/" szimb�lumot nem kell feldolgozni!
;A oszt�s eredm�ny�t �s marad�k�t decim�lis form�ban �rja ki!
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

	div bl
	mov cl, ah

	mov dl, al
	add dl, '0'
	mov ah, 02h
	int 21h

	mov dl, ','
	mov ah, 02h
	int 21h

	mov dl, cl
	add dl, '0'
	mov ah, 02h
	int 21h


;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h

Program_Vege:
	mov	ax, 4c00h
	int	21h

uzenetszam	db	"Szamjegy lett leutve!    $"
uzenetnemszam	db	"Nem szamjegy vagy betu lett leutve!$"
uzenet5		db	"!indula gorog a ludnI"
muvelet1	db	"8/5"
	
feladat1	db	"Elso feladat: rombusz.$" 
feladat2	db	"Masodik feladat: szamjegy bevitele.(ESC=kilepes)$" 
feladat3	db	"Harmadik feladat: SI erteke decimalisan.$" 
feladat5	db	"Otodik feladat: uzenet kiiras.$" 
feladat6	db	"Hatodik feladat: szamolas.$" 

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

