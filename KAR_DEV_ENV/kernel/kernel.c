#include "../include/section.h"
#include "../include/memory.h"
int _kernel_entry(void){
initBSS(_BSS_START,_BSS_END-_BSS_START);
for(;;){}
}
