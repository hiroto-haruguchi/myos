BOOT		=boot
LOADER		=stkar.img
LOADERASM	=boot_kernel.asm
KERNEL		=Kimage
KOBJECTS	=kernel/kernel.a driver/drivr.o

HOME_DIR	=$(CURDIR)

CC		=gcc
CFLAGS		=-fomit-frame-pointer -O2 -I $(HOME_DIR)/include -masm=intel -Wall
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
all:$(BOOT).img $(LOADER) $(KERNEL) $(KOBJECTS)
#Make kernel objects
	($(CD) kernel;$(MAKE))
	($(CD) driver;$(MAKE))
#Make boot loader
	$(ASM) -o $(BOOT).img $(BOOT)/$(BOOT).asm
	$(ASM) -I$(BOOT) -o $(LOADER) $(BOOT)/$(LOADERASM)
#Make kernel image
	$(LD) $(LFLAGS) -o $(KERNEL) $(KOBJECTS)

$(BOOT).img:$(BOOT)/$(BOOT).asm
	$(ASM) -o $(BOOT).img $(BOOT)/$(BOOT).asm

$(LOADER):$(BOOT)/$(LOADERASM)
	$(ASM) -I$(BOOT) -o $(LOADER) $(BOOT)/$(LOADERAS)
kernel/kernel.a:
	($(CD) kernel;$(MAKE))

driver/drivr.o:
	($(CD) driver;$(MAKE))

$(KERNEL):$(KOBJECTS)
	$(LD) $(LFLAGS) -o $(KERNEL) $(KOBJECTS)

.PHONY:install
install:$(BOOT).img $(LOADER) $(KERNEL)
	$(ASM) -o $(BOOT).img $(BOOT)/$(BOOT).asm
	($(CD) kernel;$(MAKE))
	($(CD) driver;$(MAKE))
	$(LD) $(LFLAGS) -o $(KERNEL) $(KOBJECTS)

	#$(DD) if=$(BOOt).img bs=512 count=1 of=$(IMDISK)
	#$(CP) $(LOADER) $(ADRIVE)
	#$(CP) $(KERNEL) $(ADRIVE)

.PHONY:clean
clean:
	$(RM) -f $(BOOT).img $(LOADER) $(KERNEL)
	($(CD) driver; $(MAKE) clean)
	($(CD) kernel; $(MAKE) clean)

