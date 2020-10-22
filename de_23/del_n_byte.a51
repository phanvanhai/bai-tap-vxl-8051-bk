ORG 0000H
LJMP MAIN

NL   EQU 30H	; low N
NH   EQU 31H	; high N
	
ORG 30H
MAIN:
	MOV DPTR, #8000H
	MOV NH, #00H
	MOV NL, #10H
	LOOP:
		CLR A
		MOVX @DPTR, A		; xoa ô nho @DPTR
		INC DPTR
	; giam NH_NL
	skip:					
		DEC NL
		MOV A, NL
		CJNE A, #0FFH, skip1	; 00h -> FFh ?
		DEC NH
	; kiem tra NH_NH == 0 ?	
	skip1:
		MOV A, NL
		JNZ LOOP			; NL != 0 => tiep tuc lap
		MOV A, NH
		JNZ LOOP			; NH != 0 => tiep tuc lap
END
	