.386
.model flat, stdcall
option casemap: none
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
includelib C:\masm32\lib\kernel32.lib
.data
avar dw 25
cvar dw -5
kvar dw 11

.data?
evar dw ?

.code ; e=(a-c)(a-c)+2*a*c/k
start:
    mov cx, avar
    sub cx, cvar
    mov ax, cx
    imul cx
    mov bx, ax
    mov ax, avar
    mov cx, cvar
    imul cx
    mov cx, 2
    imul cx
    idiv kvar
    add ax, bx
    mov evar, ax
    invoke ExitProcess, NULL
end start
    