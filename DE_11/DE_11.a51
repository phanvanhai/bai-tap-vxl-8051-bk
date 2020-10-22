ORG 0000H
	LJMP MAIN

ORG 0030H
MAIN:
	ACALL CONVERT

;-----------------
CONVERT:
	LOOP:
		CJNE @R0, #'a', VALID
		JC INVALID				; @R0 < 'a'
		;else: @R0 > 'a'
		CJNE @R0, #'z', VALID
		JNC INVALID				; @R0 > 'z'
		VALID:
			MOV A, @R0
			ADD A, #('A'-'a')
			MOV @R0, A
		INVALID:
	DJNZ R7, LOOP
RET

END