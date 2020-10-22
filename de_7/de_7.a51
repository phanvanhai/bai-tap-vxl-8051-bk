ORG 0000H
	LJMP MAIN

N_BYTE	EQU 30H
M_BIT	EQU 31H

ORG 0030H
MAIN:
	MOV R0, #00H		; DIA CHI MSB DU LIEU
	MOV N_BYTE, #5
	MOV M_BIT, #5
	
	ACALL RR_N_BYTE
	
;------------------
RR_N_BYTE:
	ADDR_LSB	EQU R1			; DIA CHI BYTE THAP NHAT
	TEMP_R0		EQU 32H
	TEMP1		EQU 33H
	TEMP2		EQU 34H
	
	; lay ADDR_LSB
	MOV A, R0
	ADD A, N_BYTE
	MOV ADDR_LSB, A 
	
	MOV TEMP_R0, R0				; luu dia chi ban dau cua R0
	
	MOV TEMP1, M_BIT
	LOOP1:
		; lay LSB cua byte thap nhat -> C
		MOV ACC, ADDR_LSB
		MOV C, ACC.0
		
		MOV R0, TEMP_R0			; R0 = dia chi bat dau cua data
		MOV TEMP2, N_BYTE
		LOOP2:
			MOV A, @R0
			RRC A
			MOV @R0, A
			INC R0
		DJNZ TEMP2, LOOP2
	DJNZ TEMP1, LOOP1

RET

END