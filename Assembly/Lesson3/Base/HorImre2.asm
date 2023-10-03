
Code Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov ds, ax

    mov di, offset ertek

    mov ax, 03 ;képernyőtörlés
    int 10h 

Bevitel:
    mov dx, offset menupont
    mov ah, 09
    int 21h

    xor ax, ax
    int 16h ;várakozás egy billenytű leütésére

    mov bx, ax ;ax elmentése
    mov ax, 03
    int 10h
    mov ax, bx ;ax visszaállítása

    cmp al, 27 ;ESC billentyű lenyomását vizsgáljuk
    jz Program_vege ;igaz feltétel esetén kiugrunk a programból, 
    ;hamis esetén folytatódik tovább

    mov cx, 10
    mov ah, '0'

Vizsg: 
    cmp al, ah
    jz Tarol
    inc ah
    loop Vizsg

    ;kurzor pozíció
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 0
    int 10h

    ;hiba (nem számbillentyű lenyomása) kiiratása
    mov dx, offset hiba
    mov ah, 09
    int 21h

    jmp Bevitel

Tarol:
    ;di regiszter tartalma az ertek cimke offset memória címe
    mov [di], al ;kiírjuk a leütött billentyű ASCII értékét a memóriába
    inc di ;növeljük az offset címet
    mov al, '$'
    mov [di], al ;kiírunk egy karaktersorozatot lezáró vezérlő karaktert('$')
    
    ;kurzor pozicionálás
    mov ah, 02h
    mov bh, 0
    mov dh, 5
    mov dl, 28
    int 10h

    ;szám kiírása
    mov dx, offset ertek
    mov ah, 09
    int 21h

    mov ax, offset ertek
    add ax, 4
    cmp ax, di
    jnz Bevitel
    ;még nem ütöttünk le 4 numerikus billentyűt, kezdőcím + 4 nagyobb mint
    ;az utolsó tárolt karakter címe

    ;egyébként tovább fut a program

    ;kurzor pozicionálás
    mov ah, 02h
    mov bh, 0
    mov dh, 7
    mov dl, 0
    int 10h

    ;vége kiírása
    mov dx, offset uzenet
    mov ah, 09h
    int 21h

Program_vege:
    mov ax, 4c00h
    int 21h

ertek:
    db '****$'

hiba: 
    db 'Nem megengedett karakter!$'

uzenet:
    db 'Vege a bevitelnek$'
menupont:
    db '1: Elso szam bevitele, 2: Szam bevitele, ESC: kilepes$'

Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

    End Start