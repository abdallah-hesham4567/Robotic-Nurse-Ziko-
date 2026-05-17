		
GPIOA_BASE      EQU 0x40020000
GPIOB_BASE      EQU 0x40020400
GPIO_BSRR       EQU 0x18
			
			
		AREA |.text|, CODE, READONLY
    THUMB	
	
	
		EXPORT Forward
		EXPORT Backward
		EXPORT Right
		EXPORT Left
		EXPORT Stop
	    import ROBOT_MOVING
		
Forward                   ; Forward
   PUSH {LR}
    LDR  R0, =GPIOA_BASE + GPIO_BSRR
    LDR  R1, =0x01E00000        ; PA5=0, PA6=0, PA7=0, PA8=0
    STR  R1, [R0]
    MOV  R1, #0x00A0            ; PA5=1, PA7=1
    STR  R1, [R0]
    
    LDR  R0, =GPIOB_BASE + GPIO_BSRR
    LDR  R1, =0x04070000        ; PB0=0, PB1=0, PB2=0, PB10=0
    STR  R1, [R0]
    MOV  R1, #0x0005            ; PB0=1, PB2=1
    STR  R1, [R0]
	
	;BL   ROBOT_MOVING
    POP  {PC}
	

Backward                   ; Backward
   PUSH {LR}
    LDR  R0, =GPIOA_BASE + GPIO_BSRR
    LDR  R1, =0x01E00000        ; PA5=0, PA6=0, PA7=0, PA8=0
    STR  R1, [R0]
    MOV  R1, #0x0140            ; PA6=1, PA8=1
    STR  R1, [R0]
    
    LDR  R0, =GPIOB_BASE + GPIO_BSRR
    LDR  R1, =0x04070000        ; PB0=0, PB1=0, PB2=0, PB10=0
    STR  R1, [R0]
    MOV  R1, #0x0402            ; PB1=1, PB10=1
    STR  R1, [R0]
	
	;BL   ROBOT_MOVING
    POP  {PC}

Right                   ; Right
	PUSH {LR}
    LDR  R0, =GPIOA_BASE + GPIO_BSRR
    LDR  R1, =0x01E00000        ; PA5=0, PA6=0, PA7=0, PA8=0
    STR  R1, [R0]
    MOV  R1, #0x00A0            ; PA5=1, PA7=1
    STR  R1, [R0]
    
    LDR  R0, =GPIOB_BASE + GPIO_BSRR
    LDR  R1, =0x04070000        ; PB0=0, PB1=0, PB2=0, PB10=0
    STR  R1, [R0]
    MOV  R1, #0x0402            ; PB1=1, PB10=1
    STR  R1, [R0]
	
	;BL   ROBOT_MOVING
    POP  {PC}
Left                   ; Left
   PUSH {LR}
    LDR  R0, =GPIOA_BASE + GPIO_BSRR
    LDR  R1, =0x01E00000        ; PA5=0, PA6=0, PA7=0, PA8=0
    STR  R1, [R0]
    MOV  R1, #0x0140            ; PA6=1, PA8=1
    STR  R1, [R0]
    
    LDR  R0, =GPIOB_BASE + GPIO_BSRR
    LDR  R1, =0x04070000        ; PB0=0, PB1=0, PB2=0, PB10=0
    STR  R1, [R0]
    MOV  R1, #0x0005            ; PB0=1, PB2=1
    STR  R1, [R0]
	
	;BL   ROBOT_MOVING
    POP  {PC}
Stop                   ; stop
   PUSH {LR}
    LDR  R0, =GPIOA_BASE + GPIO_BSRR
    LDR  R1, =0x01E00000        ; PA5=0, PA6=0, PA7=0, PA8=0
    STR  R1, [R0]
	
    LDR  R0, =GPIOB_BASE + GPIO_BSRR
    LDR  R1, =0x04070000        ; PB0=0, PB1=0, PB2=0, PB10=0
    STR  R1, [R0]
    POP  {PC}

    END
		