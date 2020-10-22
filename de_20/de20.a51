ORG 0000H
	LJMP MAIN
	
ORG 0030H
MAIN:
	MOV R1, #40H
	MOV R0, #55H
	MOV R3, #1

	ACALL TINH_TOAN

;--------------------
TINH_TOAN:
PUSH ACC
PUSH B

N 			EQU 30H		; luu so luong BCD can tinh toan
N_BYTE 		EQU 31H		; luu so byte bieu dien 1 so BCD
TEMP_R0   	EQU 32H		; luu dia chi chua trong R0
	
MOV N, #10	
MOV N_BYTE, R3
MOV TEMP_R0, R0

; lay so byte bieu dien 1 so BCD
; ban dau R3 chua so cac chu so BCD: vd 124BCD chua 3 ky tu -> can 2 byte de bieu dien
MOV A, R3
MOV B, #2
DIV AB
ADD A,B
ADD A, #1		; + 1 byte de luu truong hop tran so
MOV R3, A

; mang ket qua ban dau = 0
; mang gom : 2N byte
CLR_R0:
	MOV @R0, #0
	INC R0
	MOV @R0, #0
	INC R0
	DJNZ N_BYTE, CLR_R0
	
; cong 10 so BCD
ADD_BCD:	
	MOV R0, TEMP_R0
	MOV N_BYTE, R3
	LOOP:
		CLR C
		MOV A, @R1			; lay du lieu tu so BCD
		ADDC A, @R0			; A = @R0+ @R1 + C
		DA A				; chuyen ve dang BCD
		MOV @R0, A			; chuyen vao vi tri lýu ket qua tuong ung
		
		INC R0				; moi ket qua cach nhau 1 byte trong
		INC R0				; chuyen den vi tri luu ket qua tiep theo
		INC R1				; tro den tung byte cua mang du lieu
		
		DJNZ N_BYTE, LOOP	; cong het n_byte cua 1 BCD chua?
		DJNZ N, ADD_BCD		; cong du 10 so chua?

; chuyen ket qua tu dang BCD sang dang ASCII
MOV R0, TEMP_R0
MOV N_BYTE, R3
TO_ASCII:
	MOV A, R0
	MOV TEMP_R0, A			; temp_r0 de luu lai gia tri trong R0
	; chuyen nibble low ve ascii
	ANL A, #0FH
	ADD A, #'0'
	MOV @R0,A
	INC R0
	MOV A, TEMP_R0			; lay gia tri cu cua R0 = temp_r0
	SWAP A
	; chuyen nibble high ve ascii
	ANL A, #0FH
	ADD A, #'0'
	MOV @R0,A
	INC R0
	DJNZ N_BYTE, TO_ASCII	; chuyen doi het N-BYTE ket qua chua?
	
POP B
POP ACC
RET

END