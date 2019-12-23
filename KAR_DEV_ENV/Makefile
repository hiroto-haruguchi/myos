BOOT		=boot
BOOT_LOADERIMG	=boot_ldrt
BOOT_LOADER	=BOOT_LOADER
KARNEL_LOADER	=KARNEL_LOADER.IMG
LOADERASM	=boot_karnel.asm
KERNEL		=Kimage
KOBJECTS	=kernel/krnl.o driver/driver.o

HOME_DIR	="$(CURDIR)"

CC		=gcc
CFLAGS		=-fomit-frame-pointer -O2 -I$(HOME_DIR)/include -masm=intel -Wall
ASFLAGS		=-msyntax=intel -march=i686 --32
LFLAGS		=-T linkerscript -Map kernel.map -nostdlib -e _kernel_entry --oformat binary
ASM		=nasm
AS		=as
LD		=ld
DD		=dd
CP		=cp
RM		=rm
CD		=cd
MAKE		=make
IMDISK		=/dev/fd0

export	HOME_DIR
export	CC
export	CFLAGS
export	LD
export	ASFLAGS
export	AS	

.PHONY:all
all:$(BOOT_LOADER).img $(KARNEL_LOADER) $(KARNEL) $(KOBJECTS)
	($(CD) kernel;$(MAKE))
	($(CD) driver;$(MAKE))

	$(ASM) -o $(BOOT_LOADER).img $(BOOT)/$(BOOT_LOADERIMG).asm
	$(ASM) -I$(BOOT) -o $(KARNEL_LOADER) $(BOOT)/$(LOADERASM)

	$(LD) $(LFLAGS) -o $(KERNEL) $(KOBJECTS)

