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


	jmp Szam


NemSzam:
	mov dx, offset uzenetnemszam
	mov ah, 09
	int 21h

	jmp Beker


Szam:
	mov dx, offset uzenetszam
	mov ah, 09
	int 21h

	jmp Beker

;Eddig
;**************************************************************************
Feladat2_Vege:
;==========================================================================
;3. feledat: 
;Karakteres �zemm�dban �rja ki a k�perny�re SI:DI �rt�k�t bin�ris form�ban!
;(Haszn�lhatja a balra rot�l� (RCL) utas�t�st, amely a Carry bitet �ll�tja!)
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

