format ELF64

public _start
new_line equ 0xA

msg db "hello from Denis!", new_line, 0 ; указатель
len = $-msg


_start:
   ; len = $-msg
   ; mov rax, 4 ; 4 - запись
   ; mov rbx, 1 ; 1 - вывод в консоль
   ; mov rcx, msg
   ; mov rdx, len
   ; int 0x80

    mov rax, msg
    call print_string

    call exit

print_string:
    push rax
    push rbx
    push rcx
    push rdx
    mov rcx, rax
    call length_string
    mov rdx, rax
    mov rax, 4 ; 4 - запись
    mov rbx, 1 ; 1 - вывод в консоль
    int 0x80
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret


length_string:
    push rdx
    xor rdx, rdx
    .next_iter:
        cmp [rax+rdx], byte 0
        je .close
        inc rdx
        jmp .next_iter
    .close:
        mov rax, rdx
        pop rdx
        ret
    ret


exit:
    mov rax, 1 ; 1 - выход
    mov rbx, 0 ; 0 - без ошибки
    int 0x80

    