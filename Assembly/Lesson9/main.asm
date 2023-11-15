Code Segment
    assume CS:Code, DS:Data, SS:Stack
Start:
    mov ax, Code
    mov ds, ax


    mov dx, offset kezdoszoveg
    mov ah, 09h
    int 21h

    jmp Beker

Bekerhiba:
    mov dx, offset hibauzenet
    mov ah, 09h
    int 21h

Beker:

    xor ax, ax
    int 16h

    cmp al, 27
    jz Feladat1_vege

    cmp al, '1'
    jl Bekerhiba

    cmp al, '3'
    jg Bekerhiba

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


Feladat1_vege:

    xor ax, ax
    int 16h


Feladat2:

    mov ax, 03h
    int 10h

    mov dx, offset szavak
    mov ah, 09h
    int 21h

    xor dx, dx


    mov di, offset assembly
    mov bl, 1

Szamolas:
    mov al, [di]

    cmp al, "$"
    jz Feladat2_vege

    cmp al, " "
    jz Novelo

    inc di

    jmp Szamolas

Novelo:
    inc bl
    inc di

    jmp Szamolas



Feladat2_vege:
    add bl, '0'
    mov dl, bl
    mov ah, 02h
    int 21h

    xor ax, ax
    int 16h


Feladat3:

    mov ax, 03h
    int 10h

    mov dx, offset szamszoveg
    mov ah, 09
    int 21h

Bekeres:

    xor ax, ax
    int 16h

    cmp al, 27
    jz Feladat3_vege

    cmp al, '0'
    jl EzNemSzam

    cmp al, '9'
    jg EzNemSzam

    jmp EzSzam

EzNemSzam:
    mov dx, offset uzenetnemszam
    mov ah, 09
    int 21h

    jmp Bekeres


EzSzam:
    mov dx, offset uzenetszam
    mov ah, 09
    int 21h

    jmp Bekeres


Feladat3_vege:
    xor ax, ax
    int 16h



Program_Vege:
    mov ax, 4c00h
    int 21h


hibauzenet db "Hibas karakter!$"

kezdoszoveg db "(4^N / 8) fuggveny eredmenye: $"

assembly db "Az assembly nyelv nem keverendo ossze a gepi koddal!$"

szavak db "Szavak szama a mondatban: $"

uzenetszam	db	"Szamjegy lett leutve!    $"
uzenetnemszam	db	"Nem szamjegy lett leutve!$"

szamszoveg	db	"Szam vagy nem szam: $"

Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start