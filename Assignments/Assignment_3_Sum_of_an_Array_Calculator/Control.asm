
;Program name: "Sum of an Array".  This program demonstrates the input of multiple float numbers from the standard input device
;using a single instruction and the output of multiple float numbers to the standard output device also using a single 
;instruction.  Copyright (C) 2019 Marius Iacob.
;
;==================================================================================================================================
;This file is part of the software program "Sum of an Array".                                                                 
;Sum of an Array is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
;version 3 as published by the Free Software Foundation.                                                                    
;Sum of an Array is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
;
;==================================================================================================================================
;Author information
;   Author name: Marius Iacob
;   Author email: mariusiacob@csu.fullerton.edu
;
;==================================================================================================================================
;Program information
;   Program name: Sum of an Array
;   Programming languages: One modules in C++, C, and one module in X86
;   Date program began: 2021-Mar-12
;   Date of last update: 2021-Mar-21
;   Date of reorganization of comments: 2021-Mar-21
;   Files in this program: Control.asm, Fill.asm, Sum.asm, Display.cpp, Main.c, and Script.sh
;   Status: Finished.  The program was tested extensively with no errors in Ubuntu 20.04
;
;==================================================================================================================================
;Purpose
;   Show how to input, output, and calculating floating point (64-bit) numbers.
;   This file (Control.asm) will control/call all the files in this entire program
;   in order.
;
;==================================================================================================================================
;This file
;   File name: Control.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Control.lis -o Control.o Control.asm
;
;==================================================================================================================================

;=======================================BEGIN CODE=================================================
extern printf
extern scanf
extern _fill
extern _sum
extern displayArray
extern main

arraySize equ 100                       ;Capacity limit for number of elements allowed in array.

global _control

segment .data
    ;Welcome/Outputs
    welcomeOutput db "Welcome to Sum of an Array calculator. The accuracy and reliability of this program is guaranteed by Marius I.",10,0
    numbersOutput db "The numbers you entered are these: ",10,0
    sumOutput db "The sum of these values is %5.8lf",10,0
    returnOutput db "The control module will now return the sum to the caller module",10,0

    ;Formats
    stringFormat db "%s",0

segment .bss    ;Reserved for uninitialized data
    myArray: resq 100                   ;Uninitialized array with 100 reserved qwords.

segment .text   ;Reserved for executing instructions.

_control:

;Prolog: Insurance for any caller of this assembly module
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov rbp, rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf

push qword -1                           ; Extra push to create even number of pushes

;=======================================INITIALIZE PARAMETERS======================================
mov qword r14, 0                        ; Reserve register for number of elements in array.
mov qword r13, 0                        ; Reserve register for Sum of integers in array

;=======================================INSTRUCTION PROMPT=========================================
;Display welcomeOutput
mov qword rdi, stringFormat                     
mov qword rsi, welcomeOutput              
mov qword rax, 0
call printf

;Call function _fill
mov qword rdi, myArray
mov qword rsi, arraySize
mov qword rax, 0
call _fill
mov r14, rax

;Display numbersOutput
mov qword rdi, stringFormat                     
mov qword rsi, numbersOutput              
mov qword rax, 0
call printf

;Display myArray
push qword 0
mov qword rdi, myArray
mov qword rsi, r14
mov qword rax, 0
call displayArray
pop qword rax

;Call _sum
mov qword rdi, myArray
mov qword rsi, r14
mov qword rax, 0
call _sum
mov r13, rax

;Display sumOutput
push qword 0    
mov qword rax, 1          
mov qword rdi, sumOutput              
call printf
pop rax

;Display returnOutput
mov qword rdi, stringFormat                     
mov qword rsi, returnOutput              
mov qword rax, 0
call printf

;=======================================END OF CODE================================================
;Restores all registers to their original state.
pop rax                                 ; Remove extra push of -1 from stack.
movsd xmm0, xmm15                       ; Copies Sum (r13) to rax.
popf                                                 
pop rbx                                                     
pop r15                                                     
pop r14                                                      
pop r13                                                      
pop r12                                                      
pop r11                                                     
pop r10                                                     
pop r9                                                      
pop r8                                                      
pop rcx                                                     
pop rdx                                                     
pop rsi                                                     
pop rdi                                                     
pop rbp
ret