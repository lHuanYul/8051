	ORG	0000H
START:		MOV	A, #00110011B
LOOP:		MOV	P1, A
		LCALL	DELAY
		RL	A
		LJMP	LOOP
DELAY:		MOV	R4, #2		;500,016*Xus
	DEL2:	MOV	R5, #4
	DEL1:	MOV	R6, #250
	DEL0:	MOV	R7, #248
		DJNZ	R7, $
		NOP
		DJNZ	R6, DEL0
		DJNZ	R5, DEL1
		DJNZ	R4, DEL2
		RET
	END
