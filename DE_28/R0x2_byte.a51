ORG 0000H

; gia su 2 byte dc nhan õ dia chi: 50H, 51H
MOV 50H, #3FH
MOV 51H, #0AFH
MOV R0, #33H

; 3 byte lýu tru ket qua
KQ1 EQU R2
KQ2 EQU R3
KQ3 EQU R4

; NHAN B2_B1 x R0 
; B1 x R0
MOV A, R0
MOV B, 50H
MUL AB	
MOV KQ1, A
MOV KQ2, B

; B2 x R0
MOV A, R0
MOV B, 51H
MUL AB
ADD A, KQ2			; KQ2 = A + KQ2 truoc do
MOV KQ2, A
MOV A, #00
ADDC A, B	; KQ3 = B + CARRY
MOV KQ3, A

END
