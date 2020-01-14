[BITS 16]
ORG 0x500
JMP	MAIN2

%include "boot/Print.inc"
%include "boot/common.inc"
%include "boot/Fat12.inc"
%include "boot/A20.inc"

%define NULL_DESC	0
%define CODE_DESC	0x8
%define	DATA_DESC	0x10

LoadingMsg	DB 0x0D, 0x0A,"Searching for Karnel...", 0x00, 0x00
FAI		DB 0x0D, 0x0A,"Not found",0x00,0x00
SUC		DB 0x0D, 0x0A,"Found Karnel",0x00,0x00
msgpmode	DB 0x0D, 0x0A,"Changing to protect mode",0x00,0x00

MAIN2:
	XOR	AX,AX
	XOR	BX,BX
	XOR	CX,CX
	XOR	DX,DX
	MOV	DS,AX
	MOV	ES,AX

	MOV	AX,0x9000
	MOV	SS,AX
	MOV	SP,0xFFFC
	CALL	_setup_gdt
	
	MOV	SI,LoadingMsg
	CALL	DisplayMessage ;Print.inc
	CALL	Find_File      ;FAT12.inc
	CMP	AX,0
	JZ	LoadKarnel
	MOV	SI,FAI
	CALL	DisplayMessage
	CLI
	HLT
LoadKarnel:
	MOV	SI,SUC
	CALL	DisplayMessage
	CALL	Load_File
EnableA20:
	CALL	Enable_A20
Enter_pmode:
	CLI
	MOV	EAX,CR0
	OR	EAX,0x00000001
	MOV	CR0,EAX
	JMP	CODE_DESC:Pmode_start

_setup_gdt:
	CLI
	PUSHA
	LGDT	[gdt_toc]
	STI
	POPA
	RET

_gdt:
	DW	0x0000
	DW	0x0000
	DW	0x0000
	DW	0x0000
	
	DB	0xFF
	DB	0xFF
	DW	0x0000
	DB	0x00
	DB	10011010b
	DB	11001111b
	DB	0

	DB	0xFF
	DB	0xFF
	DW	0x0000
	DB	0x00
	DB	10010010b
	DB	11001111b
	DB	0
_end_of_gdt:
gdt_toc:
	DW	_end_of_gdt-_gdt-1
	DD	_gdt


[BITS 32]
Pmode_start:
	MOV     AX,DATA_DESC
       	MOV     SS,AX
       	MOV     ES,AX
       	MOV     FS,AX
       	MOV     GS,AX
       	MOV     DS,AX
       	MOV     ESP,90000h
CopyKernelImage:
	XOR	EAX,EAX
	MOVZX	EAX,WORD[ImageSizeES]
	SHL	EAX,0x4
	MOV	DWORD [ImageSize],EAX
	
	CLD
	MOV	ESI,IMAGE_RMODE_BASE
	MOV	EDI,IMAGE_PMODE_BASE
	MOV	ECX,EAX
REP	MOVSD
	JMP	EXECUTE
;	
Failure2:
	HLT
	JMP	Failure2
EXECUTE:
	MOV	EBX,IMAGE_PMODE_BASE
	MOV	EBP,EBX
	XOR	EBX,EBX
	CALL	EBP
	ADD	ESP,4
	JMP	Failure2
