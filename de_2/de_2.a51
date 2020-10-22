ORG 0000H
	LJMP MAIN

ORG 0030H
MAIN:
	; gan DPTR = 0xXXXXH
	ACALL COUNT
	
;-----------------
COUNT:
	; khoi tao cac gia tri
	N EQU 30h							; so luong cac phan tu can kiem tra
	
	MOV N, R3
	MOV R4, #0							; so dem ban dau = 0
	
	LOOP:
		MOVX A, @DPTR
		JNB ACC.7, SKIP					; neu ACC.7 = 0 thi A la so duong hoac so 0 => bo qua
			; else: la so am
			INC R4
		SKIP:
			INC DPTR
	DJNZ N, LOOP						; lap den khi nao N = 0
	
RET 

END
			