
#!/bin/bash

#Program: Area_of_Rectangle
#Author: Marius Iacob

#Delete some un-needed files
rm *.o
rm *.out

echo "**Assemble perimeter.asm"
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

echo "**Compile rectangle.cpp"
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17

echo "**Link the object files using the gcc linker standard 2017"
gcc -m64 -no-pie -o finalarea.out -std=c++17 perimeter.o rectangle.o 

echo "**Run the program Area of Rectangle"
./finalarea.out

echo "**The script file will terminate"