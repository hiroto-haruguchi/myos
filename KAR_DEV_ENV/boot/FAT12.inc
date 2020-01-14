%ifndef __FAT12_INC_INCLUDED__
%define __FAT12_INC_INCLUDED__

[BITS 16]
%include "boot/BPB.inc"

KernelImageCluster DW 0x0000
datasector	DW	0x0000
cluster		DW	0x0000
ImageSizeES	DW	0x0000
absoluteTrack	DB	0x00
absoluteSector	DB	0x00
absoluteHead	DB	0x00


%define ES_BASE_ADDR	0x07C0
%define RMODE_BASE_SEG	0x0800
%define RMODE_BASE_ADDR	0x0000
%define BX_FAT_ADDR	0x0200
%define	BX_RTDIR_ADDR	0x2600

Find_File:
	PUSHA
	MOV	BX, ES_BASE_ADDR
	MOV	ES, BX
	MOV	BX, WORD BX_RTDIR_ADDR
	MOV	CX, WORD [BPB_RootEntCnt]
	MOV	SI,KernelImageName
Finding_File:
	MOV	DI, BX
	PUSH	CX
	MOV	CX,0x000B
	PUSH	DI
	PUSH	SI
REPE	CMPSB
	POP	SI
	POP	DI
	JCXZ	Found_File
	ADD	BX, 0x0020
	POP	CX
	
	LOOP	Finding_File
	JMP	FAILURE


FAILURE:
	POPA
	MOV	AX,-1
	RET
Found_File:
	POP	CX
	MOV	WORD [KernelImageCluster], BX
	POPA
	MOV	AX,0
	RET

Load_File:
	PUSHA
	MOV	WORD [datasector], 0x0021
	MOV	BX, ES_BASE_ADDR
	MOV	ES,BX
	MOV	BX, [KernelImageCluster]
	ADD	BX, 0x001A
	MOV	AX, WORD [ES:BX]
	MOV	BX, RMODE_BASE_SEG
	MOV	ES,BX
	MOV	BX,RMODE_BASE_ADDR
	PUSH	BX
	MOV	WORD [cluster],AX

Load_Image:
	MOV	AX,WORD [cluster]
	POP	BX
	XOR	BX,BX
	CALL	ClusterLBA
	XOR	CX,CX
	MOV	CL,BYTE [BPB_SecPerClus]
	CALL	ReadSector
	MOV	BX,ES
	ADD	BX,0x0020
	MOV	ES,BX

ES_ADDED:
	PUSH	BX
	MOV	AX,WORD[cluster]
	MOV	CX,AX
	MOV	DX,AX
	SHR	DX,0x0001
	ADD	CX,DX
	PUSH	ES
	MOV	BX,ES_BASE_ADDR
	MOV	ES,BX
	MOV	BX,BX_FAT_ADDR
	ADD	BX,CX
	MOV	DX,WORD [ES:BX]
	POP	ES
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
	JB	Load_Image

ALL_DONE:
	POP	BX
	XOR	BX,BX
	MOV	BX,ES
	SUB	BX,RMODE_BASE_SEG
	MOV	WORD [ImageSizeES],BX
	POPA
	RET

ReadSector:
	MOV	DI,0x0005
SECTORLOOP:
	PUSH	AX
	PUSH	BX
	PUSH	CX
	CALL	LBACHS
	MOV	AH,0x02
	MOV	AL,0x01
	MOV	CH, BYTE [absoluteTrack]
	MOV	CL, BYTE [absoluteSector]
	MOV	DH, BYTE [absoluteHead]
	MOV	DL, BYTE [BS_DrvNum]
	INT	0x13
	JNC	SUCCESS
	MOV	AH,0x01
	INT	0x13

	XOR	AX,AX
	INT	0x13
	DEC	DI
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
ClusterLBA:
	SUB	AX,0x0002
	XOR	CX,CX
	MOV	CL, BYTE[BPB_SecPerClus]
	MUL	CX
	ADD	AX, WORD [datasector]
	RET
LBACHS:
	XOR	DX,DX
	DIV	WORD [BPB_SecPerTrk]
	INC	DL
	MOV	BYTE [absoluteSector],DL
	XOR	DX,DX
	DIV	WORD [BPB_NumHeads]
	MOV	BYTE [absoluteHead], DL
	MOV	BYTE [absoluteTrack], AL
	RET

%endif
