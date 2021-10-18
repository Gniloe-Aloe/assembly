#!/bin/bash
 
nasm -f elf $1.asm
ld -m elf_i386 -s -o $1 $1.o
rm $1.o

echo "Файл" $1 "готов"

