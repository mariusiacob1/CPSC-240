
;Program name: "King of Assembly".  This program demonstrates the input of multiple float numbers from the standard input device
;using a single instruction and the output of multiple float numbers to the standard output device also using a single 
;instruction.  Copyright (C) 2019 Marius Iacob.
;
;==================================================================================================================================
;This file is part of the software program "King of Assembly".                                                                 
;King of Assembly is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
;version 3 as published by the Free Software Foundation.                                                                    
;King of Assembly is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         
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
;   Program name: King of Assembly
;   Programming languages: One modules in C++, and one module in X86
;   Date program began: 2021-Mar-12
;   Date of last update: 2021-May-19
;   Date of reorganization of comments: 2021-May-19
;   Files in this program: interview.asm, main.cpp, (bash) r.sh, chris.txt, csmajor.txt, and social.txt
;   Status: Finished. The program was tested extensively with no errors in Ubuntu 20.04
;
;==================================================================================================================================
;Purpose
;   Show how to input, output, and calculating floating point (64-bit) numbers.
;   This file (interview.asm) will interview will interview someone. If they meet the requirements, they will get the job.
;   It will transfer data from here and compare values in the main.cpp file.
;
;==================================================================================================================================
;This file
;   File name: interview.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l interview.lis -o interview.o interview.asm
;
;==================================================================================================================================

;======================================== Begin Code ========================================
extern printf
extern scanf

global _interview

segment .data
    ;Inputs / Outputs
    welcomePrompt db "Hello %s. I am Ms. Fenster. The interview will begin now.", 10, 0
    intputPrompt db "Wow! %.2lf That's a lof of cash. Who do you think you are, Chris Sawyer (y or n)? ", 10, 0
    alrightPrompt db "Alright. Now we will work on your electricity.", 10, 0
    electricityPrompt db "Please enter the resistance of circuit #1 in ohms: ", 10, 0
    resistancePrompt db "What is the resistance of circut #2 on ohms: ", 10, 0
    totalResistance db "The total resistance is %.2lf ohms.", 10, 0         
    csMajor db "Are you a computer science major (y or n)? ", 0

    ;Formats
    stringFormat db "%s", 0
    floatFormat db "%lf", 0

segment .bss

segment .text   ; Reserved for executing instructions.

_interview:

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
pushf

;=======================================BEGIN CODE=================================================
push qword 0                            ; Extra push to create even number of pushes

; Save the args passed (Name and Salary) into regs
mov r15, rdi                            ; fullName from driver
movsd xmm15, xmm0                       ; salary from driver

; Displays welcomePrompt
push qword 0
mov rax, 0 
mov rdi, welcomePrompt
mov rsi, r15
call printf
pop rax

; Display input from driver
push qword 99
mov rax, 1
mov rdi, intputPrompt
movsd xmm0, xmm15
call printf
pop rax

push qword 0
mov rdi, stringFormat
mov rsi, rsp
call scanf
pop rax

mov r15, 'y'
cmp rax, r15                            ; If answer is y, it will be compared
je sawyer                               ; Jumps to sawyer for job offering and salary

mov r15, 'n'                             
cmp rax, r15                            ; If answer is n, it will be compared
je elecResist                           ; Jumps to elecResist for calculating the elec. and resist.

; Displaying out the electricity/resistance prompt
elecResist:
push qword 0
mov rax, 0
mov rdi, alrightPrompt
call printf 
pop rax

; Getting / storing the electricity input from user
push qword 99
mov rax, 0 
mov rdi, electricityPrompt
call printf
pop rax

push qword -1
mov rax, 0
mov rdi, floatFormat
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
pop rax

; Getting / storing the resistance input from user
push qword 99
mov rax, 0 
mov rdi, resistancePrompt
call printf
pop rax

push qword -1
mov rax, 0
mov rdi, floatFormat
mov rsi, rsp
call scanf
movsd xmm13, [rsp]
pop rax

; Calculating the total of electricity & resistance
push qword 99
mov r8, 1                               ;r8 is a 64-bit register to store in value
cvtsi2sd xmm8, r8                       ;cvtsi2sd converts 32-bit integer to 64-bit floating-point
mov r9, 1                               ;r9 is a 64-bit register to store in value
cvtsi2sd xmm9, r9                       ;cvtsi2sd converts 32-bit integer to 64-bit floating-point
mov r10, 1                              ;r10 is a 64-bit register to store in value
cvtsi2sd xmm10, r10                     ;cvtsi2sd converts 32-bit integer to 64-bit floating-point
divsd xmm8, xmm12 
divsd xmm9, xmm13 
addsd xmm8, xmm9
divsd xmm10, xmm8

mov rax, 1
mov rdi, totalResistance
movsd xmm0, xmm10
call printf
pop rax

; Displays if user is a csMajor
push qword 0
mov rax, 0
mov rdi, csMajor
call printf
pop rax

push qword 0
mov rax, 0 
mov rdi, stringFormat
mov rsi, rsp
call scanf
mov rax, [rsp]
pop r8

cmp rax, 'y'
je csMajorMoney                         ; If answer is y, it'll jump to job offering and salary

mov r8, 1200d
cvtsi2sd xmm15, r8

jmp end

csMajorMoney:                           ; Displays input from driver
mov r8, 50000
cvtsi2sd xmm15, r8

jmp end

sawyer:
mov r8, 1000000
cvtsi2sd xmm15, r8

end:
movsd xmm0, xmm15
;=======================================EXIT PROGRAM===============================================
; Restore all backed up registers to their original state.
pop rax                                 
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