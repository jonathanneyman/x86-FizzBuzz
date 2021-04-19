section .data
        num                     db 0

        startmsg                db "Starting Fizzbuzz", 0xa
        startmsg.length         equ $-startmsg

        finishmsg               db "Finished Fizzbuzz", 0xa
        finishmsg.length        equ $-finishmsg

        fizzmsg                 db "Fizz", 0xa
        fizzmsg.length          equ $-fizzmsg

        buzzmsg                 db "Buzz", 0xa
        buzzmsg.length          equ $-buzzmsg

        fizzbuzzmsg             db "Fizzbuzz", 0xa
        fizzbuzzmsg.length      equ $-fizzbuzzmsg

        nummsg                  db "  ", 0xa
        nummsg.length           equ $-nummsg

section .text
        extern  _GetStdHandle@4
        extern  _WriteFile@20
        extern  _ExitProcess@4

        global  _main

; Entry point
_main:
        call    _print_startmsg
        call    _fizzbuzz
        call    _print_finishmsg
        call    _exit

_exit:
        push    0
        call    _ExitProcess@4

; Does the actual work
_fizzbuzz:
        .for_begin:
        mov [num], dword 0
        jmp .for_continue

        .for_continue:
        ; Increment
        add     [num], dword 1
        jmp     .for_start
        
        .for_start:
        ; Check if we should exit the loop
        mov     ecx, [num]
        cmp     ecx, 99
        jg      .for_end

        .if_fizzbuzz:
        mov     eax, [num]
        xor     edx, edx
        mov     ebx, 15
        div     ebx
        cmp     edx, 0
        jne     .elseif_fizz
        
        ; if(i % 15 == 0)
        call _print_fizzbuzzmsg
        jmp .for_continue

        .elseif_fizz:
        mov     eax, [num]
        xor     edx, edx
        mov     ebx, 3
        div     ebx
        cmp     edx, 0
        jne     .elseif_buzz
        
        ; if(i % 3 == 0)
        call _print_fizzmsg
        jmp .for_continue

        .elseif_buzz:
        mov     eax, [num]
        xor     edx, edx
        mov     ebx, 5
        div     ebx
        cmp     edx, 0
        jne     .else
        
        ; if(i % 5 == 0)
        call _print_buzzmsg
        jmp .for_continue

        .else:
        call _print_nummsg
        jmp .for_continue

        .for_end:

        ret

; Functions for printing the messages to the console (Windows)

_print_startmsg:
        ; HANDLE GetStdHandle(DWORD nStdHandle)
        push    -11
        call    _GetStdHandle@4
        mov     ebx, eax

        ; BOOL WriteFile(HANDLE hFile, LPCVOID lpBuffer, DWORD nNumberOfBytesToWrite, LPDWORD lpNumberOfBytesWritten, LPOVERLAPPED lpOverlapped)
        push    0
        lea     eax, [ebp-4]
        push    eax
        push    startmsg.length
        push    startmsg
        push    ebx
        call    _WriteFile@20

        ret

_print_finishmsg:
        ; HANDLE GetStdHandle(DWORD nStdHandle)
        push    -11
        call    _GetStdHandle@4
        mov     ebx, eax

        ; BOOL WriteFile(HANDLE hFile, LPCVOID lpBuffer, DWORD nNumberOfBytesToWrite, LPDWORD lpNumberOfBytesWritten, LPOVERLAPPED lpOverlapped)
        push    0
        lea     eax, [ebp-4]
        push    eax
        push    finishmsg.length
        push    finishmsg
        push    ebx
        call    _WriteFile@20

        ret

_print_fizzmsg:
        ; HANDLE GetStdHandle(DWORD nStdHandle)
        push    -11
        call    _GetStdHandle@4
        mov     ebx, eax

        ; BOOL WriteFile(HANDLE hFile, LPCVOID lpBuffer, DWORD nNumberOfBytesToWrite, LPDWORD lpNumberOfBytesWritten, LPOVERLAPPED lpOverlapped)
        push    0
        lea     eax, [ebp-4]
        push    eax
        push    fizzmsg.length
        push    fizzmsg
        push    ebx
        call    _WriteFile@20

        ret

_print_buzzmsg:
        ; HANDLE GetStdHandle(DWORD nStdHandle)
        push    -11
        call    _GetStdHandle@4
        mov     ebx, eax

        ; BOOL WriteFile(HANDLE hFile, LPCVOID lpBuffer, DWORD nNumberOfBytesToWrite, LPDWORD lpNumberOfBytesWritten, LPOVERLAPPED lpOverlapped)
        push    0
        lea     eax, [ebp-4]
        push    eax
        push    buzzmsg.length
        push    buzzmsg
        push    ebx
        call    _WriteFile@20

        ret

_print_fizzbuzzmsg:
        ; HANDLE GetStdHandle(DWORD nStdHandle)
        push    -11
        call    _GetStdHandle@4
        mov     ebx, eax

        ; BOOL WriteFile(HANDLE hFile, LPCVOID lpBuffer, DWORD nNumberOfBytesToWrite, LPDWORD lpNumberOfBytesWritten, LPOVERLAPPED lpOverlapped)
        push    0
        lea     eax, [ebp-4]
        push    eax
        push    fizzbuzzmsg.length
        push    fizzbuzzmsg
        push    ebx
        call    _WriteFile@20

        ret

_print_nummsg:
        mov     al, [num]
        xor     ah, ah
        mov     bl, 10
        div     bl
        cmp     al, 0         ; Check remainder (modulo 10) to see whether we have a 2-digit decimal number
        je      .skip_padding
        add     al, 48        ; Add ASCII index of char "0" to byte
        mov     [nummsg], al
        .skip_padding:
        add     ah, 48        ; Add ASCII index of char "0" to byte
        mov     [nummsg+1], ah

        ; HANDLE GetStdHandle(DWORD nStdHandle)
        push    -11
        call    _GetStdHandle@4
        mov     ebx, eax

        ; BOOL WriteFile(HANDLE hFile, LPCVOID lpBuffer, DWORD nNumberOfBytesToWrite, LPDWORD lpNumberOfBytesWritten, LPOVERLAPPED lpOverlapped)
        push    0
        lea     eax, [ebp-4]
        push    eax
        push    nummsg.length
        push    nummsg
        push    ebx
        call    _WriteFile@20

        ret
