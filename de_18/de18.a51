ORG 0000H
	LJMP MAIN
	
	
ORG 0030H
MAIN:
	ACALL CHECK_SUM

;-----------------------
CHECK_SUM:
	PUSH DPL
	PUSH DPH
	
	N1 EQU 30H
	N2 EQU 31H
	TEMP EQU 32H
		
	MOV N1, R2
	MOV N2, R3
	
	MOV TEMP, #0	; luu gia tri check sum
	LOOP:
		MOVX A, @DPTR
		ADD A, TEMP
		MOV TEMP, A
		INC DPTR
		; DEC R3_R2
		DEC R2
		CJNE R2, #0FFH, SKIP
		DEC R1
		SKIP:
	; check R3_R2 == 0?
	CJNE R2, #0H, LOOP
	CJNE R3, #0H, LOOP
	; ket thuc tinh check sum
	; khoi phuc lai cac thanh ghi
	MOV A, TEMP
	MOV R2, N1
	MOV R3, N2
	POP DPH
	POP DPL
RET

END