KOBJECTS	=krnl.o
OBJECTS		=kernel.o
SECTIONOBJECTS	=section.o
INCLUDES	=../include

.PHONY:all
all:$(KOBJECTS)
	$(LD) -r -o $(KOBJECTS) $(OBJECTS) $(SECTIONOBJECTS)
#.c.o:
#	$(CC) $(CFLAGS)  -c -o $*.o $<
section.o:
	$(CC) $(CFLAFS) -c -o section.o $(INCLUDES)/section.c
$(KOBJECTS):$(OBJECTS) $(SECTIONOBJECTS)
	$(LD) -r -o $(KOBJECTS) $(OBJECTS) $(SECTIONOBJECTS)

.PHONY:clean
clean:
#	($(CD) $(MEM_DIR);$(MAKE)  clean)
#	($(CD) $(SCHED_DIR);$(MAKE) clean)
	$(RM) -f *.o
