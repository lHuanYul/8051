
        ORG     0000H
;
        MOV     TMOD,#00100000B 
        MOV     TH1,#230        
        MOV     TL1,#230        
        SETB    TR1             
;
        MOV     SCON,#11010000B 
;
LOOP:   JNB     P3.2,CASE1      
        JNB     P3.3,CASE1      
        JNB     P3.4,CASE2      
        JNB     P3.5,CASE2      
        AJMP    LOOP
;
CASE1:  SETB    TB8             
        CLR     TI              
        MOV     SBUF,#01        
        JNB     TI,$            
        CALL    DELAY           

        CLR     TB8             
        CLR     TI              
        MOV     SBUF,P3         
        JNB     TI,$            

        CLR     RI              
        CALL    DELAY           
        MOV     A,SBUF          
        MOV     C,ACC.0         
        MOV     P1.0,C          
        CALL    WAIT            
        AJMP    LOOP
;
CASE2:  SETB    TB8             
        CLR     TI              
        MOV     SBUF,#02        
        JNB     TI,$            
        CALL    DELAY           

        CLR     TB8             
        CLR     TI              
        MOV     SBUF,P3         
        JNB     TI,$            

        CLR     RI              
        CALL    DELAY           
        MOV     A,SBUF          
        MOV     C,ACC.0         
        MOV     P1.1,C          
        CALL    WAIT            
        AJMP    LOOP
;
WAIT:   CALL    DELAY
        MOV     A,P3
        CJNE    A,#11111111B,WAIT
        RET
;
DELAY:  MOV     R6,#25
DL1:    MOV     R7,#200
DL2:    DJNZ    R7,DL2
        DJNZ    R6,DL1
        RET
;
        END
