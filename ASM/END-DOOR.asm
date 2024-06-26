	ORG	0000H
		LJMP	START
	ORG	000BH
		LJMP	STOPT0
MAIN:
	ORG	0100H
	START:	MOV	P1, #0FFH	//BUTTON
		MOV	02EH, #000H	//BUTTON T07
		MOV	02FH, #000H	//BUTTON T8F
		MOV	030H, #0FFH
		MOV	031H, #0FFH
		MOV	032H, #0FFH
		MOV	033H, #0FFH
		MOV	P2, #0FFH	//LED
		MOV	020H, #00000000B
		MOV	021H, #000H	//BUFFER
		MOV	TMOD, #00010001B
		SETB	EA
		SETB	ET0
	START:	LCALL	RESET0
		LCALL	INPUT0
		LCALL	CHECK0
		LCALL	OUTPU0
		LJMP	START
RESET0:		CLR	021H.0
		RET
INPUT0:		MOV	P1, #11110111B
		JNB	P1.7, BUT0T
		CLR	02FH.7
		AJMP	BUT0N
	BUT0T:	JB	02FH.7, BUT0N
		SETB	02FH.7
		/* PRESS 1A COMMANDS */
		/*
		LCALL	MOVNUM
		MOV	030H, #000H
		*/
	BUT0N:	JNB	P1.6, BUT1T
		CLR	02FH.6
		AJMP	BUT1N
	BUT1T:	JB	02FH.6, BUT1N
		SETB	02FH.6
		/* PRESS 1B COMMANDS */
	BUT1N:	JNB	P1.5, BUT2T
		CLR	02FH.5
		AJMP	BUT2N
	BUT2T:	JB	02FH.5, BUT2N
		SETB	02FH.5
		/* PRESS 1C COMMANDS */
	BUT2N:	JNB	P1.4, BUT3T
		CLR	02FH.4
		AJMP	BUT3N
	BUT3T:	JB	02FH.4, BUT3N
		SETB	02FH.4
		/* PRESS 1D COMMANDS */
	BUT3N:	MOV	P1, #11111011B
		JNB	P1.7, BUT4T
		CLR	02FH.3
		AJMP	BUT4N
	BUT4T:	JB	02FH.3, BUT4N
		SETB	02FH.3
		/* PRESS 2A COMMANDS */
	BUT4N:	JNB	P1.6, BUT5T
		CLR	02FH.2
		AJMP	BUT5N
	BUT5T:	JB	02FH.2, BUT5N
		SETB	02FH.2
		/* PRESS 2B COMMANDS */
	BUT5N:	JNB	P1.5, BUT6T
		CLR	02FH.1
		AJMP	BUT6N
	BUT6T:	JB	02FH.1, BUT6N
		SETB	02FH.1
		/* PRESS 2C COMMANDS */
	BUT6N:	JNB	P1.4, BUT7T
		CLR	02FH.0
		AJMP	BUT7N
	BUT7T:	JB	02FH.0, BUT7N
		SETB	02FH.0
		/* PRESS 2D COMMANDS */
	BUT7N:	MOV	P1, #11111101B
		JNB	P1.7, BUT8T
		CLR	02EH.7
		AJMP	BUT8N
	BUT8T:	JB	02EH.7, BUT8N
		SETB	02EH.7
		/* PRESS 3A COMMANDS */
	BUT8N:	JNB	P1.6, BUT9T
		CLR	02EH.6
		AJMP	BUT9N
	BUT9T:	JB	02EH.6, BUT9N
		SETB	02EH.6
		/* PRESS 3B COMMANDS */
	BUT9N:	JNB	P1.5, BUTAT
		CLR	02EH.5
		AJMP	BUTAN
	BUTAT:	JB	02EH.5, BUTAN
		SETB	02EH.5
		/* PRESS 3C COMMANDS */
	BUTAN:	JNB	P1.4, BUTBT
		CLR	02EH.4
		AJMP	BUTBN
	BUTBT:	JB	02EH.4, BUTBN
		SETB	02EH.4
		/* PRESS 3D COMMANDS */
	BUTBN:	MOV	R2, #11111110B
		JNB	P1.7, BUTCT
		CLR	02EH.3
		AJMP	BUTCN
	BUTCT:	JB	02EH.3, BUTCN
		SETB	02EH.3
		/* PRESS 4A COMMANDS */
	BUTCN:	JNB	P1.6, BUTDT
		CLR	02EH.2
		AJMP	BUTDN
	BUTDT:	JB	02EH.2, BUTDN
		SETB	02EH.2
		/* PRESS 4B COMMANDS */
	BUTDN:	JNB	P1.5, BUTET
		CLR	02EH.1
		AJMP	BUTEN
	BUTET:	JB	02EH.1, BUTEN
		SETB	02EH.1
		/* PRESS 4C COMMANDS */
	BUTEN:	JNB	P1.4, BUTFT
		CLR	02EH.0
		AJMP	BUTFN
	BUTFT:	JB	02EH.0, BUTFN
		SETB	02EH.0
		/* PRESS 4D COMMANDS */
	BUTFN:	RET
	MOVNUM:	MOV	033H, 032H
		MOV	032H, 031H
		MOV	031H, 030H
		RET
CHECK0:		MOV	R2, 033H
		CJNE	R2, #001H, PWERR
		MOV	R2, 032H
		CJNE	R2, #002H, PWERR
		MOV	R2, 031H
		CJNE	R2, #003H, PWERR
		MOV	R2, 030H
		CJNE	R2, #004H, PWERR
		JNB	021H.1, PWERR
		SETB	021H.0, #000H
	PWERR:	RET
OUTPU0:		MOV	P0, 021H
		RET
STOPT0:		CLR	TF0
		MOV	TH0, #0FAH
		MOV	TL0, #067H
		JBC	021H.7, PWMEN
		SETB	021H.7
	PWMEN:	RET
DELAY:		MOV	R4, #1		;500,016*Xus
	DEL2:	MOV	R5, #4
	DEL1:	MOV	R6, #250
	DEL0:	MOV	R7, #248
		DJNZ	R7, $
		NOP
		DJNZ	R6, DEL0
		DJNZ	R5, DEL1
		DJNZ	R4, DEL2
		RET
TABLE:	
	ORG	1FF0H
		DB
	END