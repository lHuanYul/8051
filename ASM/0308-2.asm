       ORG 0000H
              MOV    TMOD,#00010001B
START:        MOV    R6, #000
              LCALL  TIMER
              MOV    R6, #004
              LCALL  TIMER
              LJMP   START
TIMER:        MOV    R7, #020
              SETB   TR0
       TIMRS: MOV    TH0, #03CH
              MOV    TL0, #0B0H
       TIMW:  JB     TF0, TIMFI
              LCALL  LIGHT
              AJMP   TIMW
       TIMFI: CLR    TF0
              DJNZ   R7, TIMRS
              CLR    TR0
              RET

LIGHT:        MOV    071H, #11110111B
              MOV    070H, R6
       LIGLO: MOV    P1, 071H
              MOV    A, 070H
              MOV    DPTR, #1FA0H
              MOVC   A, @A+DPTR
              MOV    DPTR, #1F00H
              MOVC   A, @A+DPTR
              CPL    A      //SW0&1
              MOV    P2, A
              LCALL  DELAY
              INC    070H
              MOV    A, 071H
              RR     A
              MOV    071H, A
              CJNE   A, #01111111B, LIGLO
              RET
              
DELAY:        SETB   TR1
              MOV    TH1, #0F8H
              MOV    TL1, #030H
       DELW:  JB     TF1,DELFI
              AJMP   DELW
       DELFI: CLR    TF1
              CLR    TR1
              RET

TABLE:
       ORG    1FA0H
              	DB      00DH
              	DB      001H
              	DB      001H
              	DB      005H
              	DB      002H
              	DB      009H
              	DB      008H
              	DB      004H
       ORG    1F00H
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
       ORG    1F10H
              	DB      00000000B
       END