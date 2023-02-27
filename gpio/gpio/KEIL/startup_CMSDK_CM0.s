Stack_Size      EQU     0x00000400

                AREA    STACK, NOINIT, READWRITE, ALIGN=4
Stack_Mem       SPACE   Stack_Size
__initial_sp
	
Heap_Size       EQU     0x00000400

                AREA    HEAP, NOINIT, READWRITE, ALIGN=4
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


				PRESERVE8
                THUMB

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp                 ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     0                         ; NMI Handler
                DCD     0                         ; Hard Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; SVCall Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; PendSV Handler
                DCD     0                         ; SysTick Handler
                DCD     UART_Handler              ; IRQ0 Handler

                AREA    |.text|, CODE, READONLY

; Reset Handler

Reset_Handler	PROC
				GLOBAL	Reset_Handler
				ENTRY
				LDR R2,=0x40000020				  	;GPIO0 OUT REG ADDR
				LDR R3,=0x40000030					;GPIO1 OUT REG ADDR


				
SWITCH_LED 	
			LDR R0, =0x00		;GPIO INPUT ENABLE VALUE
			STR R0, [R2, #8]	;Set input ENABLE
			LDR R1, [R2, #4]	;read GPIO value
			CMP R1, #0x00000080	;
			BEQ CORTEX_M0
			B SWITCH_LED
			
				
CORTEX_M0	
			IMPORT	__main
			LDR     R0, =__main
			MOV     R8, R0
            MOV     R9, R8
            BX      R0
			B		SWITCH_LED
			ENDP
			
				
UART_Handler	PROC
				EXPORT UART_Handler				[WEAK]
				IMPORT UARTHandle
				PUSH	{R0,R1,R2,LR}
                BL		UARTHandle
				POP		{R0,R1,R2,PC}
                ENDP
					



                ALIGN 4

				IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap

__user_initial_stackheap 

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR
     
                ALIGN 

				ENDIF
					
                END
                    

