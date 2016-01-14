
#include "mbed-drivers/mbed.h"

#include "data.h"

Ticker tick;
DigitalOut led(LED1);
AnalogOut ang(DAC0_OUT);

static void blinky(void) {
    led = !led;
}

void app_start(int, char **) {
    tick.attach(blinky, 1);

    while (true) {
        for (int i = 0; i < DATA_LEN; i++) {
            ang.write_u16(data[i] << 4);
            wait_us(125);
        }
    }
}

