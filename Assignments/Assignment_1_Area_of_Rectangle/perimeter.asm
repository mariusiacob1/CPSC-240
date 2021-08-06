
;Program name: "Area_of_Rectangle".  This program demonstrates the input of multiple float numbers from the standard input device *
;using a single instruction and the output of multiple float numbers to the standard output device also using a single      *
;instruction.  Copyright (C) 2019 Marius Iacob.

;This file is part of the software program "Area_of_Rectangle".                                                                 
;Area_of_Rectangle is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
;version 3 as published by the Free Software Foundation.                                                                    
;Area_of_Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.

;Author information
;  Author name: Marius Iacob
;  Author email: mariusiacob@csu.fullerton.edu
;
;Program information
;  Program name: Area of Rectangle
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2021-Feb-1
;  Date of last update: 2021-Feb-13
;  Date of reorganization of comments: 2021-Feb-4
;  Files in this program: rectangle.cpp, perimeter.asm
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu 20.04
;
;This file
;   File name: perimeter.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

;======================================== Begin Code ========================================

extern printf
extern scanf
global _perimeter

segment .data
    ;Welcome/start
    welcomePrompt db "Welcome to an assembly program by Marius Iacob",10,0
    startPrompt db "This program will compute the perimeter and the average side length of a rectangle",10,0
    ;Inputs
    inputPrompt1 db "Enter the height: ",0
    inputPrompt2 db "Enter the width: ",0
    ;Outputs
    one_float_format db "%lf",0
    output1_perimeter_float db "The perimeter is: %5.3lf",10,0
    output2_avgSides_float db "The lenght of the average side is: %5.3lf",10,0
    output3 db "I hope you enjoy your rectangle",10,0
    output4 db "The assembly program will send the perimeter to the main function.",10,0

segment .bss    ;Reserved for uninitialized data

segment .text   ;Reserved for executing instructions.

_perimeter:

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

;Display welcomePrompt
mov rax, 0
mov rdi, welcomePrompt
call printf

;startPrompt
mov rax, 0
mov rdi, startPrompt
call printf

;========== Start of section to input height float number ==========
;Display inputPrompt1 
push qword 0
mov rax, 0
mov rdi, inputPrompt1   ;Enter the height: 
call printf
pop rax

;Begin the scanf block
push qword 0
mov rax, 0
mov rdi, one_float_format   ;%5.3lf
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax
;==========End of section to input height float number ==========


;========== Start of section to input width float number ========== 
;Display inputPrompt2 
push qword 0
mov rax, 0
mov rdi, inputPrompt2   ;Enter the width: 
call printf
pop rax

;Begin the scanf block
push qword 0
mov rax, 0
mov rdi, one_float_format   ;%5.3lf
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax
;========== End of section to input width float number ==========


;========== Start of section to calculate perimeter float number ==========
;Calculate perimeter
push qword 0
movsd xmm12, xmm10
addsd xmm12, xmm10
addsd xmm12, xmm11
addsd xmm12, xmm11

;Display perimeter
mov rax, 1 
mov rdi, output1_perimeter_float
movsd xmm0, xmm12
call printf
pop rax
;========== End of section to calculate perimeter float number ==========


;========== Start of section to calculate average float number ========== 
;Calculate average side length
push qword 0
mov r10, 4           ;r10 is a 64-bit register to store in value
cvtsi2sd xmm15, r10  ;cvtsi2sd converts 32-bit integer to 64-bit floating-point
movsd xmm0, xmm12   ;transferring value of perimeter in xmm0
divsd xmm0, xmm15   ;dividing perimeter value with #4

;Display average
mov rax, 1 
mov rdi, output2_avgSides_float
movsd xmm13, xmm0
call printf
pop rax
;========== End of section to calculate average float number ==========


;========== Start of section to end the program ==========
;Display output3
mov rax, 0
mov rdi, output3 
call printf

;Display output4
mov rax, 0
mov rdi, output4    ;The assembly program will send the perimeter to the main function.
call printf

pop rax
movsd xmm0, xmm12
;========== End of section to end the program ==========


;Restore original values to integer registers
popf                                                        ;Restore rflags
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
