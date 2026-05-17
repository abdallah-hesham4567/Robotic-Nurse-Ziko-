		AREA    |.text|, CODE, READONLY
        THUMB
        ;EXPORT  Audio
			
			
		EXPORT  PlayAudio
		EXPORT	Forever
		EXPORT	DF_Play_Track
		EXPORT	USART_Send_Byte
		EXPORT	Wait1_TXE
		EXPORT	Delay1_Loop
		EXPORT	L1
			
			
USART2_SR       EQU     0x40004400
USART2_DR       EQU     0x40004404

USART_SR_TXE    EQU     (1 << 7)


PlayAudio PROC

		PUSH{LR}

        LDR     R0, =0x00FFFFFF
        BL      Delay1_Loop

;        MOV     R4, #9		

        MOV     R0, R4
        BL      DF_Play_Track
		
		POP     {PC}

Forever
        B       Forever

        ENDP

DF_Play_Track PROC

        PUSH    {R1-R7, LR}

        MOV     R7, R0

        MOV     R2, #0x7E
        BL      USART_Send_Byte

        MOV     R2, #0xFF
        BL      USART_Send_Byte

        MOV     R2, #0x06
        BL      USART_Send_Byte

        MOV     R2, #0x0F
        BL      USART_Send_Byte

        MOV     R2, #0x00
        BL      USART_Send_Byte

        MOV     R2, #0x01
        BL      USART_Send_Byte

        MOV     R2, R7
        BL      USART_Send_Byte

        MOV     R1, #0x115
        ADD     R1, R1, R7
        RSB     R1, R1, #0

        LSRS    R2, R1, #8
        BL      USART_Send_Byte

        MOV     R2, R1
        BL      USART_Send_Byte

        MOV     R2, #0xEF
        BL      USART_Send_Byte

        POP     {R1-R7, PC}

        ENDP

USART_Send_Byte PROC
	
        PUSH    {R3, R4, LR}

        LDR     R3, =USART2_SR

Wait1_TXE

        LDR     R4, [R3]
        TST     R4, #USART_SR_TXE
        BEQ     Wait1_TXE

        LDR     R3, =USART2_DR
        STRB    R2, [R3]

        ;Delay

        MOV     R0, #2000
        BL      Delay1_Loop

        POP     {R3, R4, PC}

        ENDP

Delay1_Loop PROC

        PUSH    {LR}

L1
        SUBS    R0, R0, #1
        BNE     L1

        POP     {PC}

        ENDP

        END