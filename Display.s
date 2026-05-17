
; ============================================================
;  I2C LCD 2004 - Stable Display (Static Text)
;  Writing "ELFa7L" on the 2nd line - Constant Backlight
; ============================================================

; -- 1. ????????? (Definitions) ---------------------


LCD_ADDR        EQU     0x4E            
LCD_BL          EQU     0x08            
LCD_EN          EQU     0x04       

I2C1_BASE       EQU     0x40005400
I2C1_CR1        EQU     I2C1_BASE + 0x00
I2C1_CR2        EQU     I2C1_BASE + 0x04
I2C1_DR         EQU     I2C1_BASE + 0x10
I2C1_SR1        EQU     I2C1_BASE + 0x14
I2C1_SR2        EQU     I2C1_BASE + 0x18
I2C1_CCR        EQU     I2C1_BASE + 0x1C
I2C1_TRISE      EQU     I2C1_BASE + 0x20
	
ADC1_SR         EQU     0x40012000
ADC1_CR2        EQU     0x40012008
ADC1_SMPR2      EQU     0x40012010
ADC1_SQR3       EQU     0x40012034
ADC1_DR         EQU     0x4001204C

GPIOBEN         EQU     (1 :SHL: 1)
I2C1EN          EQU     (1 :SHL: 21)

                AREA    |.text|, CODE, READONLY
                THUMB

			EXPORT Injection_active
			EXPORT ROBOT_MOVING
			EXPORT Spraying
			EXPORT AUDIO
			EXPORT CALLING_HELP
			EXPORT Preparing_Dose
			EXPORT ARM_MOVING
			EXPORT Delay_ms
    		EXPORT Delay2_Loop
         	EXPORT LCD_WriteByte
			EXPORT Show_Temperature
			

Injection_active PROC
	PUSH{LR}

				BL     LCD_Clear
				BL     LCD_Line1
				
								
				MOV     R0, #'I'
                MOV     R1, #1
                BL      LCD_WriteByte 
								
				MOV     R0, #'n'
                MOV     R1, #1
                BL      LCD_WriteByte 

				MOV     R0, #'j'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'e'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'c'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'t'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'i'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'o'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'n'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'A'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				
				MOV     R0, #'c'
                MOV     R1, #1
                BL      LCD_WriteByte


                MOV     R0, #'t'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'i'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'v'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				
				MOV     R0, #'e'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				POP{PC}
				ENDP

				LTORG


ROBOT_MOVING	PROC
			PUSH {LR}
				BL     LCD_Clear
				BL     LCD_Line1


                MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte
				

                MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'R'
                MOV     R1, #1
                BL      LCD_WriteByte 
								
				MOV     R0, #'o'
                MOV     R1, #1
                BL      LCD_WriteByte 

				MOV     R0, #'b'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'o'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'t'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'M'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'o'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'v'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'i'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'n'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				
				MOV     R0, #'g'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				POP{PC}

               
				ENDP
				
Spraying	PROC
	PUSH{LR}


				BL     LCD_Clear
				BL     LCD_Line1
				
				MOV     R0, #'S'
                MOV     R1, #1
                BL      LCD_WriteByte 
								
				MOV     R0, #'p'
                MOV     R1, #1
                BL      LCD_WriteByte 

				MOV     R0, #'r'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'a'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'y'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'i'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'n'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'g'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'A'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'l'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				
				MOV     R0, #'c'
                MOV     R1, #1
                BL      LCD_WriteByte


                MOV     R0, #'o'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'h'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'o'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				
				MOV     R0, #'l'
                MOV     R1, #1
                BL      LCD_WriteByte

			POP{PC}
                ENDP
				
				LTORG
	
				
AUDIO PROC
	PUSH{LR}
				BL     LCD_Clear
				BL     LCD_Line1


                MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte
				

                MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'A'
                MOV     R1, #1
                BL      LCD_WriteByte 
								
				MOV     R0, #'u'
                MOV     R1, #1
                BL      LCD_WriteByte 

				MOV     R0, #'d'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'i'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'o'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'P'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'l'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'a'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'y'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'i'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				
				MOV     R0, #'n'
                MOV     R1, #1
                BL      LCD_WriteByte


                MOV     R0, #'g'
                MOV     R1, #1
                BL      LCD_WriteByte
				POP{PC}

				
               ENDP
				
				LTORG
			
