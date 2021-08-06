
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
;   This file (Sum.asm) will sum up all the elements in the array and return the 
;   final sum to the control
; 
;==================================================================================================================================
;This file
;   File name: Sum.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Sum.lis -o Sum.o Sum.asm
; 
;==================================================================================================================================

;=======================================Begin Code=================================================
extern printf
extern scanf

global _sum

segment .data
segment .bss 
segment .text   

_sum:

; Back up all registers to stack and set stack pointer to base pointer
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

push qword -1                           ; Extra push onto stack to make even # of pushes.

mov r15, rdi                            ; Copies array that was passed to r15.
mov r14, rsi                            ; Copies number of elements in the array to r14.
mov r13, 0                              ; Sum register to add elements of array to.
cvtsi2sd xmm15, r13
mov r12, 0                              ; Counter to to iterate through array.

;=======================================START LOOP=================================================
startLoop:

; Compares the counter (r12) to the number of elements in the array (r14).
cmp r12, r14                        
jge outofloop

;=======================================COPY INTO ARRAY============================================
; Adds element of array at index of r12 to the Sum of register r13.
addsd xmm15, [r15 + 8 * r12]            
inc r12                                 ; Increments counter r12 by 1.

; Restarts loop
jmp startLoop

;=======================================END OF LOOP================================================
outofloop:
; Restores all backed up registers to their original state.
pop rax                                 ;Remove extra push of -1 from stack.
movsd xmm0, xmm15                       ;Copies sum (r13) to rax.
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