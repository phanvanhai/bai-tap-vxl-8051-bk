ORG 0000H
	LJMP MAIN

ORG 0030H
MAIN:
	MOV SCON, #50H
	MOV TMOD, #20H
	MOV TL1, #0FDH	; 9600 BAUD
	MOV TH1, #0FDH
	SETB TR1
	MOV DPTR, #0000H
	ACALL RX_DATA
	
;------------------------
RX_DATA:
	N_DATA EQU 30H
	MOV N_DATA, #100
	
	LOOP:
		JNB RI, $	; doi den khi nhan dc data
		CLR RI
		MOV A, SBUF
		MOVX @DPTR, A
		INC DPTR
	DJNZ N_DATA, LOOP
RET

END
	