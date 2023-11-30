;==========================================================================
;N�v:
;Neptun k�d:
;D�tum:
;
;==========================================================================
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
;Feladat_1:
;==========================================================================
;1. feledat: 
; Parancssori param�ter feldolgoz�s
; Olvasson be parancssori param�terk�nt egy sz�mot az al�bbi form�ban:
; Haszn�lja ezt a form�tumot: "zh.exe -19"
; A param�ter egyetlen sz�m 00 �s 99 k�z�tt! 0 �s 9 k�z�tt a sz�mokat 00 �s 09 
; m�don adjuk meg.
; A f�l�sleges sz�k�z�ket nem kell lekezelni!!!!! Csak egy sz�k�z jelzi, hogy param�ter.
; A megadott param�ter egy sz�nk�d lesz, ennek 1/10-ed r�sze pedig a kezd�sebess�g!
;
; Ha nincs param�ter megadva, akkor a default �rt�kad�s fusson le! Ha nem '-' a
; sz�k�z ut�ni karakter, akkor vegy�k �gy, hogy nincs param�ter megadva!
;
; SI regiszteren kereszt�l sz�mk�nt adja tov�bb a k�vetkez� feladatnak a
; sz�nk�dot �s a kezd�sebess�get!
;
;==========================================================================
	mov	ax, 3
	int	10h
;**************************************************************************
;Ide �rja a megfelel� programr�szt az itt tal�lhat� k�d felhaszn�l�s�val!
	mov di, 82h
	
	mov al, [di]
	cmp al, '-'
	jnz Default
	
	inc di
	mov al, 10
	
	mov bl, [di]
	sub bl, '0'
	mul bl
	
	inc di
	
	mov bl, [di]
	sub bl, '0'
	
	add al, bl
	;al-ben az �rt�k
	
	mov cl, al
	
	mov bl, 10
	div bl
	
	mov ch, al
	
	mov si, cx
	
	jmp Init

Default:
	mov	cl, 60 ; sz�nk�d
	mov	ch, 6 ; kezd�sebess�g
	mov	si,cx
Init:
	mov	ax, Code
	mov	DS, AX

	mov	ah,9
	mov	dx, offset feladat1
	int	21h	
	
;Eddig
;**************************************************************************
	xor	ax, ax
	int	16h

;==========================================================================
;2. feledat: 
; Ferdehaj�t�s VGA (320x200px, 8bit) m�dban 
; 0,0 koordin�t�r�l indulva rajzolja ki t=0-t�l kezdve t=20 ideig a goly� 
; (egyetlen pixel) r�pp�ly�j�t! A pixel szine �s V0 kezd�sebess�g az el�z�
; feladatban megadott �rt�k legyen (SI-ben)!
; vide�mem�ria c�m�nek k�pz�se: y*320+x
; Sy = (t^2)/2
; Sx = V0 * t
; Verem: id� (iter�ci�, egyes�vel n�vekszik, NEM KELL HOZZ� BIOS �RA!)
; DI: labda poz�ci�ja
;**************************************************************************
;VGA m�d
	mov	ax, 13h
	int	10h	
	mov	ax, 0a000h
	mov	es, ax
	
;kezd� koordin�t�k
	mov	cl,0 ;sor
	mov	ch,0 ;oszlop
	mov	di,cx

;"id�" a veremben (t0)	
	mov	ax, 1
	push ax
;**************************************************************************
;Ide �rja a megfelel� programr�szt!
	
	Rajz:
		mov dx, cx
		xor dh, dh
		mov ax, 320
		mul dx ;sorpix -> ax-be
		
		xor bx, bx
		mov bl, ch
		add ax, bx
		
		mov di, ax
		
		mov bx, si ;l-ben a sz�n
		mov es:[di], bl
		
	KoordiSzamolas:
		pop ax ;t
		push ax
		;v*t
		mov bx, si ;h-ban -> v
		
		mul bh ;ax-ben a v*t azaz Sx
		mov ch, al ;oszlop kordi
		
		
		pop ax
		inc ax
		push ax
		dec ax
		
		;t^2/2
		mov bl, al
		mul bl
		shr ax, 1
		
		mov cl, al ;sor kordi
		
		mov di, cx
		
		pop ax
		push ax
		
		cmp al, 21
		jz Var
		jmp Rajz
		
