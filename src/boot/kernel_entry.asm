;�ļ���: kernel_entry.asm
;����: 0xC000005
;����: 2016/06/29
;����: ������ת�Ƶ��ɸ߼�����(c����)��ʵ��.

[bits 32]
[extern main]
call main
jmp $
