#include "code_def.h"
#include <string.h>
#include <stdint.h>

int main()
{
	//interrupt initial
	NVIC_CTRL_ADDR = 1;


	while(1){
			//UART display
			UARTString("Cortex-M0\n");
			Delay(5000000);
	}
}
