KOBJECTS	=kernel.a
OBJECTS		=kernel.o
TMPOBJECTS	=kernelsub.o
SECTIONOBJ	=section.o
MEMORYOBJECTS	=memory.o
KSTDLIBOBJECTS	=kstdlib.o
INCLUDES	=../include

.PHONY:all
all:$(MEMORYOBJECTS) $(KSTDLIBOBJECTS) $(SECTIONOBJ) $(TMPOBJECTS)
	$(LD) -r -o $(KOBJECTS) $(OBJECTS)
#.c.o:
#	$(CC) $(CFLAGS)  -c -o $*.o $<
#$(OBJECTS):$(MEMORYOBJECTS) $(KSTDLIBOBJECTS) $(SECTIONOBJ) $(TMPOBJECTS)
#	$(CC) $(CFLAGS) -o $(OBJECTS) $(OBJECTS) $(MOMORYOBJECTS) $(KSTDLIBOBJECTS)
$(SECTRIONOBJ):
	$(CC) $(CFLAGS) -c -o section.o $(INCLUDES)/section.c
$(MEMORYOBJECTS):
	$(CC) $(CFLAGS) -c -o memory.o $(INCLUDES)/memory.c
$(KSTDLIBOBJECTS):
	$(CC) $(CFLAGS) -c -o kstdlib.o $(INCLUDES)/kstdlib.c
$(TMPOBJECTS):
	$(CC) $(CFLAGS) -c -o $(TMPOBJECTS) kernel.c
#$(KOBJECTS):$(MEMORYOBJECTS) $(KSTDLIBOBJECTS) $(SECTIONOBJ) $(TMPOBJECTS)
#	$(LD) -r -o $(KOBJECTS) $(MEMORYOBJECTS) $(KSTDLIBOBJECTS) $(SECTIONOBJ) $(TMPOBJECTS)

.PHONY:clean
clean:
#	($(CD) $(MEM_DIR);$(MAKE)  clean)
#	($(CD) $(SCHED_DIR);$(MAKE) clean)
	$(RM) -f *.o
