       ORG 0000H
              MOV    TMOD, #00000001B
              SETB   TR0
              MOV    DPTR, #1F00H
       R0RS:  MOV    R0, #000H
START:        MOV    A, R0
              MOVC   A, @A+DPTR
              JZ     R0RS
              MOV    P2, A
              LCALL  TIMTR
              INC    R0
              LJMP   START
TIMTR:        MOV    R7, #20
       TIMRS: MOV    TH0, #03CH
              MOV    TL0, #0B0H
       TIMW:  JB     TF0, TIMFI
              AJMP   TIMW
       TIMFI: CLR    TF0
              DJNZ   R7, TIMRS
       TIMEN: RET

       ORG    1F00H
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
              	DB      000H

       END
