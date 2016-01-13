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
OUTPUT_BIN  := $(OUTPUT_PATH).bin


all: $(OUTPUT_BIN)

$(MODULE_PATH):
	$(YT) install

$(TARGET_PATH):
	$(YT) target $(TARGET)

$(OUTPUT_BIN): $(MODULE_PATH) $(TARGET_PATH) $(SRC)
	$(YT) build

clean:
	$(YT) clean

flash: $(OUTPUT_BIN)
	$(FLASHTOOL) $(OUTPUT_BIN)

debug: $(OUTPUT_BIN)
	$(GDBSERVER)& $(GDB) $(OUTPUT_PATH) -ex "target remote localhost:3333"

serial: $(wildcard /dev/ttyACM*)
	screen $< $(BAUD)

