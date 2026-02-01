.intel_syntax noprefix
.global _start
_start:
    # socket
    mov eax, 41
    mov edi, 2
    mov esi, 1
    xor edx, edx
    syscall
    mov r12, rax              # sockfd

    # building a &addr
    sub rsp, 16
    mov word  ptr [rsp+0], 2  # sin_family = AF_INET
        (PORT)
    mov word  ptr [rsp+2], 0x5000
         # (IP)
    mov dword ptr [rsp+4], 0x00000000

    mov qword ptr [rsp+8], 0         # sin_zero padding

    # bind(sockfd, &addr, 16)
    mov eax, 49
    mov rdi, r12
    mov rsi, rsp
    mov edx, 16
    syscall
        #listen(sockfd,0)
    mov eax,50
    mov rdi,r12
    xor rsi,rsi
    mov rsi,0
    xor edx,edx
    syscall

    mov eax,43 #accept
    syscall

     # Build "HTTP/1.0 200 OK\r\n\r\n" on stack
    # length = 19 bytes
    sub rsp, 24               #room for message
    mov rbx, rsp              # buf ptr

    # Store bytes (little-endian chunks)
      mov rax, 0x302e312f50545448
    mov qword ptr [rbx+0], rax

    mov rax, 0x0a0d4b4f20303032
    mov qword ptr [rbx+8], rax

    mov eax, 0x0a0d0a0d
    mov dword ptr [rbx+16], eax

    # write(client_fd, buf, 19)
    mov eax, 1
    mov rdi, r13
    mov rsi, rbx
    mov edx, 19
    syscall

    # exit(0)
    mov eax, 60
    xor edi, edi
    syscall



