#include <stdio.h>
#include <libusb-1.0/libusb.h>
int main()
{
    libusb_context* pusbctx;
    int ret = libusb_init(&pusbctx);
    printf("test test\n");
    return 0;
}