; Input keys from keypad and display them on VFD
; It assumed that the code runs from RAM under MON85
; Use the following MON85 commands to run the code:
; U 8000
; G 8040

; Program start address
START_ADDR		EQU		8000h			; Start address when running from MON85
;START_ADDR		EQU		0				; Start address when running from ROM

; USART registers
USART_DATA		EQU		08h
USART_CMD		EQU		09h
; Keypad and VFD registers
KEYPAD_DATA		EQU		30h
VFD_CMD			EQU		38h
VFD_DATA		EQU		39h

				ORG		START_ADDR
				JMP		START			; Skip RST vectors
				
; RST 7.5 Hardware interrupt vector
				ORG		START_ADDR+3Ch
				JMP		KEYPAD_ISR		; jump to the interrupt service routine

				
; Program start here
				ORG		START_ADDR+40h
START:			LXI		H,0C000h
				SPHL					; set stack pointer
				CALL	USART_INIT		; initialize UART
				CALL	VFD_INIT		; initialize VFD
               
				MVI		A,1Bh			; Unmask RST 7.5
				SIM
				EI						; Enable interrupts

; Loop while waiting for ESC key
ESC_WAIT:       CALL	USART_IN		; Read character from USART
				CPI		1Bh				; Is it ESC?
				JNZ		ESC_WAIT		; Not ESC, keep waiting
				RST		0				; Exit to MON85

; Keypad interrupt service routine                
KEYPAD_ISR:     PUSH	PSW				; Save A and flags
				IN		KEYPAD_DATA		; Read data from keypad
				ANI		1Fh				; Keypad outputs only lower 5 bits, clear higher bits
				ADI		30h				; Convert to ASCII / Hexadecimal
                CPI     3Ah             ; Is it a digit (0-9)?
				JC		PRINT_CHAR		; Yes a digit, print it
				ADI		07h				; Otherwise convert to a letter (A-J)
PRINT_CHAR:		CALL	USART_OUT		; Print it to USART
                CALL	VFD_SEND_DATA	; Print it to VFD
				POP		PSW				; Restore A and flags
				EI						; Re-enable interrupts
				RET
				
; Initialize USART
USART_INIT:		PUSH	PSW
				MVI		A,00h			; Set USART to command mode,
				OUT		USART_CMD		; and configure for sync operation
				OUT		USART_CMD		; Write two dummy sync characters
				OUT		USART_CMD

				MVI		A,40h			; Send reset command
				OUT		USART_CMD
				
				MVI     A,4Eh			; Write mode instruction: 1 stop bit,
				OUT		USART_CMD		; no parity, 8 bits, divide clock by 16

				MVI     A,37h			; Write command instruction: activate RTS,
				OUT     USART_CMD		; reset error flags, enable RX, activate DTR, enable TX

				IN		USART_DATA		; Clear the data register
				POP		PSW
				RET

; Read character from USART
; Input:	None
; Output:	A - character read from UART
USART_IN:		IN		USART_CMD		; Read USART status
				ANI		2				; Test RxRdy bit
				JZ		USART_IN		; Wait for the data
				IN		USART_DATA		; Read character
				RET

; Write character to USART
; Input:	A - character to write
; Output:	None
USART_OUT:		PUSH	PSW
USART_OUT_WAIT:	IN		USART_CMD
				ANI		1				; Test TxRdy
				JZ		USART_OUT_WAIT	; Wait until USART is ready to transmit
				POP		PSW
				OUT		USART_DATA		; Write character
				RET

; Initialize VFD
; Note:		Some parameters below are display specific
VFD_INIT:		PUSH	PSW
				MVI		A,18h			; Set interface data length to 8 bits,
				CALL	VFD_SEND_CMD	; two lines, 5x8 dots characters
				MVI		A,01h			; Clear display, reset address to 0
				CALL	VFD_SEND_CMD
				MVI		A,06h           ; Move cursor right, do not shift display
                CALL     VFD_SEND_CMD
				MVI		A,0Fh			; Display on, cursor on, blinking cursor
                CALL     VFD_SEND_CMD
				POP		PSW
				RET

; Write command to VFD
; Input:	A - command to write
; Output:	None
VFD_SEND_CMD:	PUSH	PSW
VFD_CMD_WAIT:	IN		VFD_CMD			; Read busy flag
				ANI		80h				; Isolate it
				JNZ		VFD_CMD_WAIT
				POP		PSW
				OUT		VFD_CMD			; Send the command
				RET
				
; Write a data byte to VFD
; Input:	A - data byte to write
; Output:	None
VFD_SEND_DATA:	PUSH	PSW
VFD_DATA_WAIT:	IN		VFD_CMD			; Read busy flag
				ANI		80h				; Isolate it
				JNZ		VFD_DATA_WAIT
				POP		PSW
				OUT		VFD_DATA		; Send the data byte
				RET