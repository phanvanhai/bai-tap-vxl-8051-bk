ORG 0000H
NOP
SJMP MAIN

ORG 0050H
MAIN:
	; thiet lap bo du lieu de test ct con
	MOV 30H, #01H
	MOV 31H, #02H
	MOV 32H, #10H
	MOV 33H, #01H
	MOV 34H, #9AH
	MOV 35H, #01H
	
	MOV B, #01H
	MOV R1, #30H
	MOV R2, #6
	
	; goi ct con
	LCALL SO_LAN_LAP
	
	SJMP $

;--------- SO LAN LAP ----------
SO_LAN_LAP:
	TIM EQU B			; so can kiem tra
	NUM EQU R1			; bien NUM de duyet tung so trong mang
	N 	EQU R2			; so luong phan tu trong mang da dat truoc khi goi ct con
	KQ 	EQU R3			; ket qua tim dc
	
	;--- INTIAL ----
	MOV KQ, #0
	
	LOOP:
		MOV A, @NUM		; A = gia tri tung phan tu trong mang
		CJNE A, TIM, SKIP	; neu A != TIM thi bo qu
		INC KQ				; else: tang so lan lap = KQ len 1
		SKIP:
			INC NUM			; tro den phan tu tiep theo
			DJNZ N, LOOP	; da kiem tra het N so chua?
RET

END
