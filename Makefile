OUTPUT = hcplayer
TARGET = frdm-k64f-gcc
BAUD = 9600

SRC := $(wildcard source/*)

YT = yotta
FLASHTOOL = pyocd-flashtool
GDBSERVER = pyocd-gdbserver
GDB = arm-none-eabi-gdb

MODULE_PATH := yotta_modules
TARGET_PATH := yotta_targets/$(TARGET)
OUTPUT_PATH := build/$(TARGET)/source/$(OUTPUT)


all: $(OUTPUT_PATH).bin

$(MODULE_PATH):
	$(YT) install

$(TARGET_PATH):
	$(YT) target $(TARGET)

$(OUTPUT_PATH).bin: $(TARGET_PATH) $(MODULE_PATH) $(SRC)
	$(YT) build

clean:
	$(YT) clean

flash: $(OUTPUT_PATH).bin
	$(FLASHTOOL) $<

debug: $(OUTPUT_PATH).bin
	$(GDBSERVER)& $(GDB) $< -ex "target remote localhost:3333"

serial: $(wildcard /dev/ttyACM*)
	screen $< $(BAUD)

