GLODEF:	//GLOBAL ADRESS
	CONTROLDEUID	EQU	001H
	CONTROLCDSTR	EQU	037H
	DOORDEUID	EQU	002H
	DOORMOTION	EQU	020H
	CLOCKDEUID	EQU	003H
	CLOCKSMODE	EQU	020H
	CLOCKMONTH	EQU	030H
	CLOCKDATE	EQU	031H
	CLOCKHOUR	EQU	032H
	CLOCKMINUTE	EQU	033H
	CLOCKALM01M	EQU	040H
	CLOCKALM01H	EQU	041H
	CLOCKALM02M	EQU	042H
	CLOCKALM02H	EQU	043H
	CLOCKALM03M	EQU	044H
	CLOCKALM03H	EQU	045H
	CLOCKALM04M	EQU	046H
	CLOCKALM04H	EQU	047H
	WINDOWDEUID	EQU	004H
	WINDOWMOTION	EQU	020H
	RINGDEUID	EQU	005H
	RINGMOTION	EQU	020H
	RINGSNONCH	EQU	038H
	//SERIAL SETUP
	;DEVICEID	EQU	0XXH
	CANRETCODE	EQU	0FEH
	CNTRETCODE	EQU	0FFH
	REPLACECODE	EQU	000H
	CLRCODE		EQU	001H
	SETBCODE	EQU	002H
	CPLCODE		EQU	003H
	SPRSERIAL	EQU	P3
	SPBSERIALTR	EQU	SPRSERIAL.2
	STATE		EQU	070H
	MOTION		EQU	071H
	POSITION	EQU	072H
	STORESSTART	EQU	078H
	STORESEND	EQU	07FH
	STORE0START	EQU	060H
	STORE1START	EQU	068H
	STORE2START	EQU	050H
	STORE3START	EQU	058H
	FLSSERIALMO	EQU	02EH
	FLBSERIALRET	EQU	FLSSERIALMO.0
	FLSSERIAL	EQU	02FH
	FLBRUNEMPTY	EQU	FLSSERIAL.0
	FLBWRITING	EQU	FLSSERIAL.1
	FLBSTORESTR	EQU	FLSSERIAL.2
	FLBSTORE0TR	EQU	FLSSERIAL.4
	FLBSTORE1TR	EQU	FLSSERIAL.5
	FLBSTORE2TR	EQU	FLSSERIAL.6
	FLBSTORE3TR	EQU	FLSSERIAL.7
	SFRPORT0	EQU	080H
	SFRPORT1	EQU	090H
	SFRPORT2	EQU	0A0H
	//DEFINE TIMER 2 (PWM)
	T2CON		EQU	0C8H
	TF2		EQU	T2CON.7
	TR2		EQU	T2CON.2
	CPRL2		EQU	T2CON.0
	RCAP2L		EQU	0CAH
	RCAP2H		EQU	0CBH
	TL2		EQU	0CCH
	TH2		EQU	0CDH
	ET2		EQU	IE.5
DEUDEF:	//DEFINE CONST
	DEVICEID	EQU	005H
	ERRORTIME	EQU	10
	//DEFINE ADRESS
	TIMEOUT		EQU	074H
	FLSMUSICMO	EQU	020H	;GLOBAL
	FLBFORCEOFF	EQU	FLSMUSICMO.0
	FLBKEEPPLAY	EQU	FLSMUSICMO.1
	MUSICDPH	EQU	030H
	MUSICDPL	EQU	031H
	SCALEPOSSELH	EQU	032H
	SCALEPOSSELL	EQU	033H
	BEATTIMELOOP	EQU	034H
	BEATTIMETH	EQU	035H
	BEATTIMETL	EQU	036H
	SONGCHOSE	EQU	038H	;GLOBAL
	OPSNORMAL	EQU	P2
	OPBMAINRESET	EQU	OPSNORMAL.6
	OPBSPEAKEROUT	EQU	OPSNORMAL.7
	ONTESTTAB	EQU	1A00H
	HARPOTTABL	EQU	1A10H
	WAKEUPTAB	EQU	1A40H
	STARWARTAB	EQU	1A70H
	ORG	0000H
		LJMP	START
	ORG	000BH
		LJMP	EAET0
	ORG	001BH
		LJMP	EAET1
	ORG	0023H
		LJMP	DSPSTA
	ORG	002BH
		LJMP	EAET2
	ORG	0040H
