org 0000h
ljmp main

; ct ngat INT0
org 000BH
cpl P2.0		;1us
cpl P2.1		;1us
dec R0			; dem so xung da phat
mov TH0, #00H	;2us
mov TL0, #0FDH	;2us
; tong = 65283+6= 65289us => T = 2*65289=130578us => f= 7 Hz
reti

;----------------
XUNG EQU 10		; tao 10 xung
	
;-----------------
org 0030H
main: 
	mov TMOD, #01H ; timer 0 mode 1: 16 bit
	mov IE, #82H	; enable interupt 0
	mov R0, #(2* XUNG)

loop:
	clr TR0			; dung tao xung
	mov TH0, #00H
	mov TL0, #0FDH	; 65283us-> TF0=1
	
	jb P1.1,$ 		; doi den khi P1.1 = 0 thi tao xung
	setb TR0		; bat dau tao xung
	
	; if P1.1 =1 jump loop => dung tao xung va doi tin hieu bat dau tao xung moi
	kiemtra: jb P1.1, loop
	;else: P1.1 van = 0:
	cjne R0,#0, kiemtra		; neu chua du 10 xung thi nhay den Kiemtra
	; if R0 = 0 => da tao du 10 xung => ket thuc
	clr TR0
jmp $
	
end
