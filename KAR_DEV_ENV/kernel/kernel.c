#include "section.h"
#include "memory.h"

int _kernel_entry(void){
initBSS(bss_start,bss_end-bss_start);
for(;;){}
}