START:		LCALL	DSRSET
	//TIMER2 SETUP
		MOV	T2CON, #000H
	//NORMAL SETUP
		MOV	TIMEOUT, #000
		MOV	TH0, #03CH
		MOV	TL0, #0B0H
		MOV	TMOD, #00010001B
		MOV	FLSMUSICMO, #000H
		MOV	OPSNORMAL, #0FFH
		MOV	SONGCHOSE, #001
		SETB	ET0
		SETB	ET1
		SETB	ET2
		SETB	EA
		SETB	TR0
MALOOP:		LCALL	DSSMOV
	//MUSIC CHOOSE
		MOV	A, SONGCHOSE
		CJNE	A, #001, MUCN01
		MOV	DPTR, #ONTESTTAB
		AJMP	MUCNST
	MUCN01:	CJNE	A, #002, MUCN02
		MOV	DPTR, #HARPOTTABL
		AJMP	MUCNST
	MUCN02:	CJNE	A, #003, MUCN03
		MOV	DPTR, #WAKEUPTAB
		AJMP	MUCNST
	MUCN03:	CJNE	A, #004, MUCN04
		MOV	DPTR, #STARWARTAB
		AJMP	MUCNST
	MUCN04:	CJNE	A, #005, MUCN05
		MOV	DPTR, #ONTESTTAB
		AJMP	MUCNST
	MUCN05:	CJNE	A, #006, MUCN06
		MOV	DPTR, #ONTESTTAB
		AJMP	MUCNST
	MUCNST:	JB	FLBKEEPPLAY, MUSSET
		MOV	SONGCHOSE, #000
		AJMP	MUSSET
	MUCN06:	MOV	SONGCHOSE, #000
		LJMP	MALOEN
MUSSET:	//MUSIC SETTINGS
		MOV	MUSICDPH, DPH
		MOV	MUSICDPL, DPL
		CLR	FLBFORCEOFF
		MOV	SCALEPOSSELH, #000
		MOV	SCALEPOSSELL, #000
		LCALL	RDSCAL
		JZ	MUSECN
		LJMP	MALOEN
	MUSECN:	LCALL	RDSCAL
		MOV	BEATTIMELOOP, A
		LCALL	RDSCAL
		MOV	BEATTIMETH, A
		LCALL	RDSCAL
		MOV	BEATTIMETL, A
MURULO:	//MUSIC LOOP
		//SCALE	SET
		MOV	DPH, MUSICDPH
		MOV	DPL, MUSICDPL
		LCALL	RDSCAL
		CJNE	A, #000H, MURUC1
		AJMP	MURUC3
	MURUC1:	CJNE	A, #0FFH, MURUC2
		LJMP	MALOEN
	MURUC2:	MOV	B, A
		MOV	DPTR, #1F07H
		MOVC	A, @A+DPTR
		MOV	RCAP2H, A
		MOV	A, B
		MOV	DPTR, #1EFFH
		MOVC	A, @A+DPTR
		MOV	RCAP2L, A
		MOV	TH2, RCAP2H
		MOV	TL2, RCAP2L
		SETB	TR2
		//SCALE DELAY
	MURUC3:	MOV	DPH, MUSICDPH
		MOV	DPL, MUSICDPL
		LCALL	RDSCAL
		MOV	TH1, BEATTIMETH
		MOV	TL1, BEATTIMETL
		MOV	R0, BEATTIMELOOP
		SETB	TR1
	SCADEL:	JNB	FLBFORCEOFF, MURUCN
		CLR	FLBFORCEOFF
		CLR	TR1
		CLR	TR2
		SETB	OPBSPEAKEROUT
		LJMP	MALOEN
	MURUCN:	JNZ	SCADEL
		CLR	TR1
		CLR	TR2
		SETB	OPBSPEAKEROUT
		LJMP	MURULO
	MALOEN:	LJMP	MALOOP
