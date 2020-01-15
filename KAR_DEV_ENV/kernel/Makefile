KOBJECTS	=krnl.o
OBJECTS		=kernel.o
SECTIONOBJ	=section.o
MEMORYOBJECTS	=memory.o
KSTDLIBOBJECTS	=kstdlib.o
INCLUDES	=../include

.PHONY:all
all:$(KOBJECTS)
	$(LD) -r -o $(KOBJECTS) $(OBJECTS)
#.c.o:
#	$(CC) $(CFLAGS)  -c -o $*.o $<
kernel.o:$(MEMORYOBJECTS) $(KSTDLIBOBJECTS) $(SECTIONOBJ)
	$(CC) $(CFLAGS) -o $(OBJECTS) kernel.c
	$(CC) $(CFLAGS) -o $(OBJECTS) $(OBJECTS) $(MOMORYOBJECTS) $(KSTDLIBOBJECTS)
section.o:
	$(CC) $(CFLAGS) -c -o section.o $(INCLUDES)/section.c
memory.o:
	$(CC) $(CFLAGS) -c -o memory.o $(INCLUDES)/memory.c
kstdlib.o:
	$(CC) $(CFLAGS) -c -o kstdlib.o $(INCLUDES)/kstdlib.c

$(KOBJECTS):$(OBJECTS)
	$(LD) -r -o $(KOBJECTS) $(OBJECTS)

.PHONY:clean
clean:
#	($(CD) $(MEM_DIR);$(MAKE)  clean)
#	($(CD) $(SCHED_DIR);$(MAKE) clean)
	$(RM) -f *.o
