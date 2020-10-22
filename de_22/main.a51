ORG 0000H
LJMP MAIN

NL   EQU 34H	; low N	de luu gia tri byte thap cua N
NH   EQU 35H	; high N luu gia tri byte cao cua N
	
ORG 30H
MAIN:
	MOV NH, #00H		; gia su N= 0010H
	MOV NL, #10H

	ACALL CT_CON
;-------------------
CT_CON:
	SRCL EQU 30H	; dia chi nguon du lieu
	SRCH EQU 31H
	DESL EQU 32H	; dia chi du lieu chuyen den
	DESH EQU 33H
	
	MOV SRCL, #00H
	MOV SRCH, #40H
	MOV DESL, #00H
	MOV DESH, #60H
	
	LOOP:
		MOV DPL, SRCL	; DPTR = dia chi nguon du lieu
		MOV DPH, SRCH
		
		MOVX A, @DPTR
		; tang SRCH_SRCL
		INC DPTR
		MOV DPL, SRCL
		MOV DPH, SRCH
		
		; chuyen doi sang ASCII
		MOV R3, A		; luu lai gia tri A truoc khi A bi thay doi
		ANL A, #0FH
		ADD A, #'0'
		MOV R0, A		; R0 = ASCII(nibble low A)
		
		MOV A, R3
		SWAP A
		ANL A, #0FH
		ADD A, #'0'
		MOV R1, A		; R1 = ASCII(nibble high A)
		
		; chuyen du lieu da chuyen doi toi o nho dich
		MOV DPL, DESL	; DPTR = dia chi noi se chuyen du lieu toi
		MOV DPH, DESH
		; chuyen du lieu vao bo nho
		MOV A, R0
		MOVX @DPTR, A
		INC DPTR
		
		MOV A, R1
		MOVX @DPTR, A
		INC DPTR
		; luu lai vi tri dich vao DESH_DESL
		MOV DPL, DESL
		MOV DPH, DESH
		
		; giam bien dem
		DEC NL
		MOV A, NL
		CJNE A, #0FFH, END_DEC		; neu NL giam tu 00-> FF thi giam NH nguoc lai bo qua
			DEC NH
		END_DEC:
		
		; kiem tra dieu kien vong lap
		MOV A, NL		
		JNZ LOOP			; !=0 tiep tuc lap
		MOV A, NH
		JNZ LOOP			; !=0 tiep tuc lap
RET

END
	