	import Forward
	import Backward
	import Right
	import Left
	import Stop
	import Func_Rotate_Motor
	import move_motor
	import write_step_motor1
	import stop_motor
	import DELAY
	import DELAY_LOOP
	import EXTI15_10_IRQHandler
	import Delay_ISR
	import Syrange
	import SET_180
	import SET_0
	import PlayAudio
	import	Forever
	import	DF_Play_Track
	import	USART_Send_Byte
	import	Wait_TXE
	import	Delay_Loop
	import	L1
		
	import  Com
	import	USART_SendChar
	import	Wait_TXE
	import	USART_SendString
	import	Next_Char
	import	Done_String
	import	Delay_Ticks
	import	Delay_Loop
	
	
	import Injection_active
	import ROBOT_MOVING
	import Spraying
	import AUDIO
	import CALLING_HELP
	import Preparing_Dose
	import ARM_MOVING
	import WATER
	IMPORT  FALL
	IMPORT  PAIN
	IMPORT  MEDICATION
	IMPORT  MEAL
		
	import Delay_ms
    import Delay2_Loop
    import LCD_WriteByte
	import Show_Temperature
	import MOVE_UP
	import MOVE_DOWN
		
	EXPORT func1_motor1
	EXPORT func1_motor2
	EXPORT func1_motor3
	
	EXPORT func2_motor1 
	EXPORT func2_motor2 
	EXPORT func2_motor3 
	EXPORT flag

	EXPORT motor1_cycles
	
	
	; ------------------------------------------------------------
;  DEFINITIONS (REGISTERS ADDR)
; ------------------------------------------------------------
RCC_BASE        EQU 0x40023800
RCC_AHB1ENR     EQU 0x30
RCC_APB1ENR     EQU 0x40
RCC_APB2ENR     EQU 0x44

GPIOA_BASE      EQU 0x40020000
GPIOC_BASE      EQU 0x40020800
GPIOB_BASE     EQU 0x40020400

GPIO_MODER      EQU 0x00
GPIO_PUPDR      EQU 0x0C
GPIO_ODR        EQU 0x14
GPIO_BSRR       EQU 0x18
GPIO_AFRL       EQU 0x20
GPIO_AFRH       EQU 0x24

SYSCFG_BASE     EQU 0x40013800
SYSCFG_EXTICR1  EQU 0x08
SYSCFG_EXTICR4  EQU  0x14

EXTI_BASE       EQU 0x40013C00
EXTI_IMR        EQU 0x00
EXTI_FTSR       EQU 0x0C
EXTI_PR         EQU 0x14

TIM2_BASE       EQU 0x40000000
TIM_CR1         EQU 0x00
TIM_PSC         EQU 0x28
TIM_ARR         EQU 0x2C
TIM_CNT         EQU 0x24
TIM_EGR         EQU 0x14	
TIM_CCMR1    EQU 0x18    ; Capture/Compare Mode Register 1
TIM_CCER     EQU 0x20    ; Capture/Compare Enable Register
TIM_CCR2     EQU 0x38    ; Capture/Compare Register 2
	
TIM1_BASE      EQU    0x40010000

TIM_CCMR2      EQU    0x1C
TIM_CCR4       EQU    0x40
TIM_BDTR       EQU    0x44

NVIC_ISER0      EQU 0xE000E100
NVIC_ISER1      EQU     0xE000E104
	
ADC1_SR         EQU     0x40012000
ADC1_CR2        EQU     0x40012008
ADC1_SMPR2      EQU     0x40012010
ADC1_SQR3       EQU     0x40012034
ADC1_DR         EQU     0x4001204C	

; Thresholds (µs) for NEC Protocol
LEADER_MIN      EQU 11000
LEADER_MAX      EQU 15000
ONE_MIN         EQU 1700
ONE_MAX         EQU 2800
ZERO_MIN        EQU 800
ZERO_MAX        EQU 1600
SERVO_0_DEG     EQU 500    ; 1ms pulse
SERVO_90_DEG    EQU 1500    ; 1.5ms pulse
HOLD_DELAY      EQU 800000
	
	
;===============================================
;Audio configuration 
;==============================================

GPIOA_MODER     EQU     0x40020000
GPIOA_OTYPER    EQU     0x40020004
GPIOA_OSPEEDR   EQU     0x40020008
GPIOA_PUPDR     EQU     0x4002000C
GPIOA_AFRH      EQU     0x40020024


