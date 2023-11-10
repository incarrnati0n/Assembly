Code Segment
    assume CS:Code, DS:Data, SS:Stack

Szorzo=10000

Start:
    mov ax, Code
    mov ds, ax

    mov di, offset Eredmeny
    mov ax, Szorzo
    mov [di], ax ;sorozat elso eleme

    mov cx, 2500 ;ciklus 2500x fusson
    mov si, 3 ;sorozat masodik elemenek nevezoje

Szamol:
    mov ax, Szorzo
    xor dx, dx ;16 bites szam osztasa ne feletkezzunk meg a dx torleserol mert ide kerul a maradek
    div si
    sub [di], ax
    add si, 2

;DIV (16 bites operandus)
;DX:AX 32 bites osztandót elosztja az operandussal
;Eredmény: DX:maradék – AX:hányados
;INT0 (hiba) – ha a hányados nagyobb, mint 16 bit

;DIV (8 bites operandus)
;AX 16 bites osztandót elosztja az operandussal
;Eredmény: AH:maradék – AL:hányados
;INT0 (hiba) – ha a hányados nagyobb, mint 8 bit


    mov ax, Szorzo
    xor dx, dx 
    div si
    sub [di], ax
    add si, 2
    
    loop Szamol

    mov ax, [di]
    mov cl, 2
    shl ax, cl

    xor dx, dx
    mov bx, 10000
    div bx ;tizezresek szam eredmeny AX-ben (AL-ben), maradek DX-ben

    push dx
    call Kiir ;Kiir szubrutin elhelyezese celszeru a program_vege utani Code szegmens reszben

    mov al, '.'
    sub al, 48 ;csalunk, hogy a Kiir szubrutint tudjuk használni. Természetesen gyorsabb szubrutin hívás nélkül!

    call Kiir

    pop ax
    xor dx, dx
    mov bx, 1000
    div bx ;1000-esek kiirasa

    push dx

    call Kiir

    pop ax
    xor dx, dx
    mov bx, 100
    div bx ;100-asok kiirasa

    push dx

    call Kiir

    pop ax
    xor dx, dx
    mov bx, 10
    div bx ;10-esek kiirasa

    push dx

    call Kiir

    pop ax

    call Kiir


;Eredmeny:     db "xx"


Eredmeny=$+1

Program_Vege:
    mov ax, 4c00h
    int 21h

Kiir:
    mov dl, al
    add dl, 48
    mov ah, 02h
    int 21h
    ret

Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start