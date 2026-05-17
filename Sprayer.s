

EXTI_BASE       EQU 0x40013C00
EXTI_PR         EQU 0x14
TIM1_BASE       EQU 0x40010000
TIM_CCR4        EQU 0x40
SERVO_0_DEG     EQU 500
SERVO_90_DEG    EQU 1500
HOLD_DELAY      EQU 800000
	  
	  

	EXPORT EXTI15_10_IRQHandler
	EXPORT Delay_ISR


		
		AREA |.text|, CODE, READONLY
    THUMB	
		
EXTI15_10_IRQHandler   ;PA11(OUTPUT SERVO) ,    PA12 (Input IR)
    PUSH {R0-R5, LR}        

    ; 1. Clear Pending Bit for Line 12
    LDR R0, =EXTI_BASE+EXTI_PR
    MOV R1, #0x1000
    STR R1, [R0]

    ; 2. Move Servo to 90 Degrees
    LDR R5, =TIM1_BASE+TIM_CCR4
    LDR R2, =SERVO_90_DEG
	
    STR R2, [R5]
    LDR R3, =HOLD_DELAY
Delay_ISR
    SUBS R3, R3, #1
    BNE Delay_ISR

    ; 4. Return to 0 Degrees
    LDR R2, =SERVO_0_DEG
    STR R2, [R5]
	
	MOV 	 R4, #9

    POP {R0-R5, PC}          
    ALIGN
		
    END