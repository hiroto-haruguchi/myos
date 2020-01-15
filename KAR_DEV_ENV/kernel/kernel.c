#include "section.h"
#include "memory.h"

extern unsigned int _TEXT_START;
extern unsigned int _TEXT_END;
extern unsigned int _BSS_START;
extern unsigned int _BSS_END;


int _kernel_entry(void){
initBSS(_BSS_START,_BSS_END-_BSS_START);
for(;;){}
}
