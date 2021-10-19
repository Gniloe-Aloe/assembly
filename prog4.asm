format ELF64 ;executable
public _start ;entry _start

section '.data' executable
next_line db "", 10, 0

section '.bss' writable
   bss_char rb 1



section '.text' executable
_start:
   xor rax, rax
   mov rbx, 10
   mov rcx, 20
   mov rax, 100
   sub rax, rbx
   call print_number
   call empty_line
   sub rax, rcx
   call print_number
   call empty_line
   
   call exit

   

section '.print_number' executable
;rax = number to print
print_number:
   push rax
   push rbx
   push rcx
   push rdx
   xor rcx, rcx
   .next_iter:
      cmp rax, 0 ; сравнение
      je .print_iter
      mov rbx, 10
      xor rdx, rdx
      div rbx ; rax в качестве числителя
      add rdx, '0'
      push rdx
      inc rcx
      jmp .next_iter
   .print_iter:
      cmp rcx, 0
      je .close
      pop rax
      call new_print_char
      
      dec rcx
      jmp .print_iter
   .close:
      pop rdx
      pop rcx
      pop rbx
      pop rax
      ret


section '.print_line' executable
print_line:
   push rax
   mov rax, 0xA
   call new_print_char
   pop rax
   ret


section '.empty_line' executable
empty_line:
   push rax
   push rbx
   push rcx
   push rdx
   mov rax, 4
   mov rbx, 1
   mov rcx, next_line
   mov rdx, 1
   int 0x80
   pop rdx
   pop rcx
   pop rbx
   pop rax
   ret


section '.print_char' executable
 ; rax = char
 print_char:
   push rax
   mov rax, 1 ; write
   mov rdi, 1 ; stdout 
   mov rsi, rsp ; rsp последнее значение в стеке
   mov rdx, 1 ; количество символов
   syscall
   pop rax
   ret


section '.new_print_char' executable 
; rax = char
new_print_char:
   push rax
   push rbx
   push rcx
   push rdx

   mov [bss_char], al

   mov rax, 4
   mov rbx, 1
   mov rcx, bss_char
   mov rdx, 1
   int 0x80

   pop rdx
   pop rcx
   pop rbx
   pop rax
   ret



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
