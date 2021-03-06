

	.FUNCT	QUEUE,RTN,TICK,CINT
	CALL	INT,RTN >CINT
	PUT	CINT,C-TICK,TICK
	RETURN	CINT


	.FUNCT	INT,RTN,E,C,INT
	ADD	C-TABLE,C-TABLELEN >E
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E \?ELS5
	SUB	C-INTS,C-INTLEN >C-INTS
	ADD	C-TABLE,C-INTS >INT
	PUT	INT,C-RTN,RTN
	RETURN	INT
?ELS5:	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CND3
	RETURN	C
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	ENABLED?,RTN,C,E
	ADD	C-TABLE,C-TABLELEN >E
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E /FALSE
	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CND3
	GET	C,C-ENABLED?
	ZERO?	STACK \TRUE
	RFALSE	
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	QUEUED?,RTN,C,E
	ADD	C-TABLE,C-TABLELEN >E
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E /FALSE
	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CND3
	GET	C,C-ENABLED?
	ZERO?	STACK /FALSE
	GET	C,C-TICK
	ZERO?	STACK \TRUE
	RFALSE	
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	CLOCKER,C,E,TICK,FLG=0,VAL
	ZERO?	CLOCK-WAIT /?CND1
	SET	'CLOCK-WAIT,FALSE-VALUE
	RFALSE	
?CND1:	INC	'PRESENT-TIME
	GRTR?	PRESENT-TIME,1439 \?CND5
	SUB	PRESENT-TIME,1440 >PRESENT-TIME
?CND5:	ZERO?	WATCH-WOUND /?CND8
	IGRTR?	'WATCH-MOVES,59 \?CND8
	SUB	WATCH-MOVES,60 >WATCH-MOVES
	IGRTR?	'WATCH-SCORE,11 \?CND12
	SET	'WATCH-SCORE,0
?CND12:	
?CND8:	CALL	WATCH-UPDATE
	ADD	C-TABLE,C-INTS >C
	ADD	C-TABLE,C-TABLELEN >E
?PRG18:	EQUAL?	C,E \?ELS22
	RETURN	FLG
?ELS22:	GET	C,C-ENABLED?
	ZERO?	STACK /?CND20
	GET	C,C-TICK >TICK
	ZERO?	TICK \?ELS27
	JUMP	?CND20
?ELS27:	SUB	TICK,1
	PUT	C,C-TICK,STACK
	GRTR?	TICK,1 /?CND25
	GET	C,C-RTN
	CALL	STACK >VAL
	ZERO?	VAL /?CND25
	ZERO?	FLG /?THN38
	EQUAL?	VAL,M-FATAL \?CND20
?THN38:	SET	'FLG,VAL
?CND25:	
?CND20:	ADD	C,C-INTLEN >C
	JUMP	?PRG18


	.FUNCT	WATCH-UPDATE
	IN?	WATCH,PLAYER \?ELS5
	SET	'MOVES,WATCH-MOVES
	SET	'SCORE,WATCH-SCORE
	RETURN	SCORE
?ELS5:	SET	'MOVES,99
	SET	'SCORE,111
	RETURN	SCORE

	.ENDI
