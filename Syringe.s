

TIM2_BASE       EQU 0x40000000
TIM_CCR2        EQU 0x38

		
	AREA |.text|, CODE, READONLY
    THUMB	

	EXPORT Syrange
	EXPORT SET_180
	EXPORT SET_0
	IMPORT Injection_active




Syrange  ;       PA1

	LDR R0, =TIM2_BASE+TIM_CCR2
    LDR R1, [R0]
    LDR R3, =1500
    CMP R1, R3
    BGT SET_0
 
SET_180
    LDR R1, =2500
    STR R1, [R0]
	
	;BL Injection_active
    BX LR

SET_0
    LDR R1, =500
    STR R1, [R0]
	
	;BL Injection_active
	MOV 	 R4, #10
	BX LR
	
	
	END
		