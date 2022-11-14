C:\masm32\bin\ml.exe /c /coff /Fl lab4.asm
C:\masm32\bin\link.exe /SUBSYSTEM:CONSOLE /LIBPATH:C:\masm32\lib\ lab4.obj
pause
del lab4.obj
start lab4.exe
