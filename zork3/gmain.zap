

	.FUNCT	MAIN-LOOP,TRASH
?PRG1:	CALL	MAIN-LOOP-1 >TRASH
	JUMP	?PRG1


	.FUNCT	MAIN-LOOP-1,ICNT,OCNT,NUM,CNT,OBJ,TBL,V,PTBL,OBJ1,TMP,O,I
	SET	'CNT,0
	SET	'OBJ,FALSE-VALUE
	SET	'PTBL,TRUE-VALUE
	CALL	PARSER >P-WON
	ZERO?	P-WON /?ELS3
	GET	P-PRSI,P-MATCHLEN >ICNT
	GET	P-PRSO,P-MATCHLEN >OCNT
	ZERO?	P-IT-OBJECT /?CND4
	CALL	ACCESSIBLE?,P-IT-OBJECT
	ZERO?	STACK /?CND4
	SET	'TMP,FALSE-VALUE
?PRG9:	IGRTR?	'CNT,ICNT \?ELS13
	JUMP	?REP10
?ELS13:	GET	P-PRSI,CNT
	EQUAL?	STACK,IT \?PRG9
	PUT	P-PRSI,CNT,P-IT-OBJECT
	SET	'TMP,TRUE-VALUE
?REP10:	ZERO?	TMP \?CND19
	SET	'CNT,0
?PRG22:	IGRTR?	'CNT,OCNT \?ELS26
	JUMP	?CND19
?ELS26:	GET	P-PRSO,CNT
	EQUAL?	STACK,IT \?PRG22
	PUT	P-PRSO,CNT,P-IT-OBJECT
?CND19:	SET	'CNT,0
?CND4:	ZERO?	OCNT \?ELS36
	PUSH	OCNT
	JUMP	?CND32
?ELS36:	GRTR?	OCNT,1 \?ELS38
	SET	'TBL,P-PRSO
	ZERO?	ICNT \?ELS41
	SET	'OBJ,FALSE-VALUE
	JUMP	?CND39
?ELS41:	GET	P-PRSI,1 >OBJ
?CND39:	PUSH	OCNT
	JUMP	?CND32
?ELS38:	GRTR?	ICNT,1 \?ELS45
	SET	'PTBL,FALSE-VALUE
	SET	'TBL,P-PRSI
	GET	P-PRSO,1 >OBJ
	PUSH	ICNT
	JUMP	?CND32
?ELS45:	PUSH	1
?CND32:	SET	'NUM,STACK
	ZERO?	OBJ \?CND48
	EQUAL?	ICNT,1 \?CND48
	GET	P-PRSI,1 >OBJ
?CND48:	EQUAL?	PRSA,V?WALK \?ELS55
	ZERO?	P-WALK-DIR /?ELS55
	CALL	PERFORM,PRSA,PRSO >V
	JUMP	?CND53
?ELS55:	ZERO?	NUM \?ELS59
	GETB	P-SYNTAX,P-SBITS
	BAND	STACK,P-SONUMS
	ZERO?	STACK \?ELS62
	CALL	PERFORM,PRSA >V
	SET	'PRSO,FALSE-VALUE
	JUMP	?CND53
?ELS62:	ZERO?	LIT \?ELS64
	PRINTI	"It's too dark to see."
	CRLF	
	JUMP	?CND53
?ELS64:	PRINTI	"It's not clear what you're referring to."
	CRLF	
	SET	'V,FALSE-VALUE
	JUMP	?CND53
?ELS59:	SET	'P-NOT-HERE,0
	SET	'P-MULT,FALSE-VALUE
	GRTR?	NUM,1 \?CND73
	SET	'P-MULT,TRUE-VALUE
?CND73:	SET	'TMP,FALSE-VALUE
?PRG76:	IGRTR?	'CNT,NUM \?ELS80
	GRTR?	P-NOT-HERE,0 \?ELS83
	PRINTI	"The "
	EQUAL?	P-NOT-HERE,NUM /?CND86
	PRINTI	"other "
?CND86:	PRINTI	"object"
	EQUAL?	P-NOT-HERE,1 /?CND93
	PRINTI	"s"
?CND93:	PRINTI	" that you mentioned "
	EQUAL?	P-NOT-HERE,1 /?ELS102
	PRINTI	"are"
	JUMP	?CND100
?ELS102:	PRINTI	"is"
?CND100:	PRINTI	"n't here."
	CRLF	
	JUMP	?REP77
?ELS83:	ZERO?	TMP \?REP77
	PRINTI	"There's nothing here you can take."
	CRLF	
	JUMP	?REP77
?ELS80:	ZERO?	PTBL /?ELS119
	GET	P-PRSO,CNT >OBJ1
	JUMP	?CND117
?ELS119:	GET	P-PRSI,CNT >OBJ1
?CND117:	ZERO?	PTBL /?ELS127
	PUSH	OBJ1
	JUMP	?CND123
?ELS127:	PUSH	OBJ
?CND123:	SET	'O,STACK
	ZERO?	PTBL /?ELS135
	PUSH	OBJ
	JUMP	?CND131
?ELS135:	PUSH	OBJ1
?CND131:	SET	'I,STACK
	GRTR?	NUM,1 /?THN142
	GET	P-ITBL,P-NC1
	GET	STACK,0
	EQUAL?	STACK,W?ALL \?CND139
