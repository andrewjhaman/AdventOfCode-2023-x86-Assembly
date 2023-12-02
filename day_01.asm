global _start

extern ExitProcess
extern CreateFileA

%define GENERIC_READ    0x80000000
%define GENERIC_WRITE   0x40000000
%define GENERIC_EXECUTE 0x20000000
%define GENERIC_ALL     0x10000000

%define CREATE_ALWAYS 2

%define FILE_ATTRIBUTE_NORMAL 0x00000080

%macro FUNCTION_PROLOGUE 1
    push rbp 
    mov rbp, rsp

    sub rsp, %1
%endmacro

%macro FUNCTION_EPILOGUE 1
    add rsp, %1
    pop rbp
    ret
%endmacro

section .data
    my_filename db "my_filename.txt", 0 
    my_other_filename db "my_other_filename.txt", 0

section .text


open_file:
    FUNCTION_PROLOGUE 0x30

    mov edx, (GENERIC_READ | GENERIC_WRITE)
    xor r8, r8
    xor r9, r9
    xor eax, eax

    mov [rsp+0x20], dword CREATE_ALWAYS
    mov [rsp+0x28], dword FILE_ATTRIBUTE_NORMAL
    mov [rsp+0x30], dword 0
    
    call CreateFileA

    FUNCTION_EPILOGUE 0x30



_start:
    mov rcx, my_filename
    call open_file

    mov rcx, my_other_filename
    call open_file

    mov ecx, 0 
    call ExitProcess