;Eddig
;==========================================================================
Var:
	xor	ax,ax
	int	16h
	
	
Feladat_3:
;===========================================================================
; 3. feladat:
; Irassa ki a BL regiszter tartalmat HEXADECIM�LIS form�ban.
; B�rmely �rt�kre m�k�dnie kell! Tetsz�leges �rt�ket felt�telezve, pl.: 
;	- 0 eset�n 	00 
;	- 15 eset�n	0F
;	- 16 eset�n	10
;	- 255 eset�n 	FF
;
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
	xor	di, di
	xor	si, si
	
	mov	bl, 061  ; teszt, b�rmire m�k�dnie kell!
	
; --------------------------------------------------------------------------
; Ide �rja a megfelel� programr�szt!
	mov	dx, offset enterr
	mov	ah, 09h
	int	21h

	mov al, bl
	and al, 11110000b
	mov cl, 4
	shr al, cl
	
	call hexakiiro
	
	mov al, bl
	and al, 00001111b
	call hexakiiro
	

; Eddig
; --------------------------------------------------------------------------
; V�rakoz�s billenty� le�t�sre
	xor	ax, ax
	int	16h
	
Feladat_4:
;------------------------------------------------------------------------
; 4/a. Feladat:
;
; A program az el�re megadott sz�vegr�l ('szo1-6' cimke) d�ntse el, hogy 
; palindrom vagy sem! Kik�t�s, hogy b�rmilyen sz�ra n�zve j� v�laszt kell 
; adnia! Amennyiben a sz� palindrom ki�rja, hogy "Palindrom" egy�bk�nt
; pedig ki�rja, hogy "Nem palindrom".
; �rja ki a hat p�ldasz�t �s a palindrom vizsg�lat eredm�ny�t intelligens m�don.
;
; 4/b. Feladat (Szorgalmi feladat)
;
; K�rjen be a billenyt�zetr�l egy karaktersorozatot, t�rolja a mem�ri�ban,
; 'Enter' billenyt� legyen a karakter bek�r�s v�ge. 
; D�ntse el a bevitt sz�r�l, hogy palindrom vagy sem. �rdemes a 4/a feladatot
; subrutink�nt meg�rni. CALL/RET �s a vizsg�land� cimke offset c�m�t �rdemes 
; egy kiv�lasztott regiszterben �tadni a vizsg�lathoz.  
;-------------------------------------------------------------------------

	mov	ax, 03h
	int	10h

	mov	dx, offset feladat4
	mov	ah, 09h
	int	21h

;-------------------------------------------------------------------------
; Ide �rja a megfelel� programr�szt!
	
	call EnterNyomo
	
	mov di, offset szo1
	mov si, offset szo1
	call PalindromFv
	
	call EnterNyomo
	
	mov di, offset szo2
	mov si, offset szo2
	call PalindromFv
	
	call EnterNyomo
	
	mov di, offset szo3
	mov si, offset szo3
	call PalindromFv
	
	call EnterNyomo
	
	mov di, offset szo4
	mov si, offset szo4
	call PalindromFv
	
	call EnterNyomo
	
	mov di, offset szo5
	mov si, offset szo5
	call PalindromFv
	
	call EnterNyomo
	
	mov di, offset szo6
	mov si, offset szo6
	call PalindromFv
	
	
	;Szorgalmi:
	call EnterNyomo
	mov dx, offset PLSENTER
	mov ah, 9 
	int 21h
	
	call EnterNyomo
	mov di, offset customstring
	
	Bekero:
	xor ax, ax
	int 16h
	
	cmp al, 13
	jz BekeroVege
	
	mov [di], al
	inc di
	
	mov dl, al
	mov ah, 2 
	int 21h
	
	mov al, '$'
	mov [di], al
	
		jmp Bekero
	
BekeroVege:

	call EnterNyomo
	
	mov di, offset customstring
	mov si, offset customstring
	call PalindromFv
	
; Id�ig
; ------------------------------------------------------------------------
	; Karakter beolvasas
	xor	ax, ax
	int	16h

