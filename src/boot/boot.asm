;�ļ���: boot.asm
;����: 0xC000005
;����: 2016/06/29
;����: �������Ӳ�̵�MBR��X���������ص�0:0x1000,Ȼ���ƽ�����Ȩ��

[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ;

    mov [BOOT_DRIVE], dl ; Ӳ������
    mov bp, 0x9000; ��ʼ��ջ
    mov sp, bp

    mov bx, MSG_REAL_MODE 
    call print
    call print_nl

    call load_kernel ; ��Ӳ�̶�ȡ�ں�
    call switch_to_pm ; �ر��жϣ�����GDT��������ת������ģʽ
    jmp $
    
    
[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; ��ȡӲ��Ȼ��洢���ڴ� 0x1000
    mov dh, 31 ; 
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; ������Ȩ�����ں�
    jmp $ ; �ȴ��ں˽�������Ȩ


BOOT_DRIVE db 0 ;
MSG_REAL_MODE db "��ʼ���� 16-bit ʵģʽ...", 0
MSG_PROT_MODE db "���� 32-bit ����ģʽ...", 0
MSG_LOAD_KERNEL db "�����ں˵��ڴ�...", 0
MSG_RETURNED_KERNEL db "���ں˷���...", 0

; padding
times 510 - ($-$$) db 0
dw 0xaa55