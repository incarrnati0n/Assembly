;==========================================================================
;Nev: 
;Neptun kod: 
;Datum: 
;
;==========================================================================
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	ds, ax

;==========================================================================
; 1. feladat:
; "bl" regiszterben allitson be egy erteket, majd irja ki binarisan, hexaban
; es decimalisan a kepernyore.
;
; binaris help: RCL <regiszter>, 1 - Kilepo-belepo bit a Carry Flag-ben van
; hexa help: AND <regiszter>, 00001111b - Maszkolas (ket hexa szamjegy van!)
; decimalis help: DIV <regiszter> - Osztas 10 megfelelo hatvanyaival
;
; Helyes bin�ris �s hexa megold�s eset�n sikeres a beugr�!
; Egy pontot abban az esetben �r ha a decim�lis is muk�dik!
;==========================================================================
	mov 	ax, 3
	int 	10h

	mov	dx, offset feladat1
	mov	ah, 9
	int	21h

	xor	ax,ax
	int	16h

	mov 	ax, 3
	int 	10h

	mov	bl, 127 ; ezt az erteket kell kiirni kulonbozo szamrendszerekben
	            ; teszteles szempontjabol megvaltoztathato, de irjatok vissza
	
;**************************************************************************
;Ide irja a megfelelo programreszt!
	xor ax, ax
	xor cx, cx
	xor dx, dx

	mov cl, 8

BlBinaris:
	rcl bl, 1
	jc Egyes

	mov dl, '0'
	mov ah, 02h
	int 21h

	loop BlBinaris

	jmp Feladat1_vege


Egyes:
	mov dl, '1'
	mov ah, 02h
	int 21h

	dec cl

	cmp cl, 0
	jz Feladat1_vege

	jmp BlBinaris

;Eddig
;**************************************************************************
Feladat1_vege:
	xor	ax,ax
	int	16h
;==========================================================================
; 2. feladat:
; Hasonlitsa ossze a string1 es string2 karaktersorozatot a memoriaban.
; Ne legyen case sensitiv, tehat "a" (97) es "A" (65) egyforma karakter.
; Irja ki, hogy "egyforma" vagy "nem egyforma" a ket karaktersorozat.
; A karaktersorozatot a cl regiszterben megadott karakterszamig ellenorizze!
;==========================================================================
	mov 	ax, 3
	int 	10h

	mov	dx, offset feladat2
	mov	ah, 9
	int	21h

	xor	ax,ax
	int	16h

	mov 	ax, 3
	int 	10h

	mov	cl, 9 ; 8-ig egyforma, 9-tol nem egyforma az alabbi peldaban
; zh javitas folyaman a string1 es string2 meg fog valtozni, csak dinamikus
; megoldas az elfogadhato!

;**************************************************************************
;Ide irja a megfelelo programreszt!

;string1			db	"asdFghjKa"
;string2			db	"aSdfgHjkb"

	mov di, offset string1
	mov si, offset string2
	
Hasonlit:
	mov bl, [di]
	mov al, [si]
	
	cmp bl,"Z"
	jbe Masik
	
	sub bl, 32
	
Masik:
	
	cmp al,"Z"
	jbe Tovabb
	
	sub al, 32

Tovabb:

	cmp bl,al
	jnz Rossz
	
	inc di
	inc si
	
	loop Hasonlit
	
	mov dx, offset egyforma
	mov ah,09h
	int 21h
	
	
	jmp Feladat2_Vege
	
Rossz:
	mov dx, offset nemegyforma
	mov ah,09h
	int 21h



;Eddig
;**************************************************************************
Feladat2_Vege:
	xor	ax,ax
	int	16h
;==========================================================================
; 3. feladat:
; Kerjen be billenytuzetrol 2-szer 5 karaktert. Majd hasonlitsa ossze, hogy
; a ket karaktersorozat egyforma vagy nem egyforma es az eredmenyt irja ki.
; Ebben a feladatban case sensitiv legyen az osszehasonlitas.
;
; A billentyu leuteseket irja ki a kepernyore, segitve a felhasznalot.
;
; Esetleg felhasznalhato egy masik feladat megoldasa itt ("kodfosas")?
;==========================================================================
	mov 	ax, 3
	int 	10h

	mov	dx, offset feladat3
	mov	ah, 9
	int	21h

	xor	ax,ax
	int	16h

	mov 	ax, 3
	int 	10h
