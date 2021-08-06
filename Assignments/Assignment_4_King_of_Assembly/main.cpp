
//Program name: "King of Assembly".  This program demonstrates the input of multiple float numbers from the standard input device
//using a single instruction and the output of multiple float numbers to the standard output device also using a single 
//instruction.  Copyright (C) 2019 Marius Iacob.
//
//=================================================================================================================================
//This file is part of the software program "King of Assembly".                                                                 
//King of Assembly is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
//version 3 as published by the Free Software Foundation.                                                                    
//King of Assembly is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         
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
//  Program name: King of Assembly
//  Programming languages: One modules in C++, C, and one module in X86
//  Date program began: 2021-Mar-12
//  Date of last update: 2021-May-19
//  Date of reorganization of comments: 2021-May-19
//  Files in this program: interview.asm, main.cpp, (bash) r.sh, chris.txt, csmajor.txt, and social.txt
//  Status: Finished. The program was tested extensively with no errors in Ubuntu 20.04
//
//=================================================================================================================================
//Purpose
//  Show how to input, output, and calculating floating point (64-bit) numbers.
//  This file (main.cpp) will gather information from the user and correctly display / organizes it. It also compares float values
//  to strictly determine if the user get the job or not. 
//
//=================================================================================================================================
//This file
//  File name: main.cpp
//  Language: C++ with Intel syntax.
//  Max page width: 132 columns
//  Compiler: g++ -Wall -Wextra -Werror -c main.cpp -o main.o
//
//=================================================================================================================================

//============================================START OF CODE========================================
#include <iostream>
#include <stdio.h>
#include <string>

using namespace std;

extern "C" double _interview(char fullName[], double salary);
//
int main()
{
    double result = 0.0;
    char fullName[50] = "";
    cout << "=========================================================================\n";
    cout << "Welcome to Software Analysis by Paramount Programmers, Inc.\n";
    cout << "Please enter your first and last name and press enter: \n";
    cin.getline(fullName, 50);
    cout << "Thank you " << fullName << ". Our records show that you applied for employment here with our agency a week ago.\n";
    cout << "Please enter your expected annual salary when employed at Paramount: ";
    cin >> result;
    //cout << "Your interview with Ms. Linda Fenster, Personnel Manager, will begin shortly.\n";
    cout << endl;
    
    double x = _interview(fullName, result);

    printf("\nHello %s, I am the receptionist. ", fullName);
    if (x <= 2000.00)
    {
        printf("\nWe have an opening for you in the company cafeteria for $1200.12 annually.\n");
        printf("Take your time on letting us know your decision. Bye\n\n");
    }
    else if (x <= 1000000.00)
    {
        printf("\nThis envelope contains your job offer with starting salary $88,000.88. Please check back on Monday morning at 8am. Bye\n\n");
    }
    else
    {
        printf("\nThis envelope has your job offer starting at 1 million dollar annual. Please start any time you like.\n");
        printf("Please start any time you like. In the middle time our CTO wishes to have dinner with you. Have very nice evening Mr Sawyer. Bye\\nn");
    }
    return 0;
}