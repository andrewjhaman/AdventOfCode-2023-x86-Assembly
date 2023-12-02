global _start

extern ExitProcess
extern CreateFileA

%define GENERIC_READ    0x80000000
%define GENERIC_WRITE   0x40000000
%define GENERIC_EXECUTE 0x20000000
%define GENERIC_ALL     0x10000000

%define CREATE_ALWAYS 2

%define FILE_ATTRIBUTE_NORMAL 0x00000080


section .data
    my_filename db "my_filename.txt"

section .text



_start:
    mov rcx, my_filename
    mov edx, (GENERIC_READ | GENERIC_WRITE)
    xor r8, r8
    xor r9, r9
    xor eax, eax

    sub rsp, 0x30
    mov [rsp+0x20], dword CREATE_ALWAYS
    mov [rsp+0x28], dword FILE_ATTRIBUTE_NORMAL
    mov [rsp+0x30], dword 0
    
    call CreateFileA

    mov ecx, 0 
    call ExitProcess




