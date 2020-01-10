KOBJECTS	=krnl.o
OBJECTS		=kernel.o

INCLUDES=../include

.PHONY:all
all:
	$(CC) $(CFLAGS) -c -o krnl.o kernel.c


.PHONY:clean
clean:
	($(CD) $(MEN_DIR);$(MAKE)  clean)
	($(CD) $(SCHED_DIR);$(MAKE) clean)
	$(RM) -f *.o