USART1_BRR      EQU     0x40011008
USART1_CR1      EQU     0x4001100C
USART1_CR2      EQU     0x40011010
USART1_CR3      EQU     0x40011014

GPIOAEN         EQU     (1 << 0)
USART1EN        EQU     (1 << 4)
USART2EN         EQU     (1 << 17)
	

USART_CR1_RE    EQU     (1 << 2)
USART_CR1_TE    EQU     (1 << 3)
USART_CR1_UE    EQU     (1 << 13)
	
;======================================
;Communication
;=================================
USART2_BASE         EQU     0x40004400

USART2_SR           EQU     (USART2_BASE + 0x00)
USART2_DR           EQU     (USART2_BASE + 0x04)
USART2_BRR          EQU     (USART2_BASE + 0x08)
USART2_CR1          EQU     (USART2_BASE + 0x0C)

GPIOA_AFRL          EQU     (GPIOA_BASE + 0x20)

;===============================================
;Display Configuration
;==============================================



GPIOB_MODER     EQU     0x40020400
GPIOB_OTYPER    EQU     0x40020404
GPIOB_OSPEEDR   EQU     0x40020408
GPIOB_PUPDR     EQU     0x4002040C
GPIOB_AFRL      EQU     0x40020420

I2C1_BASE       EQU     0x40005400
I2C1_CR1        EQU     I2C1_BASE + 0x00
I2C1_CR2        EQU     I2C1_BASE + 0x04
I2C1_DR         EQU     I2C1_BASE + 0x10
I2C1_SR1        EQU     I2C1_BASE + 0x14
I2C1_SR2        EQU     I2C1_BASE + 0x18
I2C1_CCR        EQU     I2C1_BASE + 0x1C
I2C1_TRISE      EQU     I2C1_BASE + 0x20

GPIOBEN         EQU     (1 :SHL: 1)
I2C1EN          EQU     (1 :SHL: 21)









BRR_9600        EQU     0x0683
BRR_115200      EQU     0x008B



; ------------------------------------------------------------
;  RAM VARIABLES
; ------------------------------------------------------------
    AREA MYDATA, DATA, READWRITE
ir_bit_count    SPACE 4
ir_data         SPACE 4
ir_last_time    SPACE 4
ir_state        SPACE 4
motor1_cycles DCD 10
	
;=====================
;ARM
;======================
func1_motor1 DCD 0
func1_motor2 DCD 0
func1_motor3 DCD 0
	
func2_motor1 DCD 0
func2_motor2 DCD 0
func2_motor3 DCD 0
flag DCD 0



; ------------------------------------------------------------
;  CODE SECTION
; ------------------------------------------------------------
    AREA |.text|, CODE, READONLY
    THUMB

    EXPORT Reset_Handler
	
	
Reset_Handler
    B    __main

    EXPORT __main
