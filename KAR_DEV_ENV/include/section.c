extern unsigned int _text_start;
extern unsigned int _text_end;
extern unsigned int _bss_start;
extern unsigned int _bss_end;

unsigned int _TEXT_START;
_TEXT_START	=	(unsigned int)&_text_start;

unsigned int _TEXT_END;
_TEXT_END	=	(unsigned int)&_text_end;

unsigned int _BSS_START;
_BSS_START	=	(unsigned int)&_bss_start;

unsigned int _BSS_END;
_BSS_END	=	(unsigned int)&_bss_end;


