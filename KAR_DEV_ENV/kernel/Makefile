KOBJECTS	=krnl.o
OBJECTS		=kernel.o
MEMORYOBJECTS	=memory.o
KSTDLIBOBJECTS	=kstdlib.o
INCLUDES	=../include

.PHONY:all
all:$(KOBJECTS) $(MEMORYOBJECTS) $(KSTDLIBOBJECTS)
	$(LD) -r -o $(KOBJECTS) $(OBJECTS) $(MOMORYOBJECTS) $(KSTDLIBOBJECTS)
#.c.o:
#	$(CC) $(CFLAGS)  -c -o $*.o $<
section.o:
	$(CC) $(CFLAGS) -c -o section.o $(INCLUDES)/section.c
memory.o:
	$(CC) $(CFLAGS) -c -o memory.o $(INCLUDES)/memory.c
kstdlib.o:
	$(CC) $(CFLAGS) -c -o kstdlib.o $(INCLUDES)/kstdlib.c

$(KOBJECTS):$(OBJECTS) $(MEMORYOBJECTS) $(KSTDLIBOBJECTS)
	$(LD) -r -o $(KOBJECTS) $(OBJECTS) $(MEOMORYOBJECTS) $(KSTDLIBOBJECTS)

.PHONY:clean
clean:
#	($(CD) $(MEM_DIR);$(MAKE)  clean)
#	($(CD) $(SCHED_DIR);$(MAKE) clean)
	$(RM) -f *.o
