;==========================================================================
;Név:
;Neptun kód:
;Dátum:
;
;==========================================================================
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
;Feladat_1:
;==========================================================================
;1. feledat: 
; Parancssori paraméter feldolgozás
; Olvasson be parancssori paraméterként egy számot az alábbi formában:
; Használja ezt a formátumot: "zh.exe -19"
; A paraméter egyetlen szám 00 és 99 között! 0 és 9 között a számokat 00 és 09 
; módon adjuk meg.
; A fölösleges szóközöket nem kell lekezelni!!!!! Csak egy szóköz jelzi, hogy paraméter.
; A megadott paraméter egy színkód lesz, ennek 1/10-ed része pedig a kezdõsebesség!
;
; Ha nincs paraméter megadva, akkor a default értékadás fusson le! Ha nem '-' a
; szóköz utáni karakter, akkor vegyük úgy, hogy nincs paraméter megadva!
;
; SI regiszteren keresztül számként adja tovább a következõ feladatnak a
; színkódot és a kezdõsebességet!
;
;==========================================================================
	mov	ax, 3
	int	10h
;**************************************************************************
;Ide írja a megfelelõ programrészt az itt található kód felhasználásával!
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
	;al-ben az érték
	
	mov cl, al
	
	mov bl, 10
	div bl
	
	mov ch, al
	
	mov si, cx
	
	jmp Init

Default:
	mov	cl, 60 ; színkód
	mov	ch, 6 ; kezdõsebesség
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
; Ferdehajítás VGA (320x200px, 8bit) módban 
; 0,0 koordinátáról indulva rajzolja ki t=0-tól kezdve t=20 ideig a golyó 
; (egyetlen pixel) röppályáját! A pixel szine és V0 kezdõsebesség az elõzõ
; feladatban megadott érték legyen (SI-ben)!
; videómemória címének képzése: y*320+x
; Sy = (t^2)/2
; Sx = V0 * t
; Verem: idõ (iteráció, egyesével növekszik, NEM KELL HOZZÁ BIOS ÓRA!)
; DI: labda pozíciója
;**************************************************************************
;VGA mód
	mov	ax, 13h
	int	10h	
	mov	ax, 0a000h
	mov	es, ax
	
;kezdõ koordináták
	mov	cl,0 ;sor
	mov	ch,0 ;oszlop
	mov	di,cx

;"idõ" a veremben (t0)	
	mov	ax, 1
	push ax
;**************************************************************************
;Ide írja a megfelelõ programrészt!
	
	Rajz:
		mov dx, cx
		xor dh, dh
		mov ax, 320
		mul dx ;sorpix -> ax-be
		
		xor bx, bx
		mov bl, ch
		add ax, bx
		
		mov di, ax
		
		mov bx, si ;l-ben a szín
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
; Irassa ki a BL regiszter tartalmat HEXADECIMÁLIS formában.
; Bármely értékre mûködnie kell! Tetszõleges értéket feltételezve, pl.: 
;	- 0 esetén 	00 
;	- 15 esetén	0F
;	- 16 esetén	10
;	- 255 esetén 	FF
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
	
	mov	bl, 061  ; teszt, bármire mûködnie kell!
	
; --------------------------------------------------------------------------
; Ide írja a megfelelõ programrészt!
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
; Várakozás billentyû leütésre
	xor	ax, ax
	int	16h
	
Feladat_4:
;------------------------------------------------------------------------
; 4/a. Feladat:
;
; A program az elõre megadott szövegrõl ('szo1-6' cimke) döntse el, hogy 
; palindrom vagy sem! Kikötés, hogy bármilyen szóra nézve jó választ kell 
; adnia! Amennyiben a szó palindrom kiírja, hogy "Palindrom" egyébként
; pedig kiírja, hogy "Nem palindrom".
; Írja ki a hat példaszót és a palindrom vizsgálat eredményét intelligens módon.
;
; 4/b. Feladat (Szorgalmi feladat)
;
; Kérjen be a billenytûzetrõl egy karaktersorozatot, tárolja a memóriában,
; 'Enter' billenytû legyen a karakter bekérés vége. 
; Döntse el a bevitt szóról, hogy palindrom vagy sem. Érdemes a 4/a feladatot
; subrutinként megírni. CALL/RET és a vizsgálandó cimke offset címét érdemes 
; egy kiválasztott regiszterben átadni a vizsgálathoz.  
;-------------------------------------------------------------------------

	mov	ax, 03h
	int	10h

	mov	dx, offset feladat4
	mov	ah, 09h
	int	21h

;-------------------------------------------------------------------------
; Ide írja a megfelelõ programrészt!
	
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
	
; Idáig
; ------------------------------------------------------------------------
	; Karakter beolvasas
	xor	ax, ax
	int	16h

;-------------------------------------------------------------------------
; 5/a. Feladat:
;
; Valósítson megy egy tipikus toLowerCase() eljárást. Az elõre megadott 
; szöveget ('szoveg' string) alakítsa át csupa kisbetûs mondattá, amit
; írjon is ki a képernyõre! Beégetett megoldás nem elfogadható, tehát a 
; szöveg megváltoztatása esetén is mûködnie kell!
;
; A jó eredmény:
;
;	jottomre ot nap multan szamitsatok! pirkadatkor, negykezlab.
; 
; 5/b. Feladat:
; 
; Valósítson megy egy tipikus toUpperCase() eljárást.
;
;-------------------------------------------------------------------------

	mov	ax, 03h
	int	10h

	mov	dx, offset feladat5
	mov	ah, 09h
	int	21h

;-------------------------------------------------------------------------
; Ide írja a megfelelõ programrészt!
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
; Várakozás billentyû leütésre
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

