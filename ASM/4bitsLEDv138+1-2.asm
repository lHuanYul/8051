       	ORG 	0000H
              	MOV    	TMOD,#00010001B
              	MOV    	R6, #000
START:        	MOV    	R6, #000
              	LCALL  	TIMER
              	MOV    	R6, #004
              	LCALL  	TIMER
              	LJMP   	START
TIMER:        	MOV    	R7, #020
              	SETB   	TR0
       	TIMRS: 	MOV    	TH0, #03CH
              	MOV    	TL0, #0B0H
       	TIMW:  	JB     	TF0, TIMFI
              	LCALL  	LIGHT
              	AJMP   	TIMW
       	TIMFI: 	CLR    	TF0
              	DJNZ   	R7, TIMRS
              	CLR    	TR0
              	RET
LIGHT:        	MOV    	071H, #11111100B
              	MOV    	070H, R6
       	LIGLO: 	MOV    	P1, 071H
              	MOV    	A, 070H
              	MOV    	DPTR, #1FA0H
              	MOVC   	A, @A+DPTR
              	MOV    	DPTR, #1F00H
              	MOVC   	A, @A+DPTR
              	MOV    	P2, A
              	LCALL  	DELAY
              	INC    	070H
              	MOV    	A, 071H
              	INC    	A
              	MOV    	071H, A
              	CJNE   	A, #00000000B, LIGLO
              	RET
DELAY:        	SETB   	TR1
              	MOV    	TH1, #0F8H
              	MOV    	TL1, #030H
       	DELW:  	JB     	TF1,DELFI
              	AJMP   	DELW
       	DELFI: 	CLR    	TF1
              	CLR    	TR1
              	RET
TABLE:
       	ORG	1FA0H
              	DB      00DH
              	DB      001H
              	DB      001H
              	DB      005H
              	DB      002H
              	DB      009H
              	DB      008H
              	DB      004H
       	ORG	1F00H
              	DB      11000000B
              	DB      11111001B
              	DB      10100100B
              	DB      10110000B
              	DB      10011001B
              	DB      10010010B
              	DB      10000010B
              	DB      11111000B
              	DB      10000000B
              	DB      10010000B
              	DB      10001000B
              	DB      10000011B
              	DB      11000110B
              	DB      10100001B
              	DB      10000110B
              	DB      10001110B
       	ORG	1F10H
              	DB      11111111B
       	END