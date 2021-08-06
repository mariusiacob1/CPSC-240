
//Program name: "Area_of_Rectangle". This program demonstrates the input of multiple float numbers from the standard input device  
//using a single instruction and the output of multiple float numbers to the standard output device also using a single            
//instruction.  Copyright (C) 2019 Marius Iacob.       

//This file is part of the software program "Area_of_Rectangle".                                                                 
//Area_of_Rectangle is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
//version 3 as published by the Free Software Foundation.                                                                    
//Area_of_Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.

//Author information
//  Author name: Marius Iacob
//  Author email: mariusiacob@csu.fullerton.edu
//
//Program information
//  Program name: Area_of_Rectangle
//  Programming languages: One modules in C++ and one module in X86
//  Date program began: 2021-Feb-1
//  Date of last update: 2021-Feb-13
//  Date of reorganization of comments: 2021-Feb-4
//  Files in this program: rectangle.cpp, perimeter.asm
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu 20.04
//
//Purpose
//  Show how to input, output, and calculating floating point (64-bit) numbers.
    //Given the width and height of the rectangle compute the total perimeter and the
    //average length of side.
//
//This file
//   File name: rectangle.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17
//   Link: gcc -m64 -no-pie -o finalarea.out -std=c++17 perimeter.o rectangle.o 

//======================================== Begin Code ========================================

#include <stdio.h>
#include <stdint.h> //For C99 compatibility
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>   //For malloc

//The standard prototypes for any functions that may be called later.
//This main function calls exactly one function.
extern "C" double _quadratic();
//
int main()
{
double answer = 0.0;
printf("**The main function rectangle.cpp has begun\n");
printf("**The function rectangle will now be called\n");
printf("==========================================================\n");
answer = _quadratic();
printf("Welcome to the Root Calculator programmed by Marius Iacob");
printf("The function rectangle has returned this value %8.5lf\nHave a nice day!\n",answer);
return 0;
}