#include "libos.h"

int print_progress(unsigned int row,
		   unsigned int col,
		   const char *message,
		   unsigned int perc,
		   unsigned int width);

int strlen(const char *s)
{
	int length = 0;
	while (s[length] != '\0')
	{
		length++;
	}
	return length;
}

void boot_win(void)
{
    print_to(11, 2, "+------------------------------------------------------+");
    print_to(12, 2, "|                                                      |");
    print_to(13, 2, "|  [OK] Console                                        |");
    print_to(14, 2, "|  [-]  Memory                                         |");
    print_to(15, 2, "|  [-]  Kernel                                         |");
    print_to(16, 2, "|  [-]  Interrupts                                     |");
    print_to(17, 2, "|  [-]  Processes                                      |");
    print_to(18, 2, "|                                                      |");
    print_to(19, 2, "|                                                      |");
    print_to(20, 2, "|                                                      |");
    print_to(21, 2, "+------------------------------------------------------+");
}

int main(void){
	boot_win();
	while(1)
	{
		for (int perc =10; perc <=100; perc +=10)
		{
			print_progress(19,4, "Progress: ",perc, 10);
			wait_msec(500000);
		}
	}

	return 0;
}
