
        ORG     0000H
;
        MOV     TMOD,#00100000B 
        MOV     TH1,#230        
        MOV     TL1,#230        
        SETB    TR1             
;
        MOV     SCON,#11010000B 
LOOP:   SETB    SM2             
        CLR     RI              
        JNB     RI,$            
        MOV     A,SBUF          
        CJNE    A,#01,LOOP      

        CLR     SM2             
        CLR     RI              
        JNB     RI,$            
        MOV     A,SBUF          
        JNB     ACC.2,ON        
        JNB     ACC.3,OFF       
        AJMP    LOOP
;
ON:     CLR     P1.0            
        CLR     TI              
        MOV     SBUF,P1         
        JNB     TI,$            
        AJMP    LOOP
;
OFF:    SETB    P1.0            
        CLR     TI              
        MOV     SBUF,P1         
        JNB     TI,$            
        AJMP    LOOP
;
        END
