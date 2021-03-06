[BITS 16]

ORG	0x7c00

JMP	BOOT

BS_impBoot2	DB	0x90
BS_OEMName	DB	"MYOS    "
BPB_BytsPerSec	DW	0x0200
BPB_SecPerClus	DB	0x01
BPB_RsvdSecCnt	DW	0x0001
BPB_NumFATS	DB	0x02
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
BS_VolID	DD	0x20190825
BS_VolLab	DB	"MYOS    "
BS_FileSysType	DB	"FAT12   "

ImageName	DB	"Boot-bye Small World", 0x00
BOOT:
	CLI
	XOR	AX,AX
	MOV	DS,AX
	MOV	ES,AX
	MOV	FS,AX
	MOV	GS,AX

	XOR	BX,BX
	XOR	CX,CX
	XOR	DX,DX

	MOV	SS,AX
	MOV	SP,0xFFFC
	
LOAD_FAT:
	MOV	BX, WORD [BX_FAT_ADDR]
	ADD	AX, WORD [BPB_RsvdSecCnt]
	XCHG	AX,CX
	MOV	AX,WORD [BPB_FATSz16]
	MUL	WORD [BPB_NumFATS]

	XCHG	AX,CX
READ_FAT:
	CALL	ReadSectors
	ADD	BX,WORD [BPB_BytsPerSec]
	INC	AX
	DEC	CX
	JCXZ	FAT_LOADED
	JMP	READ_FAT

FAT_LOADED:
	HLT

DisplayMessage:
	PUSH	AX
	PUSH	BX

StartDispMsg:
	LODSB
	OR	AL,AL
	JZ	.DONE
	MOV	AH, 0x0E
	MOV	BH, 0x00
	MOV	BL, 0x07
	INT	0x10
	JMP	StartDispMsg
.DONE:
	POP	BX
	POP	AX
	RET

LBA2CHS:
	XOR	DX,DX
	DIV	WORD [BPB_SecPerTrk]
	INC	DL
	MOV	BYTE [physicalSector],DL
	XOR	DX,DX
	DIV	WORD [BPB_NumHeads]
	MOV	BYTE [physicalHead],DL
	MOV	BYTE [physicalTrack],AL
	RET

physicalSector 	DB 0x00
physicalHead	DB 0x00
physicalTrack	DB 0x00



ReadSectors:
	MOV	DI, 0x0005
SECTORLOOP:
	PUSH	AX
	PUSH	BX
	PUSH	CX
	CALL	LBA2CHS
	MOV	AH,0x02
	MOV	AL,0x01
	MOV	CH,BYTE [physicalTrack]
	MOV	CL,BYTE [physicalSector]
	MOV	DH,BYTE [physicalHead]
	MOV	DL,BYTE [BS_DrvNum]
	INT	0x13
	JNC	SUCCESS
	XOR	AX,AX
	INT	0x13
	DEC	DI
	POP	CX
	POP	BX
	POP	AX
	JNZ	SECTORLOOP
SUCCESS:
	POP	CX
	POP	BX
	POP	AX
	RET
BX_FAT_ADDR	DW 0x7E00

ResetFloppyDrive:
	MOV	AH,0x00
	MOV	DL,0x00
	INT	0x13
	JC FAILURE
	HLT
FAILURE:
	HLT

TIMES 510 - ($ - $$) DB 0


DW 0xAA55
