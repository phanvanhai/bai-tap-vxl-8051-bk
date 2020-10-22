ORG 0000H
	JMP MAIN
	
N_BYTE	EQU 30H
M_BIT	EQU 31H
	
ORG 0050H
MAIN:
	MOV R0, #00H		; dia chi LSByte du lieu
	MOV N_BYTE, #5
	MOV M_BIT, #5
	
	ACALL RL_N_BYTE
;------------------
RL_N_BYTE:
	ADDR_MSB	EQU R1			; dia chi Byte cao nhat
	TEMP_R0		EQU 32H			; luu lai gia tri ban dau cua R0
	TEMP1		EQU 33H
	TEMP2		EQU 34H
	
	; lay ADDR_MSB
	MOV A, R0
	ADD A, N_BYTE
	MOV ADDR_MSB, A 
	
	MOV TEMP_R0, R0				; luu dia chi ban dau cua R0
	
	; bat dau xoay trai tu Byte thap den byte cao nhat
	MOV TEMP1, M_BIT
	LOOP1:
		; lay MSBit cua byte cao nhat -> C
		MOV ACC, ADDR_MSB
		MOV C, ACC.7
		
		; xoay vong bat dau tu byte thap den byte cao
		MOV R0, TEMP_R0			; R0 = dia chi bat dau cua data
		MOV TEMP2, N_BYTE
		LOOP2:
			MOV A, @R0
			RRC A
			MOV @R0, A
			INC R0
		DJNZ TEMP2, LOOP2		; lap den khi xoay dc Temp2 = N_byte byte
	DJNZ TEMP1, LOOP1			; lap di khi xoay du Temp1 = M_bit bit

RET

END