EAET0:		CLR	TF0
		MOV	TH0, #03CH
		MOV	TL0, #0B0H
		PUSH	000H
		JB	SPBSERIALTR, SERNOR
		INC	TIMEOUT
		MOV	R0, TIMEOUT
		CJNE	R0, #ERRORTIME, ET0CH0
		CLR	OPBMAINRESET
		AJMP	ET0END
	ET0CH0:	CJNE	R0, #ERRORTIME+2, ET0END
		SETB	OPBMAINRESET
	SERNOR:	MOV	TIMEOUT, #000
	ET0END:	POP	000H
		RETI
EAET1:		CLR	TF1
		MOV	TH1, BEATTIMETH
		MOV	TL1, BEATTIMETL
		DJNZ	R0, ET1END
		MOV	R0, BEATTIMELOOP
		DEC	A
	ET1END:	RETI
EAET2:		CLR	TF2
		JBC	OPBSPEAKEROUT, EAET2E
		SETB	OPBSPEAKEROUT
	EAET2E:	RETI
DSPSTA:		PUSH	ACC
		PUSH	PSW
		PUSH	000H
	//CHECK TI/RI
		JBC	RI, DSPRST
		CLR	TI
		LJMP	DSPSST
	//RECEIVE PROCESS
	DSPRST:	MOV	R0, STATE
		MOV	A, SBUF
		//RECEIVE DEPUTY CHECK
		CJNE	R0, #000H, DSPRMO
		CJNE	A, #DEVICEID, DSPRCN
		MOV	STATE, #001H
		CLR	SM2
	DSPRCN:	LJMP	DSPEND
		//RECEIVE MOTION
	DSPRMO:	CJNE	R0, #001H, DSPRPO
		;IF CAN SEND
		CJNE	A, #CANRETCODE, DSPRM0
		;IF WRITTING
		JNB	FLBWRITING, DSPSIT
		LJMP	DSPIWR
	DSPSIT:	LJMP	DSPSID
		;IF CANT SEND
	DSPRM0:	CJNE	A, #CNTRETCODE, DSPRM1
		MOV	STATE, #000H
		SETB	SM2
		LJMP	DSPEND
		;MOTION STORE
	DSPRM1:	MOV	STATE, #002H
		MOV	MOTION, A
		LJMP	DSPEND
		//RECEIVE POSITION
	DSPRPO:	CJNE	R0, #002H, DSPRVL
		MOV	STATE, #003H
		MOV	POSITION, A
		LJMP	DSPEND
		//RECEIVE VALUE
	DSPRVL:	CJNE	R0, #003H, DSPRER
		MOV	STATE, #001H
		AJMP	DSPRVN
		//RECEIVE ERROR
	DSPRER:	MOV	STATE, #00FH
		LJMP	DSPEND
		//VALUE WRITE
	DSPRVN:	PUSH	001H
		MOV	R0, MOTION
		MOV	R1, POSITION
		;SFRPORT0 WRITE
	DSPRP0:	CJNE	R1, #SFRPORT0, DSPRP1
		CJNE	R0, #REPLACECODE, DSPR00	;REPLACE VALUE
		MOV	SFRPORT0, A
		LJMP	DSPRVE
	DSPR00:	CJNE	R0, #CLRCODE, DSPR01	;AND VALUE (CLR
		ANL	A, SFRPORT0
		MOV	SFRPORT0, A
		LJMP	DSPRVE
	DSPR01:	CJNE	R0, #SETBCODE, DSPR02	;OR VALUE (SETB
		ORL	A, SFRPORT0
		MOV	SFRPORT0, A
		LJMP	DSPRVE
	DSPR02:	CJNE	R0, #CPLCODE, DSPR0E	;XOR VALUE (CPL
		XRL	A, SFRPORT0
		MOV	SFRPORT0, A
	DSPR0E:	LJMP	DSPRVE
		;SFRPORT1 WRITE
	DSPRP1:	CJNE	R1, #SFRPORT2, DSPRP2
		CJNE	R0, #REPLACECODE, DSPR10	;REPLACE VALUE
		MOV	SFRPORT2, A
		LJMP	DSPRVE
	DSPR10:	CJNE	R0, #CLRCODE, DSPR11	;AND VALUE (CLR
		ANL	A, SFRPORT2
		MOV	SFRPORT2, A
		LJMP	DSPRVE
	DSPR11:	CJNE	R0, #SETBCODE, DSPR12	;OR VALUE (SETB
		ORL	A, SFRPORT2
		MOV	SFRPORT2, A
		LJMP	DSPRVE
	DSPR12:	CJNE	R0, #CPLCODE, DSPR1E	;XOR VALUE (CPL
		XRL	A, SFRPORT2
		MOV	SFRPORT2, A
	DSPR1E:	LJMP	DSPRVE
		;SFRPORT2 WRITE
	DSPRP2:	CJNE	R1, #SFRPORT2, DSPREX
		CJNE	R0, #REPLACECODE, DSPR20	;REPLACE VALUE
		MOV	SFRPORT2, A
		LJMP	DSPRVE
	DSPR20:	CJNE	R0, #CLRCODE, DSPR21	;AND VALUE (CLR
		ANL	A, SFRPORT2
		MOV	SFRPORT2, A
		LJMP	DSPRVE
	DSPR21:	CJNE	R0, #SETBCODE, DSPR22	;OR VALUE (SETB
		ORL	A, SFRPORT2
		MOV	SFRPORT2, A
		LJMP	DSPRVE
	DSPR22:	CJNE	R0, #CPLCODE, DSPR2E	;XOR VALUE (CPL
		XRL	A, SFRPORT2
		MOV	SFRPORT2, A
	DSPR2E:	LJMP	DSPRVE
		;OTHER WRITE
	DSPREX:	CJNE	R0, #REPLACECODE, DSPRV9
		MOV	@R1, A
		AJMP	DSPRVE
	DSPRV9:	CJNE	R0, #CLRCODE, DSPRVA
		ANL	A, @R1	;CLR 1011
		MOV	@R1, A
		AJMP	DSPRVE
	DSPRVA:	CJNE	R0, #SETBCODE, DSPRVB
		ORL	A, @R1	;SETB 0100
		MOV	@R1, A
		AJMP	DSPRVE
	DSPRVB:	CJNE	R0, #CPLCODE, DSPRVE
		XRL	A, @R1	;CPL 0100
		MOV	@R1, A
		AJMP	DSPRVE
	DSPRVE:	MOV	MOTION, #0FFH
		MOV	POSITION, #0FFH
		POP	001H
		LJMP	DSPEND
	//SEND PROCESS START
		//RUN EMPTY
	DSPSST:	JNB	FLBRUNEMPTY, DSPSMO
		CLR	FLBRUNEMPTY
		AJMP	DSPEND
		//SEND ID
	DSPSID:	MOV	STATE, #011H
		MOV	POSITION, #STORESSTART+1
		LCALL	DL400C
		MOV	SBUF, STORESSTART
		LCALL	DL400C
		LJMP	DSPEND
		//IF WRITING
	DSPIWR:	MOV	STATE, #01AH
		LCALL	DL400C
		MOV	SBUF, #000
		LCALL	DL400C
		LJMP	DSPEND
		//SEND MOTION
	DSPSMO:	MOV	R0, STATE
		CJNE	R0, #011H, DSPSPO
		MOV	STATE, #012H
		;IF REACH END
		MOV	R0, POSITION
		CJNE	R0, #STORESEND, DSPSM0
		AJMP	DSPSFI
		;IF SEND FINISH
	DSPSM0:	MOV	A, @R0
		CJNE	A, #CANRETCODE, DSPSM1
		AJMP	DSPSFI
	DSPSM1:	CJNE	A, #CNTRETCODE, DSPSNM
		AJMP	DSPSFI
		//SEND POSITION AND VALUE
	DSPSPO:	CJNE	R0, #012H, DSPSVA
		MOV	STATE, #013H
		AJMP	DSPSNM
	DSPSVA:	CJNE	R0, #013H, DSPSWR
		MOV	STATE, #011H
		AJMP	DSPSNM
		//IF WRITING SEND CNTRETCODE
	DSPSWR:	CJNE	R0, #01AH, DSPSER
		AJMP	DSPSF0
		//SEND ERROR
	DSPSER:	MOV	STATE, #01FH
		AJMP	DSPEND
		//SEND NORMAL
	DSPSNM:	MOV	R0, POSITION
		INC	POSITION
		MOV	SBUF, @R0
		LCALL	DL400C
		AJMP	DSPEND
		//SEND FINISH
	DSPSFI:	MOV	R0, #STORESSTART
		LCALL	DSSCLR
		CLR	FLBSTORESTR
	DSPSF0:	MOV	STATE, #000H
		MOV	POSITION, #0FFH
		SETB	FLBRUNEMPTY
		SETB	SM2
		MOV	SBUF, #CNTRETCODE
	DSPEND:	POP	000H
		POP	PSW
		POP	ACC
		RETI
