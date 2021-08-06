
//Program name: "Sum of an Array".  This program demonstrates the input of multiple float numbers from the standard input device
//using a single instruction and the output of multiple float numbers to the standard output device also using a single 
//instruction.  Copyright (C) 2019 Marius Iacob.
//
//=================================================================================================================================
//This file is part of the software program "Sum of an Array".                                                                 
//Sum of an Array is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
//version 3 as published by the Free Software Foundation.                                                                    
//Sum of an Array is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
//
//=================================================================================================================================
//Author information
//  Author name: Marius Iacob
//  Author email: mariusiacob@csu.fullerton.edu
//
//=================================================================================================================================
//Program information
//  Program name: Sum of an Array
//  Programming languages: One modules in C++, C, and one module in X86
//  Date program began: 2021-Mar-12
//  Date of last update: 2021-Mar-21
//  Date of reorganization of comments: 2021-Mar-21
//  Files in this program: Control.asm, Fill.asm, Sum.asm, Display.cpp, Main.c, and Script.sh
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu 20.04
//
//=================================================================================================================================
//Purpose
//  Show how to input, output, and calculating floating point (64-bit) numbers.
//  This file (Display.cpp) will correctly display and organize the array in
//  its proper format.
//
//=================================================================================================================================
//This file
//  File name: Display.cpp
//  Language: C++ with Intel syntax.
//  Max page width: 132 columns
//  Compiler: gcc -c -Wall -m64 -no-pie -no-pie -o Display.o Display.cpp -std=c++17
//
//=================================================================================================================================

//============================================START OF CODE========================================
#include <stdio.h>

extern "C" double _control();
extern "C" double _fill();
extern "C" double _sum();
//
extern "C" void displayArray(double array[], long index);
void displayArray(double array[], long index)
{
    for (long i = 0; i < index; ++i)
    {
        printf("%f", array[i]);
        printf("%s", " ");
        printf("\n");
    }
}