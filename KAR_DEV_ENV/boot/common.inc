%ifndef __COMMON_INC_INCLUDED
%define	__COMMON_INC_INCLUDED

%define IMAGE_PMODE_BASE 0x100000
%define IMAGE_RMODE_BASE 0x8000
KernelImageName DB "KIMAGE     ",0x00,0x00

ImageSize	DD 0x00000000
ImageSizeBX	DW 0x0000
ImageSIzeES	DW 0x0000

%endif
