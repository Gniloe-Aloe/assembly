format ELF64 ;executable
public _start ;entry _start

section '.data' executable
msg db "Hello", 0xA, 0 ; 10 - next line, 0 - end string
msg1 db "world!", 10, 0

section '.text' executable
_start:
   mov rax, msg
   call print_string
   mov rax, msg1
   call print_string
   call exit

section '.print_string' executable
 ; rax = string  
print_string:
   push rax
   push rbx
   push rcx
   push rdx
   mov rcx, rax
   call length_string
   mov rdx, rax
   mov rax, 4
   mov rbx, 1
   int 0x80
   pop rdx
   pop rcx
   pop rbx
   pop rax
   ret


section '.length_string' executable
length_string:
   push rdx
   xor rdx, rdx ; обнуление
   .next_iter:
      cmp [rax+rdx], byte 0 ; если байт = 0
      je .close
      inc rdx
      jmp .next_iter
   .close:
      mov rax, rdx
      pop rdx
      ret

section '.exit' executable
exit:
   mov rax, 1 ;выход
   mov rbx, 0 ;возвращаем значение
   int 0x80
