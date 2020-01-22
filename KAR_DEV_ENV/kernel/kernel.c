#include "section.h"
#include "memory.h"
#define VRAM_TEXTMODE 0x000B8000

void displaySample(void);

int _kernel_entry(void){

 initGLOBALSCOPE();
 initBSS( _BSS_START ,_BSS_END - _BSS_START );
 displaySample();
 for(;;){}
}

void displaySample(void){
 unsigned short *vram_TextMode;
 vram_TextMode = ( unsigned short* ) VRAM_TEXTMODE;
 *vram_TextMode = ( 0x07 << 8 ) | 'A';
}
