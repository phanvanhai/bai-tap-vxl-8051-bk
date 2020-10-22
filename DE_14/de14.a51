ORG 0000H
	LJMP MAIN

;khai bao bien
OFFSET		EQU 30H			
N_OFFSET	EQU 31H		; so luong offset = B
ADDR_OF_L 	EQU 32H		; dia chi cua offset
ADDR_OF_H 	EQU 33H
ORG 0030H
MAIN:
	MOV OFFSET, #00H
	MOV N_OFFSET, #00H
	MOV ADDR_OF_L, #LOW(0001H)
	MOV ADDR_OF_H, #HIGH(0001H)
	
	MOV DPL, #ADDR_OF_L
	MOV DPL, #ADDR_OF_H
	
	LOOP:
		MOVX A, @DPTR
		CJNE A, B, TRUE
			SJMP INCREASE
		TRUE:
			INC N_OFFSET			; tang bien dem so luong offset
			; chuyen gia tri offset vao RAM ngoai
			MOV DPL, #ADDR_OF_L
			MOV DPL, #ADDR_OF_H
			MOV A, OFFSET			; vi tri offset -> A
			MOVx @DPTR, A			; chuyen vi tri offset vao o nho tuong ung
			; chuyen den o nho chua vi tri offset tiep theo
			INC DPTR			
			MOV ADDR_OF_L, DPL
			MOV ADDR_OF_H, DPH
		INCREASE:
			; chuyen DPTR tro den phan tu tiep theo trong mang
			INC OFFSET				; tro toi vi tri offset tiep theo
			; DPTR = 1000H + OFFSET
			MOV A, OFFSET
			CLR C
			ADD A, #LOW(1000H)
			MOV DPL , A
			MOV A, #HIGH(1000H)
			ADDC A, #0				; DPH = HIGH(1000H) + C
			MOV DPH, A
		CHECK:
			; kiem tra xem da het mang chua?
			MOV A, OFFSET
			CJNE A, #(1200-1000+1), LOOP
		; chuyen so luong offset tim dc vao o nho: 0000H
		MOV DPL, #00H
		MOV DPH, #00H
		MOV A, N_OFFSET
		MOVX @DPTR, A
END
	