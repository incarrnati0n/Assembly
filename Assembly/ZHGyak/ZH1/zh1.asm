;==========================================================================
; Processzorok utas�t�s szint� kezel�se
; Nappali
;
; N�v: 
; Neptun k�d: 
; D�tum: 
; 
;==========================================================================

Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

Feladat_1:
;===========================================================================
; 1. feladat:
;
; Hat�rozza meg a (4^N / 8) f�ggv�ny �rt�k�t, ahol az N egy a billenty�zetr�l 
; beolvasott pozit�v eg�sz sz�m, melynek �rt�kei csak az al�bbiak lehetnek:
;
; 		1, 2, 3
;
; A le�t�tt billenty�t be kell helyettes�teni az N hely�re, majd az eredm�nyt 
; ki kell �rni a kett�spont ut�n! 
; 
; pl: (4^3 / 8)  = eredm�ny 8:
; 1. feladat: f�ggv�ny eredmenye: 8
;
; Nem megengedett karakter eset�n �rja ki, az al�bbit: 
;  		"Hib�s karakter!"
; (Csak egyszer fusson le)
; Haszn�lja a program el�re meg�rt �zenet�t (hibas_karakter)!
;
; 15 perc, 0 vagy 1 pont
;===========================================================================
Torles:
	mov	ax, 03h
	int	10h

	mov	dx, offset feladat1
	mov	ah,9
	int	21h
	
	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor di, di
	xor si, si
; --------------------------------------------------------------------------
; Ide �rja a megfelel� programr�szt!

	jmp Bekeres

BekerHiba:
	mov dx, offset hibas_karakter
	mov ah, 09h
	int 21h

	jmp Feladat1_Vege

Bekeres:
	xor ax, ax
	int 16h

	cmp al, '1'
	jl BekerHiba

	cmp al, '3'
	jg BekerHiba

	sub al, '0'

	mov cl, al

	mov al, 1
	mov bl, 4

Szorzo:
	mul bl

	loop Szorzo

	mov cl, 8

	div cl

	mov bl, al
	add bl, '0'
	mov dl, bl

	mov ah, 02h
	int 21h

Feladat1_Vege:

; Eddig
; -------------------------------------------------------------------------- 
; V�rakoz�s billenty� le�t�sre
	xor	ax, ax
	int	16h
	
Feladat_2:
;===========================================================================
; 2. feladat:
;
; Sz�molja meg az al�bbi mondat szavait �s �rja ki a  k�perny�re:
;
;	"Az assembly nyelv nem keverendo ossze a gepi koddal!"
;
; Felt�telezz�k, hogy a magyar helyes�r�si szab�lyoknak megfelel�en a szavak 
; k�z�tt mindig 1 sz�k�z van!
; Haszn�lja a program el�re meg�rt �zenet�t (mondat)!
;
; 15 perc, 0 vagy 1 pont
;===========================================================================
	mov	ax, 03h
	int	10h

	mov	ah,9
	mov	dx, offset feladat2
	int	21h	

	mov     dh, 2
	mov     dl, 5
	xor     bx, bx
	mov     ah, 02
	int     10h 
	
	mov	ah,9
	mov	dx, offset mondat
	int	21h

	mov     dh, 3
	mov     dl, 5
	xor     bx, bx
	mov     ah, 02
	int     10h 
	
	mov	ah,9
	mov	dx, offset feladat2_1
	int	21h
	
	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor di, di
	xor si, si
	

; --------------------------------------------------------------------------
; Ide �rja a megfelel� programr�szt!

	mov di, offset mondat
	mov bl, 1

Iterator:
	mov al, [di]

	cmp al, ' '
	jz Plusz1

	cmp al, '$'
	jz Feladat2_Vege

	inc di

	jmp Iterator

Plusz1:
	inc bl
	inc di
	jmp Iterator

Feladat2_Vege:
	mov dl, bl
	add dl, '0'
	mov ah, 02h
	int 21h


; Eddig
; --------------------------------------------------------------------------
; V�rakoz�s billenty� le�t�sre
	xor ax, ax
	int 16h
	

Feladat_3:
;===========================================================================
; 3. feladat:
; D�ntse el a megnyomott bilenty�r�l, hogy sz�mot, vagy egy�b karaktert
; "vitt" be! A ciklusb�l CSAK AZ "ESC" billenty� le�t�s�vel lehet kil�pni.
; Haszn�lja a program el�re meg�rt �zeneteit (uzenetszam, uzenetnemszam)!
;
; 15 perc, 0 vagy 1 pont
;===========================================================================
	mov	ax, 03h
	int	10h
	
	mov	ah,9
	mov	dx, offset feladat3
	int	21h	

	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor di, di
	xor si, si
	
; --------------------------------------------------------------------------
; Ide �rja a megfelel� programr�szt!

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


Feladat3_Vege:

; Eddig
; --------------------------------------------------------------------------
; V�rakoz�s billenty� le�t�sre
	xor ax, ax
	int 16h	
	
	
	mov ax, 03h
	int 10h
	
Program_Vege:
	mov	ax, 4c00h
	int	21h


feladat1	db	"1. feladat: (4^N / 8) fuggveny eredmenye: $" 
hibas_karakter	db	"Hibas karakter!$"


feladat2	db	"2. feladat: Szavak szama az alabbi mondatban:$"
feladat2_1	db	"Szavak szama: $"
mondat		db	"Az assembly nyelv nem keverendo ossze a gepi koddal!$"


feladat3	db	"3. feladat: Szam vagy nem szam: $"
uzenetszam	db	"Szamjegy lett leutve!    $"
uzenetnemszam	db	"Nem szamjegy lett leutve!$"


Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

