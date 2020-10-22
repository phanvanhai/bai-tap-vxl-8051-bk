ORG 0000H
	LJMP MAIN

ORG 0030H
MAIN:
	; TRUYEN DIA CHI 2 SO VAO R0, R1
	ACALL ADD_4BYTE
	
;-----------------------
ADD_4BYTE:
SO1   EQU R0			; chua dia chi MSB cua so 1	
SO2   EQU R1			; chua dia chi MSB cua so 2
COUNT EQU R2

; ban dau R0, R1 chi den vi tri MSB ( o dia chi thap) cua 2 so
; chuyen R0,R1 chi den vi tri LSB cua 2 so = cach cong them 4 : 
	MOV A, R0
	ADD A, #4
	MOV R0, A

	MOV A, R1
	ADD A, #4
	MOV R1, A
	
	; tinh toan 
	MOV COUNT, #4
	CLR C
	BACK:
		MOV A, @SO1
		ADDC A, @SO2
		MOV @SO1, A
		DEC SO1
		DEC SO2
	DJNZ COUNT, BACK
RET

END