;**************************************************************************
;Ide irja a megfelelo programreszt!










;Eddig
;**************************************************************************
Feladat3_Vege:
	xor	ax,ax
	int	16h
;==========================================================================
; 4. feladat
; Rajzoljon ki a karakteres kepernyo kozepere (25 sor, 80 oszlop) egy 5*5-os 
; negyzetet. (latvanyra nem fog negyzetnek kinezni ;) )
; Haszn�ljon loop ciklust a megold�shoz, karakterenkent rakja ki a "*"-okat!
;==========================================================================
	mov 	ax, 3
	int 	10h

	mov	dx, offset feladat4
	mov	ah, 9
	int	21h

	xor	ax,ax
	int	16h


	mov 	ax, 3
	int 	10h

;**************************************************************************
;Ide irja a megfelelo programreszt!

	xor dx, dx
	xor ax, ax
	xor bx, bx
	xor cx, cx

	mov ah, 02h
	mov bh, 0
	mov dl, 40
	mov dh, 10
	int 10h
	push dx

	mov cx, 5

Oldal1:
	mov dx, '*'
	mov ah, 02h
	int 21h

	pop dx
	inc dl
	int 10h
	push dx

	loop Oldal1

pop dx
dec dl
int 10h
push dx

mov cx, 5

Oldal2:
	mov dx, '*'
	mov ah, 02h
	int 21h

	pop dx
	inc dh
	int 10h
	push dx

	loop Oldal2

pop dx
dec dh
int 10h
push dx

mov cx, 5

Oldal3:
	mov dx, '*'
	mov ah, 02h
	int 21h

	pop dx
	dec dl
	int 10h
	push dx

	loop Oldal3


pop dx
inc dl
int 10h
push dx

mov cx, 5

Oldal4:
	mov dx, '*'
	mov ah, 02h
	int 21h

	pop dx
	dec dh
	int 10h
	push dx

	loop Oldal4

;Eddig
;**************************************************************************
Feladat4_Vege:
	xor	ax,ax
	int	16h
;==========================================================================
; 5. feladat:
; Szorozza �ssze a 11-et es az 5-ot. Az eredm�nyt mint ascii karakter irja ki
; a kepernyore (55 - "7")
; Ossza el a 225-ot 3-mal. Az eredmenyt mint ascii karakter irja ki a 
; kepernyore (75 - "K")
; Termeszetesen tilos a ket karakter szamolas nelkuli kiirasa, megvaltoztatom!
;==========================================================================
	mov 	ax, 3
	int 	10h

	mov	dx, offset feladat5
	mov	ah, 9
	int	21h

	xor	ax,ax
	int	16h

	mov 	ax, 3
	int 	10h

;**************************************************************************
;Ide irja a megfelelo programreszt!

	xor ax, ax
	xor bx, bx

Szorzas:
	mov al, 11
	mov bl, 5

	mul bl

	mov dl, al

	mov ah, 02h
	int 21h

Space:
	mov dl, ' '
	mov ah, 02h
	int 21h


Osztas:
	xor ax, ax
	xor bx, bx

	mov al, 225
	mov bl, 3

	div bl

	mov dl, al
	
	mov ah, 02h
	int 21h


;Eddig
;**************************************************************************
Feladat5_Vege:
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
	
feladat1		db	"Elso feladat: Szamrendszeres$" 
feladat2		db	"Masodik feladat: Karaktersorozatos$" 
feladat3		db	"Harmadik feladat: Billentyuzetes$" 
feladat4		db	"Negyedik feladat: Rajzolas$" 
feladat5		db	"Otodik feladat: Muvelet$" 

string1			db	"asdFghjKa"
string2			db	"aSdfgHjkB"

egyforma		db	"egyforma$"
nemegyforma		db	"nem egyforma$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

