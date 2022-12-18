.686 ; в программе будут использоваться
; команды процессора Pentium Pro
.model flat, stdcall ; модель памяти и соглашение
; о передаче параметров
option casemap :none ; включается чувствительность
; к регистру
; Библиотеки и подключаемые файлы проекта
;--------------------------------------------
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\fpu.inc
; содержит прототип функции FpuFLtoA
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\fpu.lib
; Сегмент даных
;--------------------------------------------
.data ; инициализированные данные
MsgBoxTitle byte "Операции в сопроцессоре x87", 0
; заголовок окна
MsgBoxText db "Вычисление функции Yn = 130*(x^2 + 7.3),", 13,
"где x изменяется от 1 с шагом 2", 13, 13,
"y1="
res1 db 16 DUP(0), 10, 13 ; зарезервировать 14 байт для первого
; результата и поместить туда 0
db "y2="
res2 db 16 DUP(0), 10, 13
db "y3="
res3 db 16 DUP(0), 10, 13
db "y4="
res4 db 16 DUP(0), 10, 13
db "y5="
res5 db 16 DUP(0), 10, 13
CrLf equ 0A0Dh
y1 TBYTE 0.0 ; тип 80 бит без знака (TBYTE = dt)
y2 dt 0.0
y3 dt 0.0
y4 dt 0.0
y5 dt 0.0
x DWORD 1.0 ; тип 32 бита без знака (DWORD = dd)
op1 dd 130.0
op2 dd 7.3
zero dd 0.0
step dd 2.0
two dd 2.0
.data? ; неинициализированные данные
.const ; константы
; Cегмент кода
;--------------------------------------------
.code
start: ; метка (точка входа в программу)
finit ; инициализация регистров FPU
; (CWR = 037Fh, SWR = 0h, TWR = FFFFh,
; DPR = 0h, IPR = 0h)
mov ecx, 5 ; счётчик X

m1: ; метка начала цикла
fld x
fmul x
fmul two
fadd op2
fmul op1
fld x ; увеличение X на величину шага
fadd step
fstp x
loop m1 ; если ecx = ecx - 1 ? 0,
; переходим на m1

fstp y5 ; сохраняем стек в память
fstp y4
fstp y3
fstp y2
fstp y1
; преобразование результатов вычислений в массив символов
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
; вывод результатов вычислений
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxTitle,
MB_ICONINFORMATION
invoke ExitProcess, NULL ; функция завершения с параметром NULL
end start 