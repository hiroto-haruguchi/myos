extern unsigned int _text_start;
extern unsigned int _text_end;
extern unsigned int _bss_start;
extern unsigned int _bss_end;

unsigned int _TEXT_START;
unsigned int _TEXT_END;
unsigned int _BSS_START;
unsigned int _BSS_END;

void initGLOBALSCOPE();

void initGLOBALSCOPE(){

_TEXT_START	=_text_start;
_TEXT_END	=_text_end;
_BSS_START	=_bss_start;
_BSS_END	=_bss_end;

}
 
//_TEXT_START	= text_start;//c lang is do not permit to substitute global scope to  not constant

//_TEXT_END	= text_end;

//_BSS_START	= bss_start;

//_BSS_END	= bss_end;