?THN142:	LOC	WINNER >V
	EQUAL?	O,NOT-HERE-OBJECT \?ELS146
	INC	'P-NOT-HERE
	JUMP	?PRG76
?ELS146:	EQUAL?	PRSA,V?TAKE \?ELS148
	ZERO?	I /?ELS148
	GET	P-ITBL,P-NC1
	GET	STACK,0
	EQUAL?	STACK,W?ALL \?ELS148
	IN?	O,I /?ELS148
	JUMP	?PRG76
?ELS148:	EQUAL?	P-GETFLAGS,P-ALL \?ELS152
	EQUAL?	PRSA,V?TAKE \?ELS152
	LOC	O
	EQUAL?	STACK,WINNER,HERE,V /?ELS158
	LOC	O
	EQUAL?	STACK,I /?ELS158
	LOC	O
	FSET?	STACK,SURFACEBIT \?PRG76
?ELS158:	FSET?	O,TAKEBIT /?ELS152
	FSET?	O,TRYTAKEBIT /?ELS152
	JUMP	?PRG76
?ELS152:	EQUAL?	OBJ1,IT \?ELS165
	PRINTD	P-IT-OBJECT
	JUMP	?CND163
?ELS165:	PRINTD	OBJ1
?CND163:	PRINTI	": "
?CND139:	SET	'PRSO,O
	SET	'PRSI,I
	SET	'TMP,TRUE-VALUE
	CALL	PERFORM,PRSA,PRSO,PRSI >V
	EQUAL?	V,M-FATAL \?PRG76
	JUMP	?CND53
?REP77:	
?CND53:	EQUAL?	V,M-FATAL /?CND173
	LOC	WINNER
	GETP	STACK,P?ACTION
	CALL	STACK,M-END >V
?CND173:	EQUAL?	V,M-FATAL \?CND1
	SET	'P-CONT,FALSE-VALUE
	JUMP	?CND1
?ELS3:	SET	'P-CONT,FALSE-VALUE
?CND1:	ZERO?	CLEFT-QUEUED? \?CND181
	RANDOM	70
	ADD	70,STACK
	CALL	QUEUE,I-CLEFT,STACK
	PUT	STACK,0,1
	SET	'CLEFT-QUEUED?,TRUE-VALUE
?CND181:	ZERO?	P-WON /FALSE
	EQUAL?	PRSA,V?SUPER-BRIEF,V?BRIEF,V?TELL /TRUE
	EQUAL?	PRSA,V?VERSION,V?SAVE,V?VERBOSE /TRUE
	EQUAL?	PRSA,V?SCORE,V?RESTART,V?QUIT /TRUE
	EQUAL?	PRSA,V?RESTORE,V?UNSCRIPT,V?SCRIPT /TRUE
	CALL	CLOCKER >V
	RETURN	V


	.FUNCT	PERFORM,A,O=0,I=0,V,OA,OO,OI
	SET	'OA,PRSA
	SET	'OO,PRSO
	SET	'OI,PRSI
	EQUAL?	IT,I,O \?CND1
	CALL	ACCESSIBLE?,P-IT-OBJECT
	ZERO?	STACK \?CND1
	PRINTI	"I don't see what you are referring to."
	CRLF	
	RETURN	2
?CND1:	EQUAL?	O,IT \?CND10
	SET	'O,P-IT-OBJECT
?CND10:	EQUAL?	I,IT \?CND13
	SET	'I,P-IT-OBJECT
?CND13:	SET	'PRSA,A
	SET	'PRSO,O
	ZERO?	PRSO /?CND16
	EQUAL?	PRSI,IT /?CND16
	EQUAL?	PRSA,V?WALK /?CND16
	SET	'P-IT-OBJECT,PRSO
?CND16:	SET	'PRSI,I
	EQUAL?	NOT-HERE-OBJECT,PRSO,PRSI \?ELS23
	CALL	NOT-HERE-OBJECT-F >V
	ZERO?	V /?ELS23
	JUMP	?CND21
?ELS23:	SET	'O,PRSO
	SET	'I,PRSI
	GETP	WINNER,P?ACTION
	CALL	STACK >V
	ZERO?	V /?ELS30
	JUMP	?CND21
?ELS30:	LOC	WINNER
	GETP	STACK,P?ACTION
	CALL	STACK,M-BEG >V
	ZERO?	V /?ELS32
	JUMP	?CND21
?ELS32:	GET	PREACTIONS,A
	CALL	STACK >V
	ZERO?	V /?ELS34
	JUMP	?CND21
?ELS34:	ZERO?	I /?ELS36
	GETP	I,P?ACTION
	CALL	STACK >V
	ZERO?	V /?ELS36
	JUMP	?CND21
?ELS36:	ZERO?	O /?ELS40
	EQUAL?	A,V?WALK /?ELS40
	LOC	O
	ZERO?	STACK /?ELS40
	LOC	O
	GETP	STACK,P?CONTFCN
	CALL	STACK >V
	ZERO?	V /?ELS40
	JUMP	?CND21
?ELS40:	ZERO?	O /?ELS44
	EQUAL?	A,V?WALK /?ELS44
	GETP	O,P?ACTION
	CALL	STACK >V
	ZERO?	V /?ELS44
	JUMP	?CND21
?ELS44:	GET	ACTIONS,A
	CALL	STACK >V
	ZERO?	V /?CND21
?CND21:	SET	'PRSA,OA
	SET	'PRSO,OO
	SET	'PRSI,OI
	RETURN	V

	.ENDI