CALLING_HELP PROC
				
				PUSH{LR}

				BL     LCD_Clear
				BL     LCD_Line1


				MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte


				MOV     R0, #'E'
                MOV     R1, #1
                BL      LCD_WriteByte 
								
				MOV     R0, #'m'
                MOV     R1, #1
                BL      LCD_WriteByte 

				MOV     R0, #'e'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'r'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'g'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'e'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'n'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'c'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'y'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'C'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				
				MOV     R0, #'a'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'l'
                MOV     R1, #1
                BL      LCD_WriteByte

				MOV     R0, #'l'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				POP{PC}
                ENDP
				
				LTORG
				

; ============================================================
; Call this function from your IR remote decoder
; ============================================================
Show_Temperature PROC
        PUSH    {LR}

        ; --- Clear LCD and measure ---
        BL      LCD_Clear
        BL      LCD_Line1

        ; --- Print "Temp: " ---
        MOV     R0, #'T'
        MOV     R1, #1                  ; RS = 1 (Data)
        BL      LCD_WriteByte
        MOV     R0, #'e'
        MOV     R1, #1
        BL      LCD_WriteByte
        MOV     R0, #'m'
        MOV     R1, #1
        BL      LCD_WriteByte
        MOV     R0, #'p'
        MOV     R1, #1
        BL      LCD_WriteByte
        MOV     R0, #':'
        MOV     R1, #1
        BL      LCD_WriteByte
        MOV     R0, #' '
        MOV     R1, #1
        BL      LCD_WriteByte
		
		BL      measure_temp            ; R2 will contain the temp

        ; --- Extract and Print Digits ---
       ; Extract and Print Digits
		; ADD     R2 ,R2 ,#7
         MOV     R1, #10
         UDIV    R4, R2, R1              ; Tens digit
		 MUL	 R3, R4, R1
		 SUB 	 R3, R2, R3

         ADD     R0, R4, #0x30           ; Convert Tens to ASCII
         MOV     R1, #1
         BL      LCD_WriteByte
        
		 
         ADD     R0, R3, #0x30           ; Convert Ones to ASCII
         MOV     R1, #1
         BL      LCD_WriteByte

        ; --- Print Unit " C" ---
        MOV     R0, #0xDF               ; Degree symbol character
		MOV 	R1,#1
        BL      LCD_WriteByte
        MOV     R0, #'C'
        MOV     R1, #1
        BL      LCD_WriteByte
     
        LDR     R0, =2000               ; Pass 2000ms to Delay_ms via R0
        BL      Delay_ms

        ; Returning allows the robot to accept new remote commands!
        POP     {PC}
        ENDP
        LTORG
		
		
measure_temp PROC
        PUSH	{LR}

        ; --- Start Conversion ---
        LDR     R0, =ADC1_CR2
        LDR     R1, [R0]
        ORR     R1, R1, #(1 << 30)      ; SWSTART
        STR     R1, [R
		0]

        ; --- Wait EOC ---
Wait_EOC
        LDR     R0, =ADC1_SR
        LDR     R1, [R0]
        TST     R1, #(1 << 1)
        BEQ     Wait_EOC

        ; --- Read ADC ---
        LDR     R0, =ADC1_DR
        LDR     R2, [R0]
		
        ; --- Convert to Celsius ---
        LDR     R5, =50
        MUL     R2, R5, R2
        LDR     R5, =4095
        UDIV    R2, R2, R5              ; R4 now holds the actual temp
		
        POP     {PC}
        ALIGN
        ENDP
Preparing_Dose PROC
			PUSH{LR}
				BL     LCD_Clear
				BL     LCD_Line1

                MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'P'
                MOV     R1, #1
                BL      LCD_WriteByte 
								
				MOV     R0, #'r'
                MOV     R1, #1
                BL      LCD_WriteByte 

				MOV     R0, #'e'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'p'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'a'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'r'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'i'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'n'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'g'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'D'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				
				MOV     R0, #'o'
                MOV     R1, #1
                BL      LCD_WriteByte


                MOV     R0, #'s'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'e'
                MOV     R1, #1
                BL      LCD_WriteByte
					
			POP{PC}
					
              ENDP
				
			LTORG


