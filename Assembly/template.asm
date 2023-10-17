Code Segment
    assume CS:Code, DS:Data, SS:Stack
Start:
    mov ax, Code
    mov ds, ax

Program_Vege:
    mov ax, 4c00h
    int 21h

Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start