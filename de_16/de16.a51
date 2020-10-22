ORG 0000H
	LJMP MAIN

ORG 0023H
	LJMP UART
; khai bao bien
FLAG EQU 30H
; khai bao hang
STX EQU 00H
EOT EQU 0FFH

; chuong trinh chinh
ORG 0030H
MAIN:
	SETB EA
	SETB ES
	
	MOV SCON, #50H		; MODE 1, REN = 1
	MOV TMOD, #20H
	MOV TL1, #0FDH
	MOV TH1, #0FDH
	SETB TR1
	
	CLR FLAG
	
	SJMP $
		
; phuc vu ngat UART	
UART:
	CLR RI
	MOV A, SBUF
	
	JNB RI, ES_TI					; co phai nhan du lieu ko?
		JB FLAG, RECIVE				; FLAG=1 => nhan data, else doi nhan #STX
			CJNE A, #STX, END_ES
			SETB FLAG
			SJMP END_ES
		RECIVE:						; FLAG = 1 
			CJNE A, #EOT, RX_DATA	; co phai la ky tu ket thuc chuoi?
				CLR FLAG
				SJMP END_ES
			RX_DATA:				; else nhan du lieu truyen vao @DPTR
				MOVX @DPTR, A
				INC DPTR
				SJMP END_ES
	ES_TI:
	END_ES:
RETI

END