DSRSET:		MOV	SCON, #10110000B
		SETB	ES
		MOV	STATE, #000H
		MOV	MOTION, #0FFH
		MOV	POSITION, #0FFH
		MOV	FLSSERIALMO, #000H
		MOV	FLSSERIAL, #000H
		MOV	R0, #STORESSTART
		LCALL	DSSCLR
		MOV	R0, #STORE0START
		LCALL	DSSCLR
		MOV	R0, #STORE1START
		LCALL	DSSCLR
		MOV	R0, #STORE2START
		LCALL	DSSCLR
		MOV	R0, #STORE3START
		LCALL	DSSCLR
		MOV	SPRSERIAL, #0FFH
DSSCLR:		MOV	A, #STORESEND-STORESSTART+1
	STOCLL:	MOV	@R0, #CNTRETCODE
		INC	R0
		DJNZ	ACC, STOCLL
		RET
DSSMOV:		;SERIAL STORE MOVE 0>S
		JB	FLBSTORESTR, DSSSEN
		JNB	FLBSTORE0TR, DSSSEN
		MOV	R0, #STORESSTART
		MOV	R1, #STORE0START
		MOV	R2, #STORESEND+1-STORESSTART
		SETB	FLBWRITING
		SETB	FLBSTORESTR
	DSSSLO:	MOV	A, @R1
		MOV	@R0, A
		INC	R0
		INC	R1
		DJNZ	R2, DSSSLO
		MOV	R0, #STORE0START
		LCALL	DSSCLR
		CLR	FLBSTORE0TR
		CLR	FLBWRITING
	DSSSEN:	JNB	FLBSTORESTR, DSSTRI
		CLR	SPBSERIALTR
		AJMP	DSSTRE
	DSSTRI:	SETB	SPBSERIALTR
		//SERIAL STORE MOVE 1>0
	DSSTRE:	JB	FLBSTORE0TR, DSS0EN
		JNB	FLBSTORE1TR, DSS0EN
		SETB	FLBSTORE0TR
		CLR	FLBSTORE1TR
		MOV	R0, #STORE0START
		MOV	R1, #STORE1START
		MOV	R2, #STORESEND+1-STORESSTART
	DSS0LO:	MOV	A, @R1
		MOV	@R0, A
		INC	R0
		INC	R1
		DJNZ	R2, DSS0LO
		MOV	R0, #STORE1START
		LCALL	DSSCLR
	DSS0EN:	//SERIAL STORE MOVE 2>1
		JB	FLBSTORE1TR, DSS1EN
		JNB	FLBSTORE2TR, DSS1EN
		SETB	FLBSTORE1TR
		CLR	FLBSTORE2TR
		MOV	R0, #STORE1START
		MOV	R1, #STORE2START
		MOV	R2, #STORESEND+1-STORESSTART
	DSS1LO:	MOV	A, @R1
		MOV	@R0, A
		INC	R0
		INC	R1
		DJNZ	R2, DSS1LO
		MOV	R0, #STORE2START
		LCALL	DSSCLR
	DSS1EN:	//SERIAL STORE MOVE 3>2
		JB	FLBSTORE2TR, DSS2EN
		JNB	FLBSTORE3TR, DSS2EN
		SETB	FLBSTORE2TR
		CLR	FLBSTORE3TR
		MOV	R0, #STORE2START
		MOV	R1, #STORE3START
		MOV	R2, #STORESEND+1-STORESSTART
	DSS2LO:	MOV	A, @R1
		MOV	@R0, A
		INC	R0
		INC	R1
		DJNZ	R2, DSS2LO
		MOV	R0, #STORE3START
		LCALL	DSSCLR
	DSS2EN:	RET
