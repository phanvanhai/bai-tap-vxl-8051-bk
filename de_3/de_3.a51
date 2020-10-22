ORG 0000H
	LJMP MAIN

ORG 0030H
MAIN:
	ACALL COUNT
	
;-----------------
COUNT:
	; khoi tao cac gia tri
	MOV DPTR, #1000H
	MOV R2, #0
	MOV R3, #0
	
	LOOP:
		MOVX A, @DPTR
		JZ SKIP							; A = 0 => ko phai là so duong
		JB ACC.7, SKIP					; neu ACC.7 = 1 thi A la so am => bo qua
			; else: la so duong
			INC R2
			CJNE R2, #00H, SKIP			; neu R2 tý FFh+1 = 00h thi INC R3, else bo qua INC R3
			INC R3
		SKIP:
			INC DPTR
	MOV A, DPH
	CJNE A, #20H, LOOP				; quay lai vong lap neu chua den 20xxH
	MOV A, DPL
	CJNE A, #01H, LOOP				; neu DPTR = 2001H -> thoat vong lap
RET 

END
			