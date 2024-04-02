        ORG     0000H
                LJMP    MAIN
STOPT0:
        ORG     000BH
                MOV    	TH0, #03CH
                MOV    	TL0, #0ABH
                CLR     TF0
                INC     070H
                RETI
MAIN:
        ORG     0100H
                MOV     TMOD, #00010001B
                MOV     070H, #000H
                MOV     071H, #000H
                MOV     072H, #000H
                MOV     073H, #000H
                MOV     R0, #000H
                MOV     R2, #000H
                SETB    EA
                SETB    ET0
                SETB    TR0
                MOV    	TH0, #03CH
              	MOV    	TL0, #0B0H
START:          LCALL   CHECK
                LCALL   DISPL
                LJMP    START
CHECK:          MOV     A, 070H
                CJNE    A, #020, CHEND
                MOV     070H, #000
                INC     071H
                MOV     A, 071H
                CJNE    A, #060, CHEND
                MOV     071H, #000
                INC     072H
                MOV     A, 072H
                CJNE    A, #060, CHEND
                MOV     072H, #000
                INC     073H
                MOV     A, 073H
                CJNE    A, #024, CHEND
                MOV     073H, #000
        CHEND:  RET
DISPL:          MOV     R0, #073H
                MOV     R2, #000H
                MOV     DPTR, #1F00H
        DISLO:  MOV     A, @R0
                MOV     B, #010
                DIV     AB
                MOVC    A, @A+DPTR
                MOV     P1, R2
                MOV     P2, A
                LCALL   DELAY
                INC     R2
                MOV     A, B
                MOVC    A, @A+DPTR
                MOV     P1, R2
                MOV     P2, A
                LCALL   DELAY
                INC     R2
                DEC     R0
                CJNE    R0, #070H, DISLO
                RET
DELAY:          SETB    TR1
                MOV     TH1, #0F8H
                MOV     TL1, #030H
        DELW:   JB      TF1,DELFI
                AJMP    DELW
        DELFI:  CLR     TF1
                CLR     TR1
                RET
TABLE:
        ORG     1F00H
                DB      00111111B
                DB      00000110B
                DB      01011011B
                DB      01001111B
                DB      01100110B
                DB      01101101B
                DB      01111101B
                DB      00000111B
                DB      01111111B
                DB      01101111B
                DB      01110111B
                DB      01111100B
                DB      00111001B
                DB      01011110B
                DB      01111001B
                DB      01110001B
        ORG     1F10H
                DB      00000000B
        END
