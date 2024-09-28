# Makefile for Hello World OS
ASM=nasm
GCC=gcc
LD=ld

# Bootloader
BOOT_SRC=src/Boot/boot.asm  # Path to boot.asm
BOOT_BIN=boot.bin

# Kernel
KERNEL_SRC=src/Kernel/kernel.c  # Path to kernel.c
KERNEL_BIN=kernel.bin

# The final bootable image
OS_IMAGE=os-image.bin

all: $(OS_IMAGE)

# Assemble the bootloader
$(BOOT_BIN): $(BOOT_SRC)
	$(ASM) -f bin $(BOOT_SRC) -o $(BOOT_BIN)

# Compile the kernel
$(KERNEL_BIN): $(KERNEL_SRC)
	$(GCC) -ffreestanding -c $(KERNEL_SRC) -o kernel.o
	$(LD) -Ttext 0x1000 --oformat binary -o $(KERNEL_BIN) kernel.o  # Link the kernel

# Link the bootloader and kernel to create a bootable image
$(OS_IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
	cat $(BOOT_BIN) $(KERNEL_BIN) > $(OS_IMAGE)

# Clean up the generated files
clean:
	rm -f $(BOOT_BIN) kernel.o $(KERNEL_BIN) $(OS_IMAGE)
