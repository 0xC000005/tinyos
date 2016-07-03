;�ļ���: log.asm
;����: 0xC000005
;����: 2016/07/02
;����: ������־������
;����: log16     ����: ʵģʽ�������־
;����: log16_ln  ����: ʵģʽ�»���
;����: log16_hex ����: ʵģʽ����16���Ƶ���ʽ��ӡ����.
;����: log32     ����: ����ģʽ�������־

log16:
    pusha
    
start:
    mov al, [bx]
    cmp al, 0 
    je done
    
    mov ah, 0x0e
    int 0x10 

    add bx, 1
    jmp start

done:
		;����
		mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    
    popa
    ret

log16_ln:
    pusha
    
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    
    popa
    ret

log16_hex:
    pusha
    
    mov cx, 0
    
hex_loop:
    cmp cx, 4
    je end
    
    mov ax, dx 
    and ax, 0x000f 
    add al, 0x30 
    cmp al, 0x39
    jle next
    add al, 7

next:
    mov bx, HEX_OUT + 5 
    sub bx, cx  
    mov [bx], al 
    ror dx, 4 

    add cx, 1
    jmp hex_loop

end:
    mov bx, HEX_OUT
    call log16
		
    popa
    ret

HEX_OUT:
    db '0x0000',0 

[bits 32] 

VIDEO_MEMORY equ 0xb8000
WHITE_OB_BLACK equ 0x0f

log32:
    pusha
    mov edx, VIDEO_MEMORY

log32_loop:
    mov al, [ebx]
    mov ah, WHITE_OB_BLACK

    cmp al, 0 
    je log32_done

    mov [edx], ax
    add ebx, 1
    add edx, 2

    jmp log32_loop

log32_done:
    popa
    ret
