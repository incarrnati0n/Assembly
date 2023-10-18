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

