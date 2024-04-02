    ORG 0000H
START:  MOV P2,#00000011B
        ACALL   DELAY
        MOV P2,#10011111B
        ACALL   DELAY
        MOV P2,#00100101B
        ACALL   DELAY
        MOV P2,#00001101B
        ACALL   DELAY
        MOV P2,#10011001B
        ACALL   DELAY
        MOV P2,#01001001B
        ACALL   DELAY
        MOV P2,#01000001B
        ACALL   DELAY
        MOV P2,#00011111B
        ACALL   DELAY
        MOV P2,#00000001B
        ACALL   DELAY
        MOV P2,#00001001B
        ACALL   DELAY
        LJMP    START
DELAY:  MOV TMOD,#00000001B
        MOV     R7,#10
DEL01:  MOV     TH0,#03CH
        MOV     TL0,#0A0H
		SETB    TR0
DELW:   JB  TF0,DELFI
        AJMP    DELW
DELFI:  CLR TF0
        CLR TR0
        DJNZ R7,DEL01
        RET
    END

