ORG 0000H
	LJMP MAIN

ORG 0030H
MAIN:
	ACALL TO_BCD
	
;-------------------
TO_BCD:
	N		EQU 30H
	TEMP_R1 EQU 31H		; luu lai gia tri cua R0
	TEMP_R0	EQU 32H		; luu lai gia tri cua R1
	
	MOV TEMP_R0, R0
	MOV TEMP_R1, R1
	LOOP:
		CLR A
		XCHD A, @R0		; A = 0x0(nibble low @R0)
		SWAP A			; A = 0x(nibble low @R0)0
		INC R0
		XCHD A, @R0		; A = 0x(nibble low @R0)(nibble low next @R0)
		MOV @R1, A		; chuyen ket qua vao o nho tuong ung
		INC R1
	DJNZ N, LOOP
RET

END
