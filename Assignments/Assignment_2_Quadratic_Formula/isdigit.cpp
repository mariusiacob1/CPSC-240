
//Program name: "Root Calculator".  This program demonstrates the input of multiple float numbers from the standard input device
//using a single instruction and the output of multiple float numbers to the standard output device also using a single 
//instruction.  Copyright (C) 2019 Marius Iacob.

//This file is part of the software program "Root Calculator".                                                                 
//Root Calculator is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
//version 3 as published by the Free Software Foundation.                                                                    
//Root Calculator is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.

//Author information
//   Author name: Marius Iacob
//   Author email: mariusiacob@csu.fullerton.edu
// 
// Program information
//   Program name: Root Calculator
//   Programming languages: One modules in C++, C, and one module in X86
//   Date program began: 2021-Feb-25
//   Date of last update: 2021-Mar-1
//   Date of reorganization of comments: 2021-Mar-1
//   Files in this program: isdigit.cpp, isfloat.cpp, Quad_library.cpp, Quadratic.asm, and Second_degree.c
//   Status: Finished.  The program was tested extensively with no errors in Ubuntu 20.04
// 

//
//Purpose
//  Show how to input, output, and calculating floating point (64-bit) numbers.
//  It will show how to check for invalid or valid.
    
//
//This file
//    File name: isdigit.cpp
//    Language: X86 with Intel syntax.
//    Max page width: 132 columns


#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

using namespace std;

extern "C" bool isdigit(char[]);

bool isdigit(char w[])
{
    bool ok = true;
    bool notOk = false;

    if (isdigit(w[0]))
    {
        return ok;
    }
    else
        return notOk;
}