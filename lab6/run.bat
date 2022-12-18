C:\masm32\bin\ml.exe /c /coff /Fl lab6.asm
C:\masm32\bin\link.exe /SUBSYSTEM:WINDOWS /LIBPATH:C:\masm32\lib\ lab6.obj
pause
del lab6.obj
start lab6.exe
