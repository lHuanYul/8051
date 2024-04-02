        ORG     0000H
                MOV     TMOD,#00010001B
                SETB    TR0
                MOV     DPTR, #0A00H
        STASE:  MOV     070H, #01111111B
                MOV     R3, #000H
START:          MOV     A, R3
                MOVC    A, @A+DPTR
                CPL	A
                MOV     P1, A
                MOV     P2, 070H
                LCALL   TIMER
                INC     R3
                MOV     A, 070H
                RR      A
                MOV     070H, A
                CJNE    A, #01111111B, START
                LJMP    STASE
TIMER:          MOV    R7, #10
        TIMRS:  MOV    TH0, #03CH
                MOV    TL0, #0B0H
        TIMW:   JB     TF0, TIMFI
                AJMP   TIMW
        TIMFI:  CLR    TF0
                DJNZ   R7, TIMRS
                RET
TABLE:
        ORG     0A00H
              	DB      10000001B
              	DB      01000010B
                DB      00100100B
                DB      00011000B
                DB      00011000B
                DB      00100100B
                DB      01000010B
                DB      10000001B
       END