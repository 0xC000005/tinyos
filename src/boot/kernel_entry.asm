;�ļ���: kernel_entry.asm
;����: 0xC000005
;����: 2016/06/29
;����: ������ת�Ƶ��ɸ߼�����(c����)��ʵ��.

global _start;
[bits 32]

_start:
    [extern kernel_main]
    call kernel_main
    jmp $
