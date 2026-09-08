#include "libos.h"

int main(void){
	boot_win();
	while(1)
1	{
		for (int perc =10; perc <=100; perc +=10)
		{
			print_progress(19,4, "Progress: ",perc, 10);
			wait_msec(500000);
		}
	}

	return 0;
}
