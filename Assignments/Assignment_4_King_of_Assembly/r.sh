
#!/bin/bash

#Program: King of Assembly
#Author: Marius Iacob

echo "**Assemble interview.asm"
nasm -f elf64 -l interview.lis -o interview.o interview.asm

echo "**Compile main.cpp"
g++ -Wall -Wextra -Werror -c main.cpp -o main.o

echo "**Link the object files using the gcc linker standard 2017"
g++ -m64 -no-pie -o run.out -lstdc++ -std=c++17 interview.o main.o 

echo "**Run the program King of Assembly"
./run.out

echo "**The script file will terminate"

#Delete some un-needed files
rm *.o
rm *.out