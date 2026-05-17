


GPIOB_BASE      EQU 0x40020400
GPIOA_BASE      EQU 0x40020000
GPIO_ODR        EQU 0x14
	
	




		AREA |.text|, CODE, READONLY
    THUMB	

	EXPORT Func_Rotate_Motor
	EXPORT move_motor
	EXPORT write_step_motor1
	EXPORT stop_motor
	EXPORT DELAY
	EXPORT DELAY_LOOP
	IMPORT motor1_cycles
    IMPORT Preparing_Dose

Func_Rotate_Motor
	PUSH {LR}

	BL move_motor
	
	;BL Preparing_Dose
	POP  {PC}



move_motor
	
    MOV R1, #(0x1 << 3); ON A15: 1
	MOV R2, #(1 << 15)
    BL write_step_motor1
	BL DELAY


	MOV R1, #(0x3 << 3) ; ON A15: 0
	MOV R2, #(0 << 15)
    BL write_step_motor1
    BL DELAY

	MOV R1, #(0x6 << 3) ; ON A15: 0
	MOV R2, #(0 << 15)
    BL write_step_motor1
    BL DELAY

	MOV R1, #(0x4 << 3) ;ON A15: 1
	MOV R2, #(1 << 15)
    BL write_step_motor1
    BL DELAY

	LDR R0, =motor1_cycles
    LDR R1, [R0]
	SUBS R1, R1, #1
	BEQ stop_motor   
	STR  R1, [R0]

    B move_motor
	
; =============================
; WRITE STEP
; =============================

write_step_motor1

    LDR R0, =GPIOB_BASE + GPIO_ODR
    LDR R3, [R0]
    BIC R3, R3, #(0x7 << 3)   ; clear PB3,4,5
    ORR R3, R3, R1           
	
	LDR R5, =GPIOA_BASE + GPIO_ODR
	LDR R4, [R5]
	BIC R4, R4, #(0X1 << 15)
	ORR R4, R4, R2
	
	STR R4, [R5]
    STR R3, [R0]

    BX LR
    
; ============================
; DELAY
; ===========================
stop_motor
	
	LDR R0, =GPIOB_BASE
    LDR R3, [R0, #GPIO_ODR] 
    BIC R3, R3, #(0x7 << 3)
	STR R3,[R0, #GPIO_ODR]
	
	LDR R0, =GPIOA_BASE
    LDR R3, [R0, #GPIO_ODR] 
    BIC R3, R3, #(0x1 << 15)
	STR R3,[R0, #GPIO_ODR]
	
	LDR R0, =motor1_cycles
	LDR R1, =0XA0
	STR R1, [R0]
	pop{pc}
  
  
DELAY
    PUSH {R2}
    LDR R2, =32000

DELAY_LOOP
    SUBS R2, R2, #1
    BNE DELAY_LOOP

    POP {R2}
    BX LR
	
	END
		