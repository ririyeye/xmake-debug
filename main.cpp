#include <stdio.h>
#include "./libusb-1.0/libusb.h"
int test();
int main()
{
    test();
    libusb_init(NULL);
    printf("test test\n");
    return 0;
}