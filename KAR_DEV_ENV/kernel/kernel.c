#include "section.h"
#include "memory.h"

extern unsigned int _text_start;
extern unsigned int _text_end;
extern unsigned int _bss_start;
extern unsigned int _bss_end;

int _kernel_entry(void){
initBSS((unsigned int)&_bss_start,(unsigned int)&_bss_end-(unsigned int)&_bss_start);
for(;;){}
}
