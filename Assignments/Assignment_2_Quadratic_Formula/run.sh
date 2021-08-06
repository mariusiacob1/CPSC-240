
#!/bin/bash

#Program: Quadratic_Formula
#Author: Marius Iacob

#Delete some un-needed files
rm *.o
rm *.out

echo "**Assemble Quadratic.asm"
nasm -f elf64 -l Quadratic.lis -o Quadratic.o Quadratic.asm

echo "**Compile Second_degree.c"
gcc -c -Wall -m64 -no-pie -o Second_degree.o Second_degree.c -std=c11

echo "**Compile isfloat.cpp"
gcc -c -Wall -m64 -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17

echo "**Compile Quad_library.cpp"
gcc -c -Wall -m64 -fno-pie -no-pie -o Quad_library.o Quad_library.cpp -std=c++17

echo "**Link the object files using the gcc linker standard 2017"
gcc -m64 -no-pie -o finalquad.out -std=c++17 Quadratic.o Second_degree.o isfloat.o Quad_library.o

echo "**Run the program Root Calculator"
./finalquad.out

echo "**The script file will terminate"