ARM_MOVING	PROC
				PUSH{LR}

				BL     LCD_Clear
				BL     LCD_Line1		
                MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte
				
				MOV     R0, #'A'
                MOV     R1, #1
                BL      LCD_WriteByte 
								
				MOV     R0, #'r'
                MOV     R1, #1
                BL      LCD_WriteByte 

				MOV     R0, #'m'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'A'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'c'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'t'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'i'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'v'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #'e'
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				MOV     R0, #' '
                MOV     R1, #1
                BL      LCD_WriteByte 
				
				
				MOV     R0, #'N'
                MOV     R1, #1
                BL      LCD_WriteByte


                MOV     R0, #'o'
                MOV     R1, #1
                BL      LCD_WriteByte
				
				
				MOV     R0, #'w'
                MOV     R1, #1
                BL      LCD_WriteByte
				POP{PC}

               ENDP
				
				LTORG

; ============================================================
;   (Subroutines) 
; ============================================================

I2C_Start       PROC
                LDR     R0, =I2C1_CR1
                LDR     R1, [R0]
                ORR     R1, R1, #(1 :SHL: 8)
                STR     R1, [R0]
                LDR     R0, =I2C1_SR1
Wait_SB         LDR     R1, [R0]
                TST     R1, #(1 :SHL: 0)
                BEQ     Wait_SB
                BX      LR
                ENDP

I2C_Addr        PROC
                LDR     R1, =I2C1_DR
                STR     R0, [R1]
                LDR     R1, =I2C1_SR1
Wait_ADDR       LDR     R2, [R1]
                TST     R2, #(1 :SHL: 1)
                BEQ     Wait_ADDR
                LDR     R1, =I2C1_SR2
                LDR     R2, [R1]
                BX      LR
                ENDP

I2C_Write       PROC
                LDR     R1, =I2C1_SR1
Wait_TxE        LDR     R2, [R1]
                TST     R2, #(1 :SHL: 7)
                BEQ     Wait_TxE
                LDR     R1, =I2C1_DR
                STR     R0, [R1]
                LDR     R1, =I2C1_SR1
Wait_BTF        LDR     R2, [R1]
                TST     R2, #(1 :SHL: 2)
                BEQ     Wait_BTF
                BX      LR
                ENDP

I2C_Stop        PROC
                LDR     R0, =I2C1_CR1
                LDR     R1, [R0]
                ORR     R1, R1, #(1 :SHL: 9)
                STR     R1, [R0]
                BX      LR
                ENDP

Delay_ms        PROC								
                LDR     R1, =4000					
                MUL     R1, R0, R1					
Delay2_Loop      SUBS    R1, R1, #1
                BNE     Delay2_Loop
                BX      LR
                ENDP

LCD_WriteByte   PROC
                PUSH    {R4, R5, R6, LR}   
                MOV     R4, R0
                MOV     R5, R1
                
                BL      I2C_Start
                MOV     R0, #LCD_ADDR
                BL      I2C_Addr

                AND     R0, R4, #0xF0
                ORR     R0, R0, R5
                ORR     R0, R0, #LCD_BL
                MOV     R6, R0             
                
                ORR     R0, R6, #LCD_EN    
                BL      I2C_Write
                MOV     R0, R6             
                BL      I2C_Write
                LSL     R0, R4, #4
                AND     R0, R0, #0xF0
                ORR     R0, R0, R5
                ORR     R0, R0, #LCD_BL
                MOV     R6, R0             
                
                ORR     R0, R6, #LCD_EN  
                BL      I2C_Write
                MOV     R0, R6             
                BL      I2C_Write

                BL      I2C_Stop
                MOV     R0, #2
                BL      Delay_ms
                
                POP     {R4, R5, R6, PC}   
                ENDP




;; CLEARING THE LCD

LCD_Clear       PROC
	
				PUSH {LR}
				
				MOV R0, #0x01    ;; Command means clear lcd
				MOV R1, #0
				BL      LCD_WriteByte
				
				MOV R0, #5      ;;  more time for guarantee the lcd cleared
				BL  Delay_ms
				
				POP {PC}
				ENDP


;; WRITE IN LINE 1

LCD_Line1       PROC
	
				PUSH{LR}
				
	            MOV     R0, #0x80     ;;; 0x80 >> command means write in line 1 
                MOV     R1, #0
                BL      LCD_WriteByte

				POP{PC}
				ENDP


;; WRITE IN LINE 2

LCD_Line2       PROC
	
				PUSH{LR}
				
	            MOV     R0, #0xC0     ;;; 0xC0 >> command means write in line 2 
                MOV     R1, #0
                BL      LCD_WriteByte

				POP{PC}
				ENDP		
					
                END