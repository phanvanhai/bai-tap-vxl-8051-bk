ORG 0000H
	LJMP MAIN

; khai bao hang:
OBF	EQU P1.0
ACK EQU P1.1
; khai bao bien
N_DATA EQU 30H
ORG 0030H
MAIN:
	MOV N_DATA, #0
	LOOP:
		MOVX A, @DPTR
		INC DPTR
		MOV A, P2
		CLR OBF		; phat tin hieu bao da truyen du lieu
		JB ACK, $	; doi den khi ACK = 0
		INC N_DATA
		MOV A, N_DATA
	CJNE A, #10, LOOP	; kiem tra da truyen du 10 byte?

END