@ECHO OFF
nasm -f win32 main.asm -o main.obj
gcc -m32 main.obj -o main.exe
