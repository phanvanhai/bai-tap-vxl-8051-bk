ORG 0000H
	LJMP MAIN
	
ORG 0030H
MAIN:
	MOV R0, #60H			; su dung RAM noi
	MOV R1, #65H

	ACALL ADD_ASCII
;-----------------------
ADD_ASCII:
	N_BYTE  EQU 30H
	TEMP	EQU 31H
	KQ		EQU 32H		; dia chi dau tien de luu tru ket qua
	
	MOV N_BYTE, #5
	MOV KQ, #70H		; ket qua bat dau tu o nho RAM noi: 70H
	CLR C
	LOOP:
		MOV A, @R0		;  0x3X
		ADDC A, @R1		; +0x3Y = 0x6(X+Y)
		ANL A, #0FH		;	A = 0x0(X+Y)
		SWAP A			;   A = 0x(X+Y)0
		DA A			; X+Y >=10 => A = 0x(X+Y-10)0, C=1 else : A = 0x(X+Y)0, C=0
		SWAP A
		ANL A, #3FH		; to ASCII, ko dung ADD de tranh mat bit C
		; chuyen ket qua vao o nho
		MOV TEMP, R0	; luu tru lai gia tri R0
		MOV R0, KQ		; KQ -> dia chi luu ket qua
		MOV @R0, A		; @R0 = ket qua = A
		MOV R0, TEMP	; khoi phuc lai gia tri R0
		; tro den cac o nho tuong ung cua tung bien
		INC R0			
		INC R1
		INC KQ
	DJNZ N_BYTE, LOOP
RET

END
		
		
		
	
	