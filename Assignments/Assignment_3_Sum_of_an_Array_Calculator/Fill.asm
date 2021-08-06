
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
;   This file (Fill.asm) will fill up the array from the user and will send the
;   the total number of elements that were inputted from the user back to control.
;
;==================================================================================================================================
;This file
;   File name: Fill.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Fill.lis -o Fill.o Fill.asm
;
;==================================================================================================================================

;======================================== Begin Code ========================================
extern printf
extern scanf
extern atof

arraySize equ 100

global _fill

segment .data
    ;Inputs
    numbersInput db "When finished, press enter followed by cntl+D.",10,0

    ;Outputs
    floatOutput db "Please enter floating point number separated by ws.",10,0
    
    ;Formats
    stringFormat db "%s", 0

segment .bss
    myArray: resq 100

segment .text   ;Reserved for executing instructions.

_fill:

; Back up all registers and set stack pointer to base pointer
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

;=======================================BEGIN CODE=================================================
push qword -1                           ;Extra push to create even number of pushes

;=======================================INITIALIZE PARAMETERS======================================
mov qword r15, rdi                      ;Address of array saved to r15.
mov qword r14, rsi                      ;Max number of elements allowed in array.
mov qword r13, 0                        ;Set counter to 0 elements in Array.

;Display floatOutput
mov qword rdi, stringFormat                     
mov qword rsi, floatOutput              
mov qword rax, 0
call printf

;Display numbersInput
mov qword rdi, stringFormat                     
mov qword rsi, numbersInput              
mov qword rax, 0
call printf

;=======================================START OF LOOP==============================================
startLoop:
;Scanf function called to take user input.
mov qword rdi, stringFormat
push qword 0
mov qword rsi, rsp                      ;Stack pointer points to where scanf outputs.
mov qword rax, 0
call scanf

; Tests if Control + D is entered to finish inputing into array.
cdqe
cmp rax, -1                          
je endLoop                              ;If control + D is entered, jump to end_of_loop.

;=======================================ASCII TO LONG==============================================
; Converts string of characters (user input) into a long integer. 
mov qword rax, 0
mov qword rdi, rsp
call atof                      
movsd qword xmm12, xmm0                 ;Saves output long integer from atolong in r12.
pop r8                                  ;Pop off stack into any scratch register. 

;=======================================COPY INTO ARRAY============================================
; Adds copy of long integer saved in r12 into array at index of counter (r13).
movsd [r15 + 8 * r13], xmm12                ;Copies user input into array at index of r13.
inc r13                                 ;Increments counter r13 by 1.

;=======================================ARRAY CAPACITY TEST========================================
; Tests to see if max array capacity has been reached.
cmp r13, r14                            ;Compares # of elements (r13) to capacity (r14).
je exitProgram                          ;If # of elements equals capacity, exit loop.

; Restarts loop.
jmp startLoop

;=======================================END OF LOOP================================================
endLoop:
pop r8

;=======================================EXIT PROGRAM===============================================
exitProgram:
; Restore all backed up registers to their original state.
pop rax                                 ;Remove extra push of -1 from stack.
mov qword rax, r13                      ;Copies # of elements in r13 to rax.
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