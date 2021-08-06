
;Program name: "Root Calculator".  This program demonstrates the input of multiple float numbers from the standard input device
;using a single instruction and the output of multiple float numbers to the standard output device also using a single 
;instruction.  Copyright (C) 2019 Marius Iacob.

;This file is part of the software program "Root Calculator".                                                                 
;Root Calculator is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
;version 3 as published by the Free Software Foundation.                                                                    
;Root Calculator is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.

;Author information
;  Author name: Marius Iacob
;  Author email: mariusiacob@csu.fullerton.edu
;
;Program information
;  Program name: Root Calculator
;  Programming languages: One modules in C++, C, and one module in X86
;  Date program began: 2021-Feb-25
;  Date of last update: 2021-Mar-1
;  Date of reorganization of comments: 2021-Mar-1
;  Files in this program: isdigit.cpp, isfloat.cpp, Quad_library.cpp, Quadratic.asm, and Second_degree.c
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu 20.04
;
;This file
;   File name: Quadratic.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Quadratic.lis -o Quadratic.o Quadratic.asm

;======================================== Begin Code ========================================

extern printf
extern scanf
extern atof
extern isfloat
extern isdigit
extern Second_degree
extern show_no_roots
extern show_one_root
extern show_two_roots

global _quadratic

segment .data
    ;Welcome/Start
    detailPrompt db "This program will find the roots of any quadratic equation.",10,0
    ;Inputs
    intputPrompt db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by the end of line character.", 10,0
    ;Outputs
    equationPrompt db "Thank you. The equation is %5.3lfx^2 + %5.3lfx + %5.3lf = 0.0",10,0
    returnPrompt db "One of these roots will be returned to the caller function.",10,0
    invalidPrompt db "Invalid numbers",10,0
    discriminantTest db "b^2 - 4ac = %5.3lf",10,0
    discriminantTest2 db "(-b +or- sqrt(b^2 - 4ac)) / 2a = %5.3lf , %5.3lf",10,0
    ;String format
    one_string_format db "%s",0
    three_string_format db "%s%s%s",0

segment .bss    ;Reserved for uninitialized data
segment .text   ;Reserved for executing instructions.

_quadratic:

;Prolog: Insurance for any caller of this assembly module
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi       ;Backup rdi
push rsi       ;Backup rsi
push rdx       ;Backup rdx
push rcx       ;Backup rcx
push r8        ;Backup r8
push r9        ;Backup r9
push r10       ;Backup r10
push r11       ;Backup r11
push r12       ;Backup r12
push r13       ;Backup r13
push r14       ;Backup r14
push r15       ;Backup r15
push rbx       ;Backup rbx
pushf

;Registers rax, rip, and rsp are usually not backed up.
push qword 0

;======================================================== CODE STARTS HERE ========================================================
;Display detailPrompt
mov rax, 0
mov rdi, detailPrompt
call printf

;============================ Start of section to input three floating point / conversion ============================
;Display intputPrompt
push qword 99
mov rax, 0
mov rdi, intputPrompt               ;"This program will find the roots...""
call printf
pop rax

;Input 3 float numbers (The next block of instructions)
push qword -1                       ;allocates memory
push qword -2                   
push qword -3                   
mov rax, 0
mov rdi, three_string_format        ;"%s%s%s"
mov rsi, rsp                        ;rsi points to first quadword on the stack
mov rdx, rsp
add rdx, 8
mov rcx, rsp                        ;rcx points to third quadword on the stack
add rcx, 16
movsd xmm13, [rsp]
movsd xmm14, [rsp+8]
movsd xmm15, [rsp+16]
call scanf

;Check the input 
mov rax, 0 
mov rdi, rsp
call isfloat
cmp rax, 0                          ;cmp is compare
je invalid                          ;je will jump if it's equal to ==

;Float conversion for 'a'
mov rax, 0
mov rdi, rsp
call atof
movsd xmm13, xmm0

mov rax, 0 
mov rdi, rsp 
add rdi, 8
call isfloat
cmp rax, 0
je invalid

;Float conversion for 'b'
mov rax, 0
mov rdi, rsp
add rdi, 8
call atof
movsd xmm14, xmm0

mov rax, 0 
mov rdi, rsp 
add rdi, 16
call isfloat
cmp rax, 0
je invalid

;Float conversion for 'c'
mov rax, 0
mov rdi, rsp
add rdi, 16
call atof
movsd xmm15, xmm0
jmp valid
;============================ End of section to input three floating point / conversion ============================


;============================ Start of section to output invalid / end ============================
invalid:
    mov rax, 1
    mov rdi, invalidPrompt
    call printf
    jmp endProgram
;============================ End of section to output invalid / end ============================