;-------------------------------------------------------------------------
; 5/a. Feladat:
;
; Val�s�tson megy egy tipikus toLowerCase() elj�r�st. Az el�re megadott 
; sz�veget ('szoveg' string) alak�tsa �t csupa kisbet�s mondatt�, amit
; �rjon is ki a k�perny�re! Be�getett megold�s nem elfogadhat�, teh�t a 
; sz�veg megv�ltoztat�sa eset�n is m�k�dnie kell!
;
; A j� eredm�ny:
;
;	jottomre ot nap multan szamitsatok! pirkadatkor, negykezlab.
; 
; 5/b. Feladat:
; 
; Val�s�tson megy egy tipikus toUpperCase() elj�r�st.
;
;-------------------------------------------------------------------------

	mov	ax, 03h
	int	10h

	mov	dx, offset feladat5
	mov	ah, 09h
	int	21h

;-------------------------------------------------------------------------
; Ide �rja a megfelel� programr�szt!
	mov	dx, offset enterr
	mov	ah, 09h
	int	21h
	
	
	mov di, offset szoveg
	
Printing:
	mov bl, [di]
	cmp bl, '$'
	jz caseSwEnd
	
	cmp bl, 64
	jg Lowere
	jmp Nemnagy
	
	Lowere:
	cmp bl, 91
	jl Lower
	
	Nemnagy:
	
	mov dl, bl
	mov ah, 2
	int 21h
	
	inc di
	
	jmp Printing
	
Lower:
	mov dl, bl
	add dl, 32
	mov ah, 2
	int 21h
	
	inc di
	
	jmp Printing

caseSwEnd:
	
	mov	dx, offset enterr
	mov	ah, 09h
	int	21h
	
	mov di, offset szoveg
	
Printing2:
	mov bl, [di]
	cmp bl, '$'
	jz caseSwEnd2
	
	cmp bl, 96
	jg Lowere2
	jmp Nemnagy2
	
	Lowere2:
	cmp bl, 123
	jl Lower2
	
	Nemnagy2:
	
	mov dl, bl
	mov ah, 2
	int 21h
	
	inc di
	
	jmp Printing2
	
Lower2:
	mov dl, bl
	sub dl, 32
	mov ah, 2
	int 21h
	
	inc di
	
	jmp Printing2

caseSwEnd2:
; Eddig
; --------------------------------------------------------------------------
; V�rakoz�s billenty� le�t�sre
	xor	ax, ax
	int	16h	
	
	
Program_Vege:
	mov	ax, 3
	int	10h
	
	pop	ax
	mov	ax, 4c00h
	int	21h

;stringek:
enterr: db 13,10, '$'
feladat1	db	"1. feladat, parancssori parameterek: $" 

feladat3	db	"3. feladat: HEXADECIMALIS konverzio$"

feladat4	db	"4. feladat: A szo palindrom? $"
szo1		db	"apa$"
szo2		db	"anna$"
szo3		db	"gardanadrag$"
szo4		db	"keretkarakterek$"
szo5		db	"assembly$"
szo6		db	"trollface$"
		
palindrom	db	"Palindrom$"
nem_palindrom 	db	"Nem palindrom$"

feladat5	db	"5. feladat: A mondat csupa kis (nagy) betuvel: $"
szoveg		db	"Jottomre ot nap multan szamitsatok! Pirkadatkor, NEGYKEZLAB.$"
customstring: db "$"
PLSENTER: db "PLs enter a string, to decide if it's palindrom$"

PalindromFv:
	xor bx, bx
Dollar:
	mov al, [si]
	cmp al, '$'
	jz SzoVege
	
	inc si
	inc bl
	
	jmp Dollar
	
SzoVege:
	xor cx, cx
	shr bl, 1
	dec si
	mov cl, bl
	CmpLoop:
		mov al, [di]
		mov bl, [si]
		cmp al, bl
		jnz NemPali
		
		inc di
		dec si
		
	loop CmpLoop
	
	mov dx, offset palindrom
	mov ah, 9
	int 21h
	
	jmp retto
	
NemPali:
	mov dx, offset nem_palindrom
	mov ah, 9
	int 21h
	retto:
ret

EnterNyomo:
	mov dx, offset enterr
	mov ah, 9
	int 21h
ret

hexakiiro:
	cmp al, 9
	jg betukiiro
	
	mov dl, '0'
	
	tovabb:
	add dl, al
	mov ah, 2
	int 21h
	
	ret
betukiiro:
	mov dl, 55
	jmp tovabb
	
	
	
Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

