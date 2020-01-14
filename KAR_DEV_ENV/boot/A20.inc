[BITS 16]

Enable_A20:
	CLI
	CALL	A20wait
	MOV	AL,0xAD
	OUT	0x64,AL
	
	CALL	A20wait
	MOV	AL,0xD0
	OUT	0x64,AL
	
	CALL	A20wait2
	IN	AL,0x60
	PUSH	EAX
	
	CALL	A20wait
	MOV	AL,0xD1
	OUT	0x64,AL
	
	CALL	A20wait
	POP	EAX
	OR	AL,0x2
	OUT	0x60,AL
	
	CALL	A20wait
	MOV	AL,0xAE
	OUT	0x64,AL
	
	CALL	A20wait
	STI
	RET

A20wait:
	IN	AL,0x64
	TEST	AL,0x2
	JNZ	A20wait
	RET

A20wait2:
	IN	AL,0x64
	TEST	AL,0x1
	JZ	A20wait2
	RET
