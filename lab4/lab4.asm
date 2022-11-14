.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
includelib C:\masm32\lib\kernel32.lib

.data
Dect dw 65
Negt dw -160
Bin1 dd 1000111011b
Bin2 dd 1011110000b
Text db 'Good bye, America', 0
Hex dw 0bff3h
Array dw 256, 765, 89, 654, 9
sConsoleTitle   db "Kovtun Andrei lab4", 0

.data?
Bin3            dd ?

.code
start:
    invoke SetConsoleTitle, offset sConsoleTitle

    mov eax, 0
    xor ebx, ebx

    mov eax, Bin1
    and eax, Bin2
    mov Bin3, eax

    push Dect
    push Negt
    pop Dect
    pop Negt
    
    invoke Sleep, 1000
    invoke ExitProcess, NULL
end start