DSSWRI:		JB	FLBSTORE0TR, STPOS0
		MOV	R0, #STORE0START
		SETB	FLBSTORE0TR
		AJMP	DSSWSE
	STPOS0:	JB	FLBSTORE1TR, STPOS1
		MOV	R0, #STORE1START
		SETB	FLBSTORE1TR
		AJMP	DSSWSE
	STPOS1:	JB	FLBSTORE2TR, STPOS2
		MOV	R0, #STORE2START
		SETB	FLBSTORE2TR
		AJMP	DSSWSE
	STPOS2:	JB	FLBSTORE3TR, STPOSE
		MOV	R0, #STORE3START
		SETB	FLBSTORE3TR
		AJMP	DSSWSE
	STPOSE:	MOV	R0, #0F0H
		RET
	DSSWSE:	MOV	@R0, 001H
		INC	R0
		MOV	@R0, 002H
		INC	R0
		MOV	@R0, 003H
		INC	R0
		MOV	@R0, 004H
		INC	R0
		MOV	@R0, 005H
		INC	R0
		MOV	@R0, 006H
		INC	R0
		MOV	@R0, 007H
		INC	R0
		MOV	@R0, #CNTRETCODE
		RET
RDSCAL:		MOV	A, SCALEPOSSELL
		INC	SCALEPOSSELL
		MOVC	A, @A+DPTR
		RET