;============================ Start of section to ouput valid and equationPrompt ============================
valid:
    add rsp, 1024
    pop rax
    push qword 99
    mov rax, 3
    mov rdi, equationPrompt        ;"Thank you.  The equation is...""
    movsd xmm0, xmm13               ;'a' being moved to xmm0
    movsd xmm1, xmm14              ;'b' being moved to xmm1
    movsd xmm2, xmm15              ;'c' being moved to xmm2
    call printf
    pop rax
    jmp calculate
;============================ End of section to output the equation =========================================


;============================ Start of section of calculating ============================
calculate:
;calculate discriminant
push qword 0
mov r8, 4                          ;setting r8 with value 4
cvtsi2sd xmm4, r8                  ;moving r8 value into xmm4
movsd xmm5, xmm14                  ;make a copy of 'b' to perform x^2
mulsd xmm5, xmm5                   ;xmm5 value is 'b' which is being squared
mulsd xmm4, xmm13                  ;xmm4 = 4 and xmm13 = 'a'
mulsd xmm4, xmm15                  ;xmm4 = 4 and xmm15 = 'c' (4ac)
subsd xmm5, xmm4                   ;b^2 - 4ac
movsd xmm6, xmm5                   ;move xmm5 val to xmm6
sqrtsd xmm6, xmm6                  ;sqrt val of xmm6
mov r9, 0
cvtsi2sd xmm7, r9
ucomisd xmm5, xmm7                 ;ucomisd compare two 64-bit floating-point operands

;Display test (DELETE WHEN DONE)
mov rax, 1
mov rdi, discriminantTest
movsd xmm0, xmm5
call printf
;pop rax

ja doubleRoots
je singleRoot
jb zeroRoots

doubleRoots:
;calculate (-b + sqrt(b^2 - 4ac)) / 2a
mov r10, -1                        ;setting r10 as -1 for '-b'
cvtsi2sd xmm10, r10                ;converting r10 into xmm10
mov r12, -1                        ;setting r10 as -1 for '-b'
cvtsi2sd xmm11, r12                ;converting r10 into xmm11
mulsd xmm10, xmm14                 ;xmm14 = 'b'
mulsd xmm11, xmm14
addsd xmm10, xmm6                  ;(-b + sqrt(b^2 - 4ac))
subsd xmm11, xmm6                  ;(-b - sqrt(b^2 - 4ac))

;2a for -b + sqrt(b^2 - 4ac)
mov r11, 2
cvtsi2sd xmm12, r11
mulsd xmm12, xmm13
divsd xmm10, xmm12

;2a for -b - sqrt(b^2 - 4ac)
mov r13, 2
cvtsi2sd xmm9, r13
mulsd xmm9, xmm13
divsd xmm11, xmm9

;Display test
movsd xmm0, xmm10
movsd xmm1, xmm11
mov rax, 1
call show_two_roots
jmp endProgram

singleRoot:
mov r10, -1                        ;setting r10 as -1 for '-b'
cvtsi2sd xmm10, r10                ;converting r10 into xmm10
;2a for -b + sqrt(b^2 - 4ac)
mov r11, 2
cvtsi2sd xmm12, r11
mulsd xmm12, xmm13                 ;2a
divsd xmm14, xmm12
movsd xmm0, xmm14
mov rax, 1
call show_one_root
jmp endProgram

zeroRoots:
pop rax
call show_no_roots

;============================ End of section of calculating ============================
pop rax
;======================================================== CODE ENDS HERE ========================================================
;Restore original values to integer registers
popf           ;Restore rflags
pop rbx        ;Restore rbx
pop r15        ;Restore r15
pop r14        ;Restore r14
pop r13        ;Restore r13
pop r12        ;Restore r12
pop r11        ;Restore r11
pop r10        ;Restore r10
pop r9         ;Restore r9
pop r8         ;Restore r8
pop rcx        ;Restore rcx
pop rdx        ;Restore rdx
pop rsi        ;Restore rsi
pop rdi        ;Restore rdi
pop rbp        ;Restore rbp
ret

endProgram:
    ;Restore original values to integer registers
    popf           ;Restore rflags
    pop rbx        ;Restore rbx
    pop r15        ;Restore r15
    pop r14        ;Restore r14
    pop r13        ;Restore r13
    pop r12        ;Restore r12
    pop r11        ;Restore r11
    pop r10        ;Restore r10
    pop r9         ;Restore r9
    pop r8         ;Restore r8
    pop rcx        ;Restore rcx
    pop rdx        ;Restore rdx
    pop rsi        ;Restore rsi
    pop rdi        ;Restore rdi
    pop rbp        ;Restore rbp
    ret
