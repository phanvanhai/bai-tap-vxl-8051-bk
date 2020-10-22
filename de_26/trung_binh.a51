ORG 0000H
NOP
SJMP MAIN


ORG 0050H
MAIN:
	;---- tao du lieu test ct con --------
	MOV 30H, #20H
	MOV 31H, #21H
	MOV 32H, #23H
	MOV 33H, #0FAH
	MOV 34H, #0DCH
	MOV 35H, #56H
	MOV 36H, #78H
	MOV 37H, #44H
	
	LCALL TRUNG_BINH
	
	SJMP $
;----------  TRUNG_BINH --------------
TRUNG_BINH:

	NUM		EQU R0				; bien NUM de duyet cac so tu o nho 30-> 37
	KQ 		EQU R1				; luu ket qua phan nguyen
	TONG_DU EQU R2				; lýu ket qua phan du

	MOV R0, #30H
	MOV KQ, #0
	MOV TONG_DU, #0

	LOOP:
		MOV A, @NUM
		MOV B, #8
		DIV AB			; lay tung so / 8
		ADD A, KQ		; phan nguyen cua phep chia + vao KQ
		MOV KQ, A
		
		MOV A, B		; lay phan du vua tinh dc + vao phan du truoc do
		ADD A, TONG_DU
		MOV TONG_DU, A
		
		INC NUM
		CJNE NUM, #(37H+1), LOOP	; neu chua duyet den o nho 37 thi tiep tuc
		;else da tính xong den o nho 37
		; xu ly tiep ket qua:
		
		MOV A, TONG_DU		; lay Tong_du / 8 
		MOV B, #8
		DIV AB
		ADD A, KQ			; phan nguyen cua phep chi + vào KQ
		MOV KQ, A			; day moi chinh la Ket qua cuoi cung
		MOV TONG_DU, B		; phan du nay moi chinh la ket qua cuoi cung
RET

END
