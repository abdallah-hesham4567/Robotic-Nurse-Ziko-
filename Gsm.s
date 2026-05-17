

;===============================================================================
; DELAYS
;===============================================================================

DELAY_3S            EQU     16000000
DELAY_1S  EQU  8000000
USART1_BASE         EQU     0x40011000
USART1_SR           EQU     (USART1_BASE + 0x00)
USART1_DR           EQU     (USART1_BASE + 0x04)
USART_SR_TXE    EQU     (1 << 7)

        AREA    |.text|, CODE, READONLY
        THUMB
        EXPORT  Com
		EXPORT	USART_SendChar
		EXPORT	Wait_TXE
		EXPORT	USART_SendString
		EXPORT	Next_Char
		EXPORT	Done_String
		EXPORT	Delay_Ticks
		EXPORT	Delay_Loop
		EXPORT  WATER
		EXPORT  FALL
		EXPORT  PAIN
		EXPORT  MEDICATION
		EXPORT  MEAL
		IMPORT PlayAudio
		IMPORT CALLING_HELP

Com PROC

		PUSH    {LR}
		
        LDR     R0, =DELAY_3S
        BL      Delay_Ticks

        LDR     R0, =str_Dial
        BL      USART_SendString
		
		;BL CALLING_HELP
		
		POP     {PC}            
        ENDP

WATER	PROC
		PUSH    {LR}
		
		LDR     R0, =DELAY_3S
        BL      Delay_Ticks

        LDR     R0, =str_CMGF
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks


        LDR     R0, =str_CMGS
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks

        LDR     R0, =str_WATER
        BL      USART_SendString
		
        MOV     R0, #0x1A
        BL      USART_SendChar
		
		MOV 	 R4, #3
		BL		 PlayAudio
		
		POP     {PC}            
        ENDP
			
			
MEDICATION	PROC
		PUSH    {LR}
		
		LDR     R0, =DELAY_3S
        BL      Delay_Ticks

        LDR     R0, =str_CMGF
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks


        LDR     R0, =str_CMGS
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks

        LDR     R0, =str_MEDICATION
        BL      USART_SendString
		
        MOV     R0, #0x1A
        BL      USART_SendChar
		
		POP     {PC}            
        ENDP
			
MEAL	PROC
		PUSH    {LR}
		
		LDR     R0, =DELAY_3S
        BL      Delay_Ticks

        LDR     R0, =str_CMGF
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks


        LDR     R0, =str_CMGS
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks

        LDR     R0, =str_MEAL
        BL      USART_SendString
		
        MOV     R0, #0x1A
        BL      USART_SendChar
		
		
		
		
		POP     {PC}            
        ENDP
			
PAIN	PROC
		PUSH    {LR}
		
		LDR     R0, =DELAY_3S
        BL      Delay_Ticks

        LDR     R0, =str_CMGF
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks


        LDR     R0, =str_CMGS
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks

        LDR     R0, =str_PAIN
        BL      USART_SendString
		
        MOV     R0, #0x1A
        BL      USART_SendChar
		

		POP     {PC}            
        ENDP
			
FALL	PROC
		PUSH    {LR}
		
		LDR     R0, =DELAY_3S
        BL      Delay_Ticks

        LDR     R0, =str_CMGF
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks


        LDR     R0, =str_CMGS
        BL      USART_SendString

        LDR     R0, =DELAY_1S
        BL      Delay_Ticks

        LDR     R0, =str_FALL
        BL      USART_SendString
		
        MOV     R0, #0x1A
        BL      USART_SendChar
		
	
		
		POP     {PC}            
        ENDP

USART_SendChar PROC

        PUSH    {R1, R2, LR}

        LDR     R1, =USART1_SR

Wait_TXE
        LDR     R2, [R1]
        TST     R2, #USART_SR_TXE
        BEQ     Wait_TXE

        LDR     R1, =USART1_DR
        STRB    R0, [R1]

        POP     {R1, R2, PC}

        ENDP

;==================================
; USART_SendString
;================================

USART_SendString PROC

        PUSH    {R4, LR}

        MOV     R4, R0

Next_Char
        LDRB    R0, [R4], #1

        CBZ     R0, Done_String

        BL      USART_SendChar

        B       Next_Char

Done_String
        POP     {R4, PC}

        ENDP

;==================================
; Delay_Ticks
;==================================

Delay_Ticks PROC

        PUSH    {LR}

Delay_Loop
        SUBS    R0, R0, #1
        BNE     Delay_Loop

        POP     {PC}

        ENDP

;==================================
; DATA
;==================================
		AREA |.rodata|, DATA, READONLY

str_CMGF   DCB "AT+CMGF=1",0x0D,0x0A,0x00

str_CMGS   DCB "AT+CMGS=",'"',"+201062014241",'"',0x0D,0x0A,0x00

str_WATER    DCB "[ROOM 1] Patient requests water.",0x00

str_MEDICATION    DCB "[ROOM 1] Patient requests medication assistance.",0x00

str_MEAL    DCB "[ROOM 1] Patient requests meal.",0x00

str_PAIN    DCB "[ROOM 1] Patient reports severe pain.",0x00

str_FALL    DCB "[ROOM 1] ALERT: Possible patient fall detected.",0x00

str_Dial  DCB   "ATD+201062014241;", 0x0D, 0x0A, 0x00

        END