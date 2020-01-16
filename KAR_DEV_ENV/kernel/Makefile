KOBJ		=kernel.a
OBJ		=kernel.o
TMPOBJ		=kernelsub.o
SECTIONOBJ	=section.o
MEMORYOBJ	=memory.o
KSTDLIBOBJ	=kstdlib.o
INCLUDES	=../include

.PHONY:all
all:$(MEMORYOBJ) $(KSTDLIBOBJ) $(SECTIONOBJ) $(TMPOBJ)
	ar r $(KOBJ) $(MEMORYOBJ) $(KSTDLIBOBJ) $(SECTIONOBJ) $(TMPOBJ)
#.c.o:
#	$(CC) $(CFLAGS)  -c -o $*.o $<
#$(OBJECTS):$(MEMORYOBJECTS) $(KSTDLIBOBJECTS) $(SECTIONOBJ) $(TMPOBJECTS)
#	$(CC) $(CFLAGS) -o $(OBJECTS) $(OBJECTS) $(MOMORYOBJECTS) $(KSTDLIBOBJECTS)
$(SECTIONOBJ):
	$(CC) $(CFLAGS) -c -o $(SECTIONOBJ) $(INCLUDES)/section.c
$(MEMORYOBJ):
	$(CC) $(CFLAGS) -c -o $(MEMORYOBJ) $(INCLUDES)/memory.c
$(KSTDLIBOBJ):
	$(CC) $(CFLAGS) -c -o $(KSTDLIBOBJ) $(INCLUDES)/kstdlib.c
$(TMPOBJ):
	$(CC) $(CFLAGS) -c -o $(TMPOBJ) kernel.c
#$(KOBJECTS):$(MEMORYOBJECTS) $(KSTDLIBOBJECTS) $(SECTIONOBJ) $(TMPOBJECTS)
#	$(LD) -r -o $(KOBJECTS) $(MEMORYOBJECTS) $(KSTDLIBOBJECTS) $(SECTIONOBJ) $(TMPOBJECTS)

.PHONY:clean
clean:
#	($(CD) $(MEM_DIR);$(MAKE)  clean)
#	($(CD) $(SCHED_DIR);$(MAKE) clean)
	$(RM) -f *.o *.a
