	ORG	0000H
                MOV     TMOD,#00010001B
                SETB    TR0
        SSET:   MOV     R3, #000H
START:          MOV     A, R3
                MOV     DPTR, #1E00H
                MOVC    A, @A+DPTR
                CJNE    A, #0FFH, CONT
                AJMP    SSET
        CONT:   MOV     R2, A
                LCALL   TIMER
                INC     R3
                LJMP    START
TIMER:          MOV    R7, #20
        TIMRS:  MOV    TH0, #03CH
                MOV    TL0, #0B0H
        TIMW:   JB     TF0, TIMFI
                LCALL  LIGHT
                AJMP   TIMW
        TIMFI:  CLR    TF0
                DJNZ   R7, TIMRS
                RET
LIGHT:          MOV     DPTR, #1F00H
                MOV     070H, #01111111B
        LIGLO:  MOV     P2, 070H      //123
                MOV     A, R2
                MOVC    A, @A+DPTR
                CPL     A      //SW0&1
                MOV     P1, A         //ABC 1015
                LCALL   DELAY
                MOV     A, R2
                ADD     A, #020H
                MOV     R2, A
                MOV     A, 070H
                RR      A
                MOV     070H, A
                CJNE    A, #01111111B, LIGLO
                RET
DELAY:          SETB   TR1
                MOV    TH1, #0F8H
                MOV    TL1, #030H
        DELW:   JB     TF1,DELFI
                AJMP   DELW
        DELFI:  CLR    TF1
                CLR    TR1
                RET
TABLE:
	ORG	1E00H
		DB	00DH
		DB	001H
		DB	001H
		DB	005H
		DB	002H
		DB	009H
		DB	008H
		DB	004H
		DB	0FFH
	ORG	1F00H
		DB	00111100B
		DB	00011000B
		DB	00111110B
		DB	00111100B
		DB	00100110B
		DB	01111110B
		DB	00111100B
		DB	00111100B
		DB	00111100B
		DB	00111100B
		DB	00111100B
		DB	01100000B
		DB	00111100B
		DB	00000110B
		DB	01111110B
		DB	01111110B
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	10000001B
	ORG	1F20H
		DB	01111110B
		DB	00111000B
		DB	01111110B
		DB	01111110B
		DB	01100110B
		DB	01111110B
		DB	01111110B
		DB	01111110B
		DB	01111110B
		DB	01111110B
		DB	01111110B
		DB	01100000B
		DB	01111110B
		DB	00000110B
		DB	01111110B
		DB	01111110B
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	01000010B
       ORG    1F40H
		DB	01100110B
		DB	01111000B
		DB	00000110B
		DB	00000110B
		DB	01100110B
		DB	01100000B
		DB	01100000B
		DB	01100110B
		DB	01100110B
		DB	01100110B
		DB	01100110B
		DB	01100000B
		DB	01100000B
		DB	00000110B
		DB	01100000B
		DB	01100000B
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	00100100B
       ORG    1F60H
		DB	01100110B
		DB	00011000B
		DB	00111110B
		DB	01111110B
		DB	01111110B
		DB	01111100B
		DB	01111100B
		DB	00000110B
		DB	01111110B
		DB	01111110B
		DB	01100110B
		DB	01111100B
		DB	01100000B
		DB	00111110B
		DB	01111110B
		DB	01111110B
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	00011000B
       ORG    1F80H
		DB	01100110B
		DB	00011000B
		DB	01111100B
		DB	01111110B
		DB	01111110B
		DB	00111110B
		DB	01111110B
		DB	00000110B
		DB	01111110B
		DB	00111110B
		DB	01111110B
		DB	01111110B
		DB	01100000B
		DB	01111110B
		DB	01111110B
		DB	01111110B
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	00011000B
       ORG    1FA0H
		DB	01100110B
		DB	00011000B
		DB	01100000B
		DB	00000110B
		DB	00000110B
		DB	00000110B
		DB	01100110B
		DB	00000110B
		DB	01100110B
		DB	00000110B
		DB	01111110B
		DB	01100110B
		DB	01100000B
		DB	01100110B
		DB	01100000B
		DB	01100000B
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	00100100B
       ORG    1FC0H
		DB	01111110B
		DB	01111110B
		DB	01111110B
		DB	01111110B
		DB	00000110B
		DB	01111110B
		DB	01111110B
		DB	00000110B
		DB	01111110B
		DB	01111110B
		DB	01100110B
		DB	01111110B
		DB	01111110B
		DB	01111110B
		DB	01111110B
		DB	01100000B
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	01000010B
       ORG    1FE0H
		DB	00111100B
		DB	01111110B
		DB	01111110B
		DB	00111100B
		DB	00000110B
		DB	00111100B
		DB	00111100B
		DB	00000110B
		DB	00111100B
		DB	00111100B
		DB	01100110B
		DB	01111100B
		DB	00111100B
		DB	00111110B
		DB	01111110B
		DB	01100000B
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	0
		DB	10000001B
       
       END