[BITS 16]

ORG	0x7c00

JMP	BOOT

BS_jmpBoot2	DB	0x90
BS_OEMName	DB	"MYOS    "
BPB_BytsPerSec	DW	0x0200
BPB_SecPerClus	DB	0x01
BPB_RsvdSecCnt	DW	0x0001
BPB_NumFATS	DW	0x0002
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

ImageName	DB	"KAR     IMG",0x00,0x00
msgIMAGEOK	DB	"Loaging File system",0x00,0x00
msgIMAGEFAILED	DB	"Failed process",0x00,0x00

physicalSector  DB 0x00
physicalHead    DB 0x00
physicalTrack   DB 0x00
datasector      DW 0x0000
BX_RTDIR_ADDR   DW 0xA200
ES_IMAGE_ADDR   DW 0x0050
cluster         DB 0x00
BX_FAT_ADDR     DW 0x7E00


BOOT:
	CALL 	ResetFloppyDrive
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
	CALL	ResetFloppyDrive	
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
	JZ	LOAD_ROOT
	JMP	READ_FAT

LOAD_ROOT:
	MOV	BX,WORD [BX_RTDIR_ADDR]
	XOR	CX,CX
	MOV	WORD [datasector],AX
	XCHG	AX,CX
	MOV	AX,0x0020
	MUL	WORD [BPB_RootEntCnt]
	ADD	AX, WORD [BPB_BytsPerSec]
	DEC	AX
	DIV	WORD [BPB_BytsPerSec]
	XCHG	AX,CX
	ADD	WORD [datasector],CX
	
READ_ROOT:
	CALL	ReadSectors
	ADD	BX,WORD[BPB_BytsPerSec]
	INC	AX
	DEC	CX
	JCXZ	SEARCH_FILE
	JMP	READ_ROOT

SEARCH_FILE:
	MOV	BX,WORD [BX_RTDIR_ADDR]
	MOV	CX,WORD [BPB_RootEntCnt]
	MOV	SI,ImageName
BROWSE_ROOT:
	MOV	DI,BX
	PUSH	CX
	MOV	CX,0x000B
	PUSH	DI
	PUSH	SI
REPE	CMPSB
	POP	SI
	POP	DI
	JCXZ	BROWSE_FINISHED
	ADD	BX,0x0020
	POP	CX
	LOOP	BROWSE_ROOT
	JMP	FAILURE

BROWSE_FINISHED:
	POP	CX
	MOV	AX,WORD [BX+0x001A]
	MOV	BX,WORD [ES_IMAGE_ADDR]
	MOV	ES,BX
	XOR	BX,BX
	PUSH	BX
	MOV	WORD [cluster],AX

LOAD_IMAGE:
	MOV	AX,WORD [cluster]
	POP	BX
	CALL	ClusterLBA
	XOR	CX,CX
	MOV	CL,BYTE [BPB_SecPerClus]
	CALL	ReadSectors
	ADD	BX,0x200
	PUSH	BX

	MOV	AX,WORD [cluster]
	MOV	CX,AX
	MOV	DX,AX
	SHR	DX,0x0001
	ADD	CX,DX
	MOV	BX,WORD [BX_FAT_ADDR]
	ADD	BX,CX
	MOV	DX,WORD [BX]
	TEST	AX,0x0001
	JNZ	ODD_CLUSTER
EVEN_CLUSTER:
	AND	DX,0x0FFF
	JMP	LOCAL_DONE
ODD_CLUSTER:
	SHR	DX,0x0004
LOCAL_DONE:
	MOV	WORD [cluster],DX
	CMP	DX,0x0FF0
	JB	LOAD_IMAGE

ALL_DONE:
	MOV	SI,msgIMAGEOK
	CALL	DisplayMessage
	POP	BX
	PUSH	WORD [ES_IMAGE_ADDR]
	PUSH	WORD 0x0000
	RETF
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


ReadSectors:
	MOV	DI, 0x0005
	CALL	ResetFloppyDrive
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
	JZ	FAILURE
	POP	CX
	POP	BX
	POP	AX
	JNZ	SECTORLOOP
	INT	0x18
SUCCESS:
	POP	CX
	POP	BX
	POP	AX
	RET

ResetFloppyDrive:
	MOV	AH,0x00
	MOV	DL,0x00
	INT	0x13
	JC FAILURE
	RET
FAILURE:
	MOV	SI,ES_IMAGE_ADDR
	CALL	DisplayMessage
	HLT
ClusterLBA:
	SUB	AX,0x0002
	XOR	CX,CX
	MOV	CL,BYTE [BPB_SecPerClus]
	MUL	CX
	ADD	AX,WORD [datasector]
	RET

TIMES 510 - ($ - $$) DB 0


DW 0xAA55
