;�ļ���: boot.asm
;����: 0xC000005
;����: 2016/06/29
;����: �������Ӳ�̵�MBR��X���������ص�0:0x1000,Ȼ���ƽ�����Ȩ��

org 0x7c00
KERNEL_OFFSET equ 0x1000
boot:
    mov [BOOT_DRIVE], dl
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE 
    call log16	; ��¼��־
    call load_kernel	; �����ں�
    call jump_to_pm	; ��ת������ģʽ
    jmp $

%include "boot/log.asm"	; ������־ģ��
%include "boot/disk.asm"	; ����Ӳ��ģ��
%include "boot/pm.asm"	; ���ر���ģʽģ��

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call log16

    mov bx, KERNEL_OFFSET
    mov dh, 16
    mov dl, [BOOT_DRIVE]
    call disk_load	; ����Ӳ������
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call log32
    call KERNEL_OFFSET 
    jmp $


BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Enter 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

times 510 - ($-$$) db 0
dw 0xaa55