__main
	LDR R0, =motor1_cycles
	LDR R1,[R0]
	LDR R1,=0XA0
	STR R1,[R0]
	
    ; 1. Enable Clocks (GPIOA, GPIOC, TIM2, SYSCFG)
     LDR  R0, =RCC_BASE
    LDR  R1, [R0, #RCC_AHB1ENR]
    ORR  R1, R1, #0x07          ; GPIOA(bit0) + GPIOB(bit1) + GPIOC(bit2)
    STR  R1, [R0, #RCC_AHB1ENR]
    LDR  R1, [R0, #RCC_APB1ENR]
    ORR  R1, R1, #0x01          ; TIM2(bit0)
    STR  R1, [R0, #RCC_APB1ENR]
    LDR  R1, [R0, #RCC_APB2ENR]
	LDR R2,=0X4001
    ORR  R1, R1, R2         ;  SYSCFG (bit 14)  TIM1 (bit 0) 
    STR  R1, [R0, #RCC_APB2ENR]

	

	LDR R0, =GPIOA_BASE                ; Load GPIOA Base Address just once
    
    LDR R1, [R0, #GPIO_MODER]
	BIC R1,R1,#0X0C          ; TO CLEAR BIT 2,3
    ORR R1, R1, #0x08  								;PA1 
    STR R1, [R0, #GPIO_MODER]

    LDR R1, [R0, #GPIO_PUPDR]
    BIC R1, R1, #0x03
    ORR R1, R1, #0x02
    STR R1, [R0, #GPIO_PUPDR]

    LDR R1, [R0, #GPIO_AFRL]            ; AF1 for PA1
    BIC R1, R1, #0xF0
    ORR R1, R1, #0x10
    STR R1, [R0, #GPIO_AFRL]
	
;===================== 
;CONFIGURATION Of ALCOHOL
;==========================
	LDR R0, =GPIOA_BASE+GPIO_MODER
    LDR R1, [R0]
    BIC R1, R1, #0x03C00000     ; Clear PA11, PA12
    ORR R1, R1, #0x00800000     ; PA11 = 10 (AF), PA12 = 00 (Input)
    STR R1, [R0]
	
	
	
; =====================================================================
;  MOVEMENT GPIO CONFIGURATION (PA5, PA6, PA7, PA8 & PB0, PB1, PB2, PB10)
; =================================================================
    
    ; --- Configure PA5, PA6, PA7, PA8 as General Purpose Output (01) ---
    LDR  R0, =GPIOA_BASE
    LDR  R1, [R0, #GPIO_MODER]
    LDR  R2, =0x0003FC00       
    BIC  R1, R1, R2
    LDR  R2, =0x00015400        
    ORR  R1, R1, R2
    STR  R1, [R0, #GPIO_MODER]

    ; --- Configure PB0, PB1, PB2, PB10 as General Purpose Output (01) ---
    LDR  R0, =GPIOB_BASE
    LDR  R1, [R0, #GPIO_MODER]
    LDR  R2, =0x0030003F       
    BIC  R1, R1, R2
    LDR  R2, =0x00100015      
    ORR  R1, R1, R2
    STR  R1, [R0, #GPIO_MODER]
	
	; =====================================================================
    ; GPIO CONFIGURATION FOR STEPPER (A15, B3, B4, B5) AND DISPLAY (B6, B7)
    ; =====================================================================
	
	; PB3, PB4, PB5 as General Purpose Output (01)
    LDR  R0, =GPIOB_BASE
    LDR  R1, [R0, #GPIO_MODER]
    LDR  R2, =0x00000FC0        ; Mask for PB3, PB4, PB5
    BIC  R1, R1, R2
    LDR  R2, =0x00000540        ; Set as Output (01)
    ORR  R1, R1, R2
    STR  R1, [R0, #GPIO_MODER]
	
	; PA15 as General Purpose Output (01)
    LDR  R0, =GPIOA_BASE
    LDR  R1, [R0, #GPIO_MODER]
    LDR  R2, =0xC0000000        ; Mask for PA15 (bits 30-31)
    BIC  R1, R1, R2
    LDR  R2, =0x40000000        ; Set as Output (01)
    ORR  R1, R1, R2
    STR  R1, [R0, #GPIO_MODER]
	
	

    LDR R0, =GPIOA_BASE+GPIO_PUPDR
    LDR R1, [R0]
    ORR R1, R1, #0x01000000     ; PA12 Pull-UP
    STR R1, [R0]

    ; Set AF1 (TIM1) for PA11 in AFRH
    LDR R0, =GPIOA_BASE+GPIO_AFRH
    LDR R1, [R0]
    BIC R1, R1, #0x0000F000     ; Clear AF bits for Pin 11
    ORR R1, R1, #0x00001000     ; AF1 (0001)
    STR R1, [R0]
	             
	
	; --- 1. Map PA12 to EXTI Line 12 ---
    LDR  R0, =SYSCFG_BASE      
    LDR  R1, [R0, #SYSCFG_EXTICR4] 
    BIC  R1, R1, #0x000F        
    STR  R1, [R0, #SYSCFG_EXTICR4] ; 0000 FOR PORT A

    ; --- 2. Configure EXTI Line 12 ---
    LDR  R0, =EXTI_BASE         
    LDR  R1, [R0, #EXTI_IMR]    
    ORR  R1, R1, #(1 << 12)     ; Enable  Line 12
    STR  R1, [R0, #EXTI_IMR]    
    
    LDR  R1, [R0, #EXTI_FTSR]  
    ORR  R1, R1, #(1 << 12)     ; Set Line 12 to trigger on Falling Edge
    STR  R1, [R0, #EXTI_FTSR]

    ; --- 3. Enable EXTI15_10 in NVIC ---
    LDR  R0, =NVIC_ISER1        ; ISER1 handles IRQs 32 to 63
    MOV  R1, #(1 << 8)          ; Bit 8 = IRQ 40 (EXTI15_10)
    STR  R1, [R0]               ; Enable the interrupt in NVIC
	
	
	

;;; CONFIGURE TIMER 2
    LDR  R0, =TIM2_BASE
    MOV  R1, #15               ; Prescaler = 15 -> 1MHz
    STR  R1, [R0, #TIM_PSC]
    LDR R1, =19999
    STR R1, [R0, #TIM_ARR]
 
    LDR R1, [R0, #TIM_CCMR1]           
    BIC R1, R1, #0xFF00
    ORR R1, R1, #0x6800
    STR R1, [R0, #TIM_CCMR1]

    LDR R1, [R0, #TIM_CCER]            
    ORR R1, R1, #0x0010
    STR R1, [R0, #TIM_CCER]

    LDR R1, [R0, #TIM_CR1]             
    ORR R1, R1, #1
	MOV R1,#0X01
	STR  R1, [R0, #TIM_EGR]
    STR R1, [R0, #TIM_CR1]
    

    LDR R1, =500                       
    STR R1, [R0, #TIM_CCR2]
	
	
	;;; CONFFIGURE TIMER 1
	LDR R0, =TIM1_BASE
    MOV R1, #15                ; PSC = 15 (1MHz)
    STR R1, [R0, #TIM_PSC]
    LDR R1, =19999             ; ARR = 20ms
    STR R1, [R0, #TIM_ARR]
    MOV R1, #0x6800            ; PWM Mode 1 on CH4
    STR R1, [R0, #TIM_CCMR2]
    MOV R1, #0x1000            ; Enable CH4
    STR R1, [R0, #TIM_CCER]
    LDR R1, =0x8000            ; MOE = 1 (Main Output Enable)
    STR R1, [R0, #TIM_BDTR]
    MOV R1, #1                 ; Start TIM1
    STR R1, [R0, #TIM_CR1]
	STR R1, [R0, #TIM_EGR]
	
	LDR R1, =500
	STR R1, [R0, #TIM_CCR4]


    ; 2. GPIO Config
    ; PC13,14,15 = Output (User LED)
    LDR  R0, =GPIOC_BASE
    LDR  R1, [R0, #GPIO_MODER]
    BIC  R1, R1, #0xFC000000
    ORR  R1, R1, #0x54000000
    STR  R1, [R0, #GPIO_MODER]

    ; PA0 = Input + Pull-up (IR Receiver)
    LDR  R0, =GPIOA_BASE
    LDR  R1, [R0, #GPIO_MODER]
    BIC  R1, R1, #0x03
    STR  R1, [R0, #GPIO_MODER]
    LDR  R1, [R0, #GPIO_PUPDR]
    BIC  R1, R1, #0x03
    ORR  R1, R1, #0x01
    STR  R1, [R0, #GPIO_PUPDR]


    ; 4. EXTI & NVIC Config
    LDR  R0, =SYSCFG_BASE
    LDR  R1, [R0, #SYSCFG_EXTICR1]
    BIC  R1, R1, #0x0F
    STR  R1, [R0, #SYSCFG_EXTICR1]

  LDR  R0, =EXTI_BASE
	LDR  R1, [R0, #EXTI_IMR]   ; read IMR correctly
	ORR  R1, R1, #0x01
	STR  R1, [R0, #EXTI_IMR]   ; write back to IMR

	LDR  R1, [R0, #EXTI_FTSR]  ; read FTSR separately
	ORR  R1, R1, #0x01
	STR  R1, [R0, #EXTI_FTSR]  ; write back to FTSR

    LDR  R0, =NVIC_ISER0
    MOV  R1, #(1 << 6)
    STR  R1, [R0]

    ; 5. Init RAM Variables
    LDR  R0, =ir_state
    MOV  R1, #0
    STR  R1, [R0]

;=============================================
;Audio Configuration
;============================================
        LDR     R0, =RCC_BASE+RCC_AHB1ENR
        LDR     R1, [R0]
        ORR     R1, R1, #GPIOAEN
        STR     R1, [R0]

        LDR     R0, =RCC_BASE+RCC_APB1ENR
        LDR     R1, [R0]
        ORR     R1, R1, #(1 << 17)
        STR     R1, [R0]

        LDR     R0, =GPIOA_MODER
        LDR     R1, [R0]
        BIC     R1, R1, #(0xF << 4)
        ORR     R1, R1, #(0xA << 4)
        STR     R1, [R0]

        LDR     R0, =GPIOA_AFRL
        LDR     R1, [R0]
        BIC     R1, R1, #(0xFF << 8)
        ORR     R1, R1, #(0x77 << 8)
        STR     R1, [R0]

        LDR     R0, =USART2_CR1
        MOV     R1, #0
        STR     R1, [R0]

        LDR     R0, =USART2_BRR
        LDR     R1, =BRR_9600
        STR     R1, [R0]

        LDR     R0, =USART2_BASE + 0x10
        MOV     R1, #0
        STR     R1, [R0]

        LDR     R0, =USART2_BASE + 0x14
        MOV     R1, #0
        STR     R1, [R0]

        LDR     R0, =USART2_CR1
        LDR     R1, =0x200C
        STR     R1, [R0]
;===========================================
;Communication Configuration
;===========================================

        LDR     R0, =RCC_BASE+RCC_AHB1ENR
        LDR     R1, [R0]
        ORR     R1, R1, #GPIOAEN
        STR     R1, [R0]

        LDR     R0, =RCC_BASE+	RCC_APB2ENR
        LDR     R1, [R0]
        ORR     R1, R1, #USART1EN
        STR     R1, [R0]

        LDR     R0, =GPIOA_MODER
        LDR     R1, [R0]
        LDR     R2, =0x003C0000
        BIC     R1, R1, R2
        LDR     R2, =0x00280000
        ORR     R1, R1, R2
        STR     R1, [R0]

        LDR     R0, =GPIOA_AFRH
        LDR     R1, [R0]
        LDR     R2, =0x00000FF0
        BIC     R1, R1, R2
        LDR     R2, =0x00000770
        ORR     R1, R1, R2
        STR     R1, [R0]

        LDR     R0, =USART1_BRR
        LDR     R1, =BRR_115200
        STR     R1, [R0]

        LDR     R0, =USART1_CR1
        LDR     R1, =(USART_CR1_UE :OR: USART_CR1_TE :OR: USART_CR1_RE)
        STR     R1, [R0]


;================================
;TEMPRATURE CONFIG
;===============================

       ; Configure PA4 as Analog
;
; PA4 uses MODER bits [9:8]
; 11 = Analog mode
; ============================================================

        LDR     R0, =GPIOA_MODER
        LDR     R1, [R0]

        BIC     R1, R1, #(3 << 8)
        ORR     R1, R1, #(3 << 8)

        STR     R1, [R0]

; ============================================================
; Enable ADC1 Clock
; ============================================================

        LDR     R0, =RCC_BASE+RCC_APB2ENR
        LDR     R1, [R0]

        ORR     R1, R1, #(1 << 8)

        STR     R1, [R0]

; ============================================================
; Set Sampling Time for Channel 4
;
; Channel 4 uses SMPR2 bits [14:12]
; 111 = 480 cycles
; ============================================================

        LDR     R0, =ADC1_SMPR2
        LDR     R1, [R0]

        BIC     R1, R1, #(7 << 12)
        ORR     R1, R1, #(7 << 12)

        STR     R1, [R0]

; ============================================================
; Select ADC Channel 4
; ============================================================

        LDR     R0, =ADC1_SQR3
        MOV     R1, #4

        STR     R1, [R0]

; ============================================================
; Enable ADC1
; ADON = bit0
; ============================================================

        LDR     R0, =ADC1_CR2
        LDR     R1, [R0]

        ORR     R1, R1, #1

        STR     R1, [R0]
		
		
		
;===================================
;ARM CONFIGURATION
;========================================

		ldr r0, =flag
		mov r1, #0
		str r1, [r0] ; set flag to 1

		ldr r0, =func1_motor1
		ldr r1, =16000000
		str r1,[r0]
		
		ldr r0, =func1_motor2
		ldr r1, =23000000
		str r1,[r0]
		
		ldr r0, =func1_motor3
		ldr r1, =15000000
		str r1,[r0]
		
		ldr r0, =func2_motor1
		ldr r1, =30000000
		str r1,[r0]
		
		ldr r0, =func2_motor2
		ldr r1, =21000000
		str r1,[r0]
		
		ldr r0, =func2_motor3
		ldr r1, =30000000
		str r1,[r0]
		
		ldr r0, =GPIOB_BASE + GPIO_MODER
		ldr r1, [r0]
		orr r1, r1, #(0x55 << 24);for pin B12,13,14,15
		orr r1, r1, #(0x5 << 16) ;for pin B8,9
		str r1, [r0]
;================================
;Display configuration 
;================================

         LDR     R0, =RCC_BASE+RCC_AHB1ENR
         LDR     R1, [R0]
         ORR     R1, R1, #GPIOBEN
         STR     R1, [R0]

         LDR     R0, =RCC_BASE+RCC_APB1ENR
          LDR     R1, [R0]
         ORR     R1, R1, #I2C1EN
         STR     R1, [R0]

         LDR     R0, =GPIOB_MODER
         LDR     R1, [R0]
         BIC     R1, R1, #(0xF :SHL: 12)
         ORR     R1, R1, #(0xA :SHL: 12)
         STR     R1, [R0]

         LDR     R0, =GPIOB_OTYPER
         LDR     R1, [R0]
         ORR     R1, R1, #(0x3 :SHL: 6)
         STR     R1, [R0]
		 
		 
         LDR     R0, =GPIOB_BASE + 0x0C     
         LDR     R1, [R0]
         BIC     R1, R1, #(0xF :SHL: 12)     ; Clear bits 12-15
         ORR     R1, R1, #(0x5 :SHL: 12)     ; Set to Pull-Up (0101)
         STR     R1, [R0]

         LDR     R0, =GPIOB_AFRL
         LDR     R1, [R0]
         BIC     R1, R1, #(0xFF :SHL: 24)
         ORR     R1, R1, #(0x44 :SHL: 24)
         STR     R1, [R0]

         LDR     R0, =I2C1_CR2
         MOV     R1, #16
		 STR     R1, [R0]

         LDR     R0, =I2C1_CCR
         MOV     R1, #0x50
		 STR     R1, [R0]

         LDR     R0, =I2C1_TRISE
         MOV     R1, #17
         STR     R1, [R0]

         LDR     R0, =I2C1_CR1
         MOV     R1, #1
         STR     R1, [R0]
		 BL	LCD_Init
				

main_loop
    WFI
    B    main_loop
	LTORG

; ------------------------------------------------------------
;  INTERRUPT HANDLER (Decoder State Machine)
; ------------------------------------------------------------

LCD_Init        PROC
                PUSH    {LR}
                MOV     R0, #50
                BL      Delay_ms
                MOV     R1, #0
                MOV     R0, #0x33
                BL      LCD_WriteByte
				
                MOV     R0, #0x32
                BL      LCD_WriteByte
                MOV     R0, #0x28
                BL      LCD_WriteByte
                MOV     R0, #0x0C
                BL      LCD_WriteByte
				
               MOV     R0, #0x01
	BL      LCD_WriteByte

	MOV     R0, #5
	BL      Delay_ms

	MOV     R0, #0x06
	BL      LCD_WriteByte
                POP     {PC}
                ENDP

    EXPORT EXTI0_IRQHandler
EXTI0_IRQHandler
    PUSH {R4-R11, LR}

    ; Clear EXTI pending flag
    LDR  R0, =EXTI_BASE
    MOV  R1, #0x01
    STR  R1, [R0, #EXTI_PR]

    ; Read Timer & Calc Delta
    LDR  R0, =TIM2_BASE
    LDR  R4, [R0, #TIM_CNT]

    LDR  R0, =ir_last_time
    LDR  R5, [R0]
    STR  R4, [R0]
    SUB  R6, R4, R5 ; R6 = Delta Time
	
	CMP  R6, #0
	BGE  skip_wrap
	LDR  R7, =20000
	ADD  R6, R6, R7
skip_wrap
    ; Check State
    LDR  R0, =ir_state
    LDR  R7, [R0]
    CMP  R7, #0
    BEQ.W  check_leader

recv_bit
    LDR  R8, =ONE_MIN
    LDR  R9, =ONE_MAX
    CMP  R6, R8
    BLO  check_zero
    CMP  R6, R9
    BHI.W  reset_decoder

    ; Received '1'
    LDR  R0, =ir_data
    LDR  R10, [R0]
    ORR  R10, R10, #(1 << 31)
    ROR  R10, R10, #1
    STR  R10, [R0]
    B    inc_bit

check_zero
    LDR  R8, =ZERO_MIN
    LDR  R9, =ZERO_MAX
    CMP  R6, R8
    BLO.W  reset_decoder
    CMP  R6, R9
    BHI.W  reset_decoder

    ; Received '0'
    LDR  R0, =ir_data
    LDR  R10, [R0]
    ROR  R10, R10, #1
    STR  R10, [R0]

inc_bit
    LDR  R0, =ir_bit_count
    LDR  R11, [R0]
    ADD  R11, R11, #1
    STR  R11, [R0]
    CMP  R11, #32
    BEQ  decode_frame
    B    irq_exit

; ------------------------------------------------------------
;  DECODE FRAME & COMPARISON
; ------------------------------------------------------------
decode_frame
    LDR  R0, =ir_data
    LDR  R0, [R0]

    LDR  R1, =0x50AF3F80        ; forward frist button 							
    CMP  R0, R1
	;BLEQ ROBOT_MOVING
    BLEQ Forward

    LDR  R1, =0x54AB3F80        ; backward  second button
    CMP  R0, R1
	;BLEQ ROBOT_MOVING
    BLEQ Backward

    LDR  R1, =0x53AC3F80        ; right  r
    CMP  R0, R1
	;BLEQ ROBOT_MOVING
    BLEQ Right

    LDR  R1, =0x522DBF80        ; left  		
    CMP  R0, R1
	;BLEQ ROBOT_MOVING
    BLEQ Left								;1=0x78873F80  ;2=0x7C833F80  3=0x7807BF80   4=0x76893F80  5=0x7C03BF80  6=0x7609BF80

    LDR  R1, =0x52AD3F80        ; stop  off					
    CMP  R0, R1										;FADE=0x7609F780		SMPPTH=0x740BF780	
	BLEQ Stop
	
	LDR  R1, =0x78873F80        ; 1
    CMP  R0, R1 	
	;BLEQ Preparing_Dose
    BLEQ Func_Rotate_Motor	
	
	LDR  R1, =0x7C833F80        ; 2			
    CMP  R0, R1											
    ;BLEQ Injection_active
	BLEQ Syrange
	
	
	LDR  R1, =0x552ABF80        ;Call
    CMP  R0, R1
	;BLEQ CALLING_HELP
    BLEQ Com 	

	LDR  R1, =0x7807BF80        ;   3
    CMP  R0, R1
    BLEQ Show_Temperature 	
	
	LDR  R1, =0x76893F80        ;4
    CMP  R0, R1
    BLEQ MEDICATION  	
	
	LDR  R1, =0x7C03BF80        ;5
    CMP  R0, R1
    BLEQ MEAL 

	
	LDR  R1, =0x7609BF80        ;6
    CMP  R0, R1
    BLEQ PAIN 	
	

	LDR  R1, =0x748B3F80        ;7
    CMP  R0, R1
    BLEQ FALL

	
	LDR  R1, =0x5DA23F80        ;MEDIA
    CMP  R0, R1
    BLEQ MOVE_UP
	
	LDR  R1, =0x5D22BF80         ;AUTO		
    CMP  R0, R1
    BLEQ MOVE_DOWN
	
	;0x7E813F80 8
	;0x740BBF80 9
	;0x728D3F80 0
	;0x7A853F80 OFF
	;0x7A05BF80 MUTE
	
    B    reset_decoder

check_leader
    LDR  R8, =LEADER_MIN
    LDR  R9, =LEADER_MAX
    CMP  R6, R8
    BLO  irq_exit
    CMP  R6, R9
    BHI  irq_exit

    ; Valid leader pulse found
    LDR  R0, =ir_state
    MOV  R1, #1
    STR  R1, [R0]

    LDR  R0, =ir_bit_count
    MOV  R1, #0
    STR  R1, [R0]

    LDR  R0, =ir_data
    STR  R1, [R0]
    B    irq_exit

reset_decoder
    LDR  R0, =ir_state
    MOV  R1, #0
    STR  R1, [R0]
    LDR  R0, =ir_bit_count
    STR  R1, [R0]
    B    irq_exit

irq_exit
    POP  {R4-R11, PC}
	
	END
		
	
	
	
	
	
	
	
	
	
	