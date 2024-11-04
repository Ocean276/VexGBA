#
# The xPack GNU RISC-V Embedded GCC
# https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack
#
TARGET_ELF = firmware.elf
TARGET_BIN = firmware.bin
TARGET_ASM = firmware.asm
TARGET_HEX = firmware.hex
RISCV = /opt/riscv/bin/riscv64-unknown-elf
CC = $(RISCV)-gcc
OBJCOPY = $(RISCV)-objcopy
OBJDUMP = $(RISCV)-objdump
CFLAGS  = -Wall -O2 -g -mabi=ilp32 -march=rv32i -ffreestanding
LFLAGS = -mabi=ilp32 -march=rv32i -Wl,--build-id=none,-Bstatic,-T,baremetal.ld -nostdlib
LIBS = -lgcc

SRCS := start.S firmware.c vexgba.c spi_sd.c spiflash.c \
	fatfs/diskio.c fatfs/ff.c fatfs/ffunicode.c
OBJS := $(SRCS:.c=.o)
OBJS := $(OBJS:.S=.o)
HDRS := $(wildcard *.h)

ifeq ($(VERBOSE),1)
  Q =
else
  Q = @
endif

default: $(TARGET_BIN) $(TARGET_ASM) $(TARGET_HEX)
all: default

%.o: %.c $(HDRS)
ifneq ($(VERBOSE),1)
	@echo CC $@
endif
	$(Q)$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S $(HDRS)
ifneq ($(VERBOSE),1)
	@echo CC $@
endif
	$(Q)$(CC) $(CFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET_BIN) $(TARGET_ELF) $(OBJS)

$(TARGET_ELF): $(OBJS)
ifneq ($(VERBOSE),1)
	@echo CC $@
endif
	$(Q)$(CC) $(LFLAGS) $(OBJS) $(LIBS) -o $@

$(TARGET_BIN): $(TARGET_ELF)
ifneq ($(VERBOSE),1)
	@echo OBJCOPY $@
endif
	$(Q)$(OBJCOPY) $(TARGET_ELF) $(TARGET_BIN) -O binary
	
$(TARGET_ASM): $(TARGET_ELF)
	$(OBJDUMP) -S -d $^ > $@
	
$(TARGET_HEX): $(TARGET_ELF)
	$(OBJCOPY) -O ihex $^ $@


clean:
	$(Q)rm -f $(OBJS) $(TARGET_ELF) $(TARGET_BIN)

.PHONY: default all clean
