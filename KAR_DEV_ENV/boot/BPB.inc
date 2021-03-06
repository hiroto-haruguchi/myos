%ifndef __BPB_INC_INCLUDED__
%define __BPB_INC_INCLUDED__

[BITS 16]
BS_ORMName	DB	"MYOS    "
BPB_BytsPerSec	DW	0x0200
BPB_SecPerClus	DB	0x01
BPB_RsvdSecCnt	DW	0x0001
BPB_NumFATs	DB	0x02
BPB_RootEntCnt	DW	0x00E0
BPB_TotSec16	DW	0x0B40
BPB_Media	DB	0xF0
BPB_FATSz16	DW	0x0009
BPB_SecPerTrk	DW	0x0012
BPB_NumHeads	DW	0x0002
BPB_HiddSec	DD	0x00000000
BPB_TotSec32	DD	0x00000000

BS_DrvNum	DB	0x00
BS_Reserved1	DB	0x00
BS_BootSig	DB	0x29
BS_VolID	DD	0x20191018
BS_VolLab	DB	"MyOS    "
BS_FilSysType	DB	"FAT12   "

%endif

