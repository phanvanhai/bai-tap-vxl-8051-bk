ORG 0000H
	LJMP MAIN

ORG 0030H
MAIN:
	ACALL CT_CON
	
;-------------------
CT_CON:
	MOV P0, #0FFH			; che do Input
	COUNT EQU 30H			; chua so xung dem dc
	
	MOV COUNT, #00H
	
	JB P0.5, $				; doi den khi P0.5 xuong muc 0
	JNB P0.5, $				; doi den khi P0.5 tu muc 0 len 1
		
	; bat dau dem xung, <=> dem so lan P0.6: 1-> 0 -> 1
	LOOP:
		JB P0.6, $			; doi den khi P0.6 xuong muc 0
		JNB P0.6, $			; doi den khi P0.5 tu muc 0 len 1 
		INC COUNT
	MOV A, COUNT
	CJNE A , #100, LOOP
	
	; da dem xong 100 xung
	SETB P0.7
RET

END