	ORG	0000H
	R0RS:	MOV	R0, #00FH
START:		MOV	DPTR, #0100H
		MOV	A, R0
		CPL	A
		MOVC	A, @A+DPTR
		MOV	P2, A
		MOV	P1, #11110111B
		JNB	P1.7, KEYF
		JNB	P1.6, KEYE
		JNB	P1.5, KEYD
		JNB	P1.4, KEYC
		LJMP	NEXT1
	KEYF:	MOV	R0, #00FH
		LJMP	START
	KEYE:	MOV	R0, #00EH
		LJMP	START
	KEYD:	MOV	R0, #00DH
		LJMP	START
	KEYC:	MOV	R0, #00CH
		LJMP	START

	NEXT1:	MOV	P1, #11111011B
		JNB	P1.7, KEYB
		JNB	P1.6, KEY3
		JNB	P1.5, KEY6
		JNB	P1.4, KEY9
		LJMP	NEXT2
	KEYB:	MOV	R0, #00BH
		LJMP	START
	KEY3:	MOV	R0, #003H
		LJMP	START
	KEY6:	MOV	R0, #006H
		LJMP	START
	KEY9:	MOV	R0, #009H
		LJMP	START
	NEXT2:	MOV	P1, #11111101B
		JNB	P1.7, KEYA
		JNB	P1.6, KEY2
		JNB	P1.5, KEY5
		JNB	P1.4, KEY8
		LJMP	NEXT3
    	KEYA:	MOV	R0, #00AH
		LJMP	START
	KEY2:	MOV	R0, #002H
		LJMP	START
	KEY5:	MOV	R0, #005H
		LJMP	START
	KEY8:	MOV	R0, #008H
		LJMP	START
	NEXT3:	MOV	P1, #11111110B
		JNB	P1.7, KEY0
		JNB	P1.6, KEY1
		JNB	P1.5, KEY4
		JNB	P1.4, KEY7
		LJMP	START
	KEY0:	MOV	R0, #000H
		LJMP	START
	KEY1:	MOV	R0, #001H
		LJMP	START
	KEY4:	MOV	R0, #004H
		LJMP	START
	KEY7:	MOV	R0, #007H
		LJMP	START
		LJMP	R0RS
TABLE:
	ORG	0100H
		DB	00111111B
		DB	00000110B
		DB	01011011B
		DB	01001111B
		DB	01100110B
		DB	01101101B
		DB	01111101B
		DB	00000111B
		DB	01111111B
		DB	01101111B
		DB	01110111B
		DB	01111100B
		DB	00111001B
		DB	01011110B
		DB	01111001B
		DB	01110001B
	END
