;==========================================================================
;Név:
;Neptun kód:
;Dátum:
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
;Karakteres üzemmódban rajzoljon egy rombuszt.
;A rombusz egyik csúcsa legyen a 10,10 koordinátán.
;
;A rombusz mérete és elhelyezkedése az alábbi vázlatnak megfelelõ legyen! 
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
;Ide írja a megfelelõ programrészt!


;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h
;==========================================================================
;2. feledat: 
;Döntse el a megnyomott bilentyûrõl, hogy számot, vagy betü karaktert
;"vitt" be! A ciklusból "ESC" billentyû leütésével lehet kilépni.
;Használja a program elõre megírt üzeneteit!
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
;Ide írja a megfelelõ programrészt!


;Eddig
;**************************************************************************
Feladat2_Vege:
;==========================================================================
;3. feledat: 
;Karakteres üzemmódban írja ki a képernyõre SI:DI értékét bináris formában!
;(Használhatja a balra rotáló (RCL) utasítást, amely a Carry bitet állítja!)
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
;Ide írja a megfelelõ programrészt!


;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h

	mov ax,3
	int 10h

;==========================================================================
;5. feledat: 
;Karakteres üzemmódban írja ki a "Indul a görög aludni!" uzenetet!
;Használja a meglévõ "uzenet5" sztringet!
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
;Ide írja a megfelelõ programrészt!


;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h
;==========================================================================
;6. feledat: 
;Számítsa ki a "muvelet1" sztringben megadott osztást.
;A két szájegyet elválasztó "/" szimbólumot nem kell feldolgozni!
;A osztás eredményét és maradékát decimális formában írja ki!
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
;Ide írja a megfelelõ programrészt!


;Eddig
;**************************************************************************
	xor	ax,ax
	int	16h

Program_Vege:
	mov	ax, 4c00h
	int	21h

uzenetszam	db	"Szamjegy lett leutve!    $"
uzenetnemszam	db	"Nem szamjegy vagy betü lett leutve!$"
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