DL400C:		PUSH	007H
		MOV	R7, #020
		DJNZ	R7, $
		POP	007H
		RET
TABLE:	
	ORG	1A00H
		DB	000H, 005, 03CH,0B0H, 0C1H, 001, 0C3H, 001, 0C5H, 001, 0C7H, 001, 000H, 001, 0FFH
	ORG	1A10H	//HARRY POTTER, 16=348
		DB	000H, 004, 057H,0AEH, 0C7H, 002, 0D3H, 003, 0D5H, 001, 0F2H, 002, 0D3H, 004, 0D7H, 002
		DB	0D6H, 006, 0F2H, 006, 0D3H, 003, 0D5H, 001, 0F2H, 002, 0F1H, 004, 0D4H, 002, 0C7H, 010
		DB	000H, 006, 000H, 004, 0FFH
	ORG	1A40H	//WAKE UP, 16=252, *5
		DB	000H, 001, 045H,0FDH, 0C4H, 040, 0D2H, 040, 0C4H, 020, 0F3H, 060, 000H, 020, 0D2H, 040
		DB	0D4H, 040, 0D2H, 020, 0F3H, 060, 000H, 020, 0D2H, 040, 0F3H, 040, 0D2H, 020, 0D4H, 060
		DB	000H, 020, 0D4H, 040, 0C4H, 039, 000H, 001, 0C4H, 020, 0F3H, 060, 000H, 020, 0FFH
	ORG	1A70H	//STAR WAR, 16=432
		DB	000H, 003, 04BH,028H, 0F3H, 008, 0D4H, 008, 0D3H, 001, 0D2H, 001, 0D1H, 001, 0D7H, 008
		DB	0F3H, 004, 0D3H, 001, 0D2H, 001, 0D1H, 001, 0D7H, 008, 0F3H, 004, 0D1H, 001, 0C7H, 001
		DB	0D1H, 001, 0C6H, 008, 0FFH
	ORG	1FB8H
		DB	0F1H, 0F2H, 0F4H, 0F4H, 0F6H, 0F7H, 0F8H, 0FFH
	ORG	1FB0H
		DB	017H, 0B7H, 02AH, 0D7H, 009H, 01FH, 018H, 0FFH
	ORG	1FC8H
		DB	0F8H, 0F9H, 0FAH, 0FAH, 0FBH, 0FBH, 0FCH, 0FFH
	ORG	1FC0H
		DB	08CH, 05BH, 015H, 067H, 004H, 090H, 00CH, 0FFH
	ORG	1FD8H
		DB	0FCH, 0FCH, 0FDH, 0FDH, 0FDH, 0FDH, 0FEH, 0FFH
	ORG	1FD0H
		DB	044H, 0ACH, 009H, 034H, 082H, 0C8H, 006H, 0FFH
	ORG	1FF8H ;(D2*   D4*   C7b)
		DB	0FCH, 0FDH, 0FBH
	ORG	1FF0H
		DB	0DCH, 05CH, 0CFH
        END
