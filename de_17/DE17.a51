ORG 0000H
	LJMP MAIN

IBF EQU P0.1
STB EQU P0.2
	
ORG 0030H
MAIN:
	MOV R0,#0	; R0 dem so byte
	LOOP:
		JNB IBF, $		; kiem tra trang thai IBF==1?
		; chuyen du lieu vao RAM ngoai	
		MOV A, P1
		MOVX @DPTR, A
		; tao xung thap bao qua trinh doc da xong
		CLR STB
		SETB STB
	
		INC DPTR
		INC R0
	CJNE R0, #10, LOOP

END

	