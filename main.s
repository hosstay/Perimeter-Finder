; File: main.s

; This file needs to be in a Keil version 5 project

; This is an ARM assembly program for Texas Instruments LM4F120H5QR hardware. It accepts input for a length and a width and then ; prints out the perimeter.

; Executable code in this file should start at label main

	EXPORT	main		; this line is needed to interface with init.s

; Usable utility functions defined in file init.s
; Importing any label from another source file is necessary
; in order to use that label in this source file

	IMPORT	GetCh
	IMPORT	PutCh
	IMPORT	PutCRLF
        IMPORT	UDivMod
	IMPORT	GetDec
	IMPORT	PutDec
	IMPORT	GetStr
	IMPORT	PutStr

	AREA    MyCode, CODE

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main

;-------------------- START OF MODIFIABLE CODE ----------------------

	PUSH	{LR}		; save return address of caller in init.s

	LDR	R0, =Prompt1	; R0 = address Prompt1 (in code area)
	BL	PutStr		; display prompt for asking for length
	
	BL	GetDec		; read into R0 decimal number entered by user
	LDR	R2, =Length	; R2 = address Length (in data area)
	STR	R0, [R2]	; store input number at Length

	LDR	R0, =Prompt2	; R0 = address Prompt2 (in code area)
	BL	PutStr		; display prompt for asking for width
	
	BL	GetDec		; read into R0 decimal number entered by user
	LDR	R3, =Width	; R1 = address Width (in data area)
	STR	R0, [R3]	; store input number at Width

	LDR	R0, =Msg1       ; R0 = address Msg1 (in code area)
	BL	PutStr          ; display first part of response line

        LDR	R2, [R2]	; put the value of R2 into R2
	LDR	R3, [R3]	; put the value of R1 into R1
	ADD	R0, R2, R3      ; R0 = R2 + R3
	ADD	R0, R0, R0	; R0 = 2 * R0
	BL	PutDec		; print 2*(L + W) of input numbers

	LDR	R0, =Msg2       ; R0 = address Msg2 (in code area)
	BL	PutStr		; display last part of response line
	
	POP	{PC}		; return from main
	
; Some commonly used ASCII codes

CR	EQU	0x0D	; Carriage Return (to move cursor to beginning of current line)
LF	EQU	0x0A	; Line Feed (to move cursor to same column of next line)

; The following data items are in the CODE area, so address of any of
; these items can be loaded into a register by the ADR instruction,
; e.g. ADR   R0, Prompt1 (using LDR is possible, but not efficient)

Prompt1	DCB	"Please enter the length of your rectangle: ", 0
Prompt2 DCB     "Please enter the width of your rectangle: ", 0
Msg1	DCB	"The perimeter of your rectangle is ", 0
Msg2	DCB	". Bye!", CR, LF, 0

	ALIGN
		
; The following data items are in the DATA area, so address of any of
; these items must be loaded into a register by the LDR instruction,
; e.g. LDR   R0, =Name (using ADR is not possible)

	AREA    MyData, DATA, READWRITE
		
	ALIGN

Length	SPACE	4	        ; 4 bytes for storing input length
	
Width	SPACE	4		; 4 bytes for storing input width

;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
