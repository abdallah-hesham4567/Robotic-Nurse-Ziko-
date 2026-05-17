

	EXPORT MOVE_UP
	EXPORT MOVE_DOWN
	EXPORT label_to_pop_2
	EXPORT move_motor1_func1
	EXPORT  move_motor2_func1
	EXPORT move_motor3_func1
	EXPORT move_motor1_func2
	EXPORT move_motor2_func2
	EXPORT move_motor3_func2
	EXPORT stop_motor_ARM
	EXPORT loop
	IMPORT flag
	import func1_motor1
	import func1_motor2
	import func1_motor3
	
	import func2_motor1 
	import func2_motor2 
	import func2_motor3 


GPIOB_BASE     EQU 0x40020400
GPIO_ODR        EQU 0x14

	
	
	AREA |.text|, CODE, READONLY
			ALIGN
		
		
MOVE_UP
	push{lr}

	ldr r0, =flag
	ldr r1, [r0]
	
	cmp r1, #1
	bne label_to_pop_1

	bic r1, r1, #1 ;setting the flag to 0
	str r1, [r0]

	bl move_motor1_func1
	bl stop_motor_ARM
	bl delay
	
	bl move_motor2_func1
	bl stop_motor_ARM
	bl delay
		
	bl move_motor3_func1
	bl stop_motor_ARM
	bl delay	
	
label_to_pop_1
	pop{pc}

MOVE_DOWN
	push{lr}

	ldr r0, =flag
	ldr r1, [r0]
	cmp r1, #0
	bne label_to_pop_2
	
	orr r1, r1, #1 ;setting flag to 1
	str r1, [r0]

	bl move_motor1_func2
	bl stop_motor_ARM
	bl delay
	
	bl move_motor2_func2
	bl stop_motor_ARM
	bl delay
		
	bl move_motor3_func2
	bl stop_motor_ARM
	bl delay	
	
label_to_pop_2
	pop{pc}
	
move_motor1_func1
	ldr r2, =func1_motor1
	ldr r3, [r2]
	
	ldr r0, =GPIOB_BASE+GPIO_ODR
	ldr r1, [r0]
	bic r1, r1, #(0x3 << 12)
	orr r1, r1, #(0x2 << 12) ;set B12,13 to 1 0 resp.
	str r1, [r0]
	b loop

	
move_motor2_func1
	ldr r2, =func1_motor2
	ldr r3, [r2]
	
	ldr r0, =GPIOB_BASE+GPIO_ODR
	ldr r1, [r0]
	bic r1, r1, #(0x3 << 14)
	orr r1, r1, #(0x1 << 14) ;set B14,15 to 1 0 resp.
	str r1, [r0]
	b loop


move_motor3_func1
	ldr r2, =func1_motor3
	ldr r3, [r2]
	
	ldr r0, =GPIOB_BASE+GPIO_ODR
	ldr r1, [r0]
	bic r1, r1, #(0x3 << 8)
	orr r1, r1, #(0x1 << 8) ;set B8,9 to 1 0 resp.
	str r1, [r0]
	b loop

	
move_motor1_func2
	ldr r2, =func2_motor1
	ldr r3, [r2]
	
	ldr r0, =GPIOB_BASE+GPIO_ODR
	ldr r1, [r0]
	bic r1, r1, #(0x3 << 12)
	orr r1, r1, #(0x1 << 12) ;set B12,13 to 0 1 resp. inverse of func1
	str r1, [r0]
	b loop
	
move_motor2_func2
	ldr r2, =func2_motor2
	ldr r3, [r2]
	
	ldr r0, =GPIOB_BASE+GPIO_ODR
	ldr r1, [r0]
	bic r1, r1, #(0x3 << 14)
	orr r1, r1, #(0x2 << 14) ;set B14,15 to 0 1 resp.inverse of func1
	str r1, [r0]
	b loop
	
move_motor3_func2
	ldr r2, =func2_motor3
	ldr r3, [r2]
	
	ldr r0, =GPIOB_BASE+GPIO_ODR
	ldr r1, [r0]
	bic r1, r1, #(0x3 << 8)
	orr r1, r1, #(0x2 << 8) ;set B8,9 to 0 1 resp.inverse of func1
	str r1, [r0]
	b loop
	
stop_motor_ARM
	ldr r0, =GPIOB_BASE+GPIO_ODR
	ldr r1, [r0]
	bic r1, r1, #(0xF << 12)
	bic r1, r1, #(0x3 << 8)
	str r1, [r0]
	bx lr
	
loop
	subs r3, r3, #1
	bne loop
	
	bx lr
	
delay
	ldr r0, =30000
delay_loop
	subs r0, r0, #1
	bne delay_loop
	bx lr
	
		END
			