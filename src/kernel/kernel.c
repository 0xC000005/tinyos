;�ļ���: kernel.c
;����: 0xC000005
;����: 2016/06/29
;����: �ں�

void main() {
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'X';
}
