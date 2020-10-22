ORG 0000H
	LJMP MAIN

ORG 0000H
MAIN:
	ACALL SUBTRACT
	
;------------
SUBTRACT:
	N EQU 30H
		
	MOV A, R0
	ADD A, #5
	MOV R0, A	; R0-> byte nho nhat cua so bi tru
	MOV A, R1
	ADD A, #5
	MOV R1, A	; R1 -> byte thap nhat cua so tru
	
	MOV N, #5
	CLR C
	LOOP:
		MOV A, @R0
		SUBB A, @R1		; A = @R0-@R1
		MOV @R0, A		; @R0 = A
		DEC R0
		DEC R1
	DJNZ N, LOOP
RET

END

