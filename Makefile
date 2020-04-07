P=linker_test

OFILES=$(patsubst %,$(OBJECTS)/%,\
	main.o\
	\
	partly_used.o\
	\
	unused.o\
	unused2.o\
	unused3.o\
	unused4.o\
)

BUILD=./Build
OBJECTS=$(BUILD)
LISTINGS=$(BUILD)

FEEDBACK=$(OBJECTS)/$(P).fed
FEEDBACK_M=$(OBJECTS)/$(P)_multifile.fed
SCT=aduc7060.sct

CFLAGS=\
	--c99\
	--thumb \
	--cpu ARM7TDMI \
	-D__EVAL \
	-D__MICROLIB\
	-g -O3 \
	--apcs=interwork \
	--split_ldm\
	--split_sections\
	--autoinline\
	--enum_is_int\
	--signed_chars\

CPPFLAGS=\

LDFLAGS=\
	--cpu ARM7TDMI \
	--strict --scatter "$(SCT)" \
	--library_type=microlib\
	--inline \
	--tailreorder\
	--inline_type all \
	--summary_stderr \
	--map --xref --callgraph --symbols \
	--info summarysizes \
	--info sizes --info totals --info unused --info veneers \

TARG=\
	$(BUILD)/$(P)_multifile.axf\
	$(BUILD)/$(P)_normal.axf\

all: $(TARG)


ARMBIN=c:/Keil_v5/ARM/ARMCC/BIN
CC=$(ARMBIN)/armcc
AS=$(ARMBIN)/armasm
LD=$(ARMBIN)/armlink

.PRECIOUS: $(OFILES)

%_multifile.axf: $(OBJECTS)/_multi.o 
	@echo linking $@
	@$(LD) $(LDFLAGS) -o $@ --feedback $(FEEDBACK_M) --list "$(LISTINGS)/$(*F)_multifile.map" $^
	@echo --

$(OBJECTS)/_multi.o: $(patsubst $(OBJECTS)/%.o,%.c,$(OFILES))
	@if not exist $(subst /,\,$(@D)) mkdir $(subst /,\,$(@D))
	@echo compiling --multifile $^
	@$(CC) $(CFLAGS) $(CPPFLAGS) --feedback $(FEEDBACK_M) -c --multifile $^ -o $@

%_normal.axf: $(OFILES)
	@echo linking $@
	@$(LD) $(LDFLAGS) -o $@ --feedback $(FEEDBACK) --list "$(LISTINGS)/$(*F).map" $^
	@echo --

$(OBJECTS)/%.o: %.c
	@if not exist $(subst /,\,$(@D)) mkdir $(subst /,\,$(@D))
	@echo compiling separate object file $^
	@$(CC) $(CFLAGS) $(CPPFLAGS) --feedback $(FEEDBACK) -c $< -o $@

CLEANFILES=\
	$(TARG)\

clean:
	del $(subst /,\,$(CLEANFILES)) >nul 2>&1 || echo ok
	@echo del '$$(OFILES)'
	@del $(subst /,\,$(OFILES)) >nul 2>&1 || echo ok
	del  $(subst /,\,$(OBJECTS))\*.o >nul 2>&1 || echo ok

nuke:
	if exist $(subst /,\,$(OBJECTS)) rmdir /s /q $(subst /,\,$(OBJECTS))
	if exist $(subst /,\,$(LISTINGS)) rmdir /s /q $(subst /,\,$(LISTINGS))
