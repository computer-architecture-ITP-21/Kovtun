C:\masm32\bin\ml.exe /c /coff /Fl lab5.asm
C:\masm32\bin\link.exe /SUBSYSTEM:CONSOLE /LIBPATH:C:\masm32\lib\ lab5.obj
pause
del lab5.obj
start lab5.exe
