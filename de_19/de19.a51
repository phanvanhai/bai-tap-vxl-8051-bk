ORG 0000H
	LJMP MAIN
	
ORG 0030H
MAIN:
	ACALL SWAP_N
	
;------------------------------
SWAP_N:
	PUSH ACC
	
	LOOP:
		MOVX A, @DPTR
		SWAP A
		MOVX @DPTR, A
		INC DPTR
	DJNZ R3, LOOP

	POP ACC
RET

END
		