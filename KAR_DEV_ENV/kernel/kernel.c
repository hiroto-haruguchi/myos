#include "section.h"
#include "memory.h"

int _kernel_entry(void){

initGLOBALSCOPE();
initBSS(_BSS_START ,_BSS_END - _BSS_START );
for(;;){}
}
