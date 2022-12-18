.686 ; � ��������� ����� ��������������
; ������� ���������� Pentium Pro
.model flat, stdcall ; ������ ������ � ����������
; � �������� ����������
option casemap :none ; ���������� ����������������
; � ��������
; ���������� � ������������ ����� �������
;--------------------------------------------
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\fpu.inc
; �������� �������� ������� FpuFLtoA
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\fpu.lib
; ������� �����
;--------------------------------------------
.data ; ������������������ ������
MsgBoxTitle byte "�������� � ������������ x87", 0
; ��������� ����
MsgBoxText db "���������� ������� Yn = 130*(x^2 + 7.3),", 13,
"��� x ���������� �� 1 � ����� 2", 13, 13,
"y1="
res1 db 16 DUP(0), 10, 13 ; ��������������� 14 ���� ��� �������
; ���������� � ��������� ���� 0
db "y2="
res2 db 16 DUP(0), 10, 13
db "y3="
res3 db 16 DUP(0), 10, 13
db "y4="
res4 db 16 DUP(0), 10, 13
db "y5="
res5 db 16 DUP(0), 10, 13
CrLf equ 0A0Dh
y1 TBYTE 0.0 ; ��� 80 ��� ��� ����� (TBYTE = dt)
y2 dt 0.0
y3 dt 0.0
y4 dt 0.0
y5 dt 0.0
x DWORD 1.0 ; ��� 32 ���� ��� ����� (DWORD = dd)
op1 dd 130.0
op2 dd 7.3
zero dd 0.0
step dd 2.0
two dd 2.0
.data? ; �������������������� ������
.const ; ���������
; C������ ����
;--------------------------------------------
.code
start: ; ����� (����� ����� � ���������)
finit ; ������������� ��������� FPU
; (CWR = 037Fh, SWR = 0h, TWR = FFFFh,
; DPR = 0h, IPR = 0h)
mov ecx, 5 ; ������� X

m1: ; ����� ������ �����
fld x
fmul x
fmul two
fadd op2
fmul op1
fld x ; ���������� X �� �������� ����
fadd step
fstp x
loop m1 ; ���� ecx = ecx - 1 ? 0,
; ��������� �� m1

fstp y5 ; ��������� ���� � ������
fstp y4
fstp y3
fstp y2
fstp y1
; �������������� ����������� ���������� � ������ ��������
invoke FpuFLtoA, addr y1, 10, addr res1, SRC1_REAL or SRC2_DIMM
mov word ptr res1 + 16, CrLf
invoke FpuFLtoA, addr y2, 10, addr res2, SRC1_REAL or SRC2_DIMM
mov word ptr res2 + 16, CrLf
invoke FpuFLtoA, addr y3, 10, addr res3, SRC1_REAL or SRC2_DIMM
mov word ptr res3 + 16, CrLf
invoke FpuFLtoA, addr y4, 10, addr res4, SRC1_REAL or SRC2_DIMM
mov word ptr res4 + 16, CrLf
invoke FpuFLtoA, addr y5, 10, addr res5, SRC1_REAL or SRC2_DIMM
mov word ptr res5 + 16, CrLf
; ����� ����������� ����������
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxTitle,
MB_ICONINFORMATION
invoke ExitProcess, NULL ; ������� ���������� � ���������� NULL
end start 