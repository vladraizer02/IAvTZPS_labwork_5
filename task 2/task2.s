;=======секция кода===============
section .text
extern printf ;библиотечная функция
global main
main: ;точка входа

; PROLOG
push rbp
mov rbp, rsp

; GET CPUID in EAX
mov eax, 7
mov ecx, 0
cpuid

test ebx, 19
je ADCX_ADOX_false
jne ADCX_ADOX_true

; PREPARE RETURN VALUE
mov rax, 0 ;return value from main rax=0

;EPILOG
pop rbp
ret

ADCX_ADOX_true:
mov rdi, msg1 ;arg_1
xor eax, eax ;arg_2
call printf wrt ..plt 
jmp MULX
ret

ADCX_ADOX_false:
mov rdi, msg0 ;arg_1
xor eax, eax ;arg_2
call printf wrt ..plt 
jmp MULX
ret

MULX:
mov rax, 0
mov eax, 7
mov ecx, 0
cpuid;

test ebx, 8
jnz MULX_true
jz MULX_false
ret

MULX_false:
mov rdi, msg2 ;arg_1
xor eax, eax ;arg_2
call printf wrt ..plt 
ret

MULX_true:
mov rdi, msg3 ;arg_1
xor eax, eax ;arg_2
call printf wrt ..plt 
ret

;=======секция констант===========
section .rodata
msg0: db "ADCX ADOX: false", 0x0a, 0 
msg1: db "ADCX ADOX: true", 0x0a, 0 
msg2: db "MULX: false", 0x0a, 0 
msg3: db "MULX: true", 0x0a, 0 
;=================================
