.PHONY: all clean

name := BlinkenLight

as := ca65
ld := ld65

ld_script := link.cfg
obj_list := header.o main.o

src_dir := src
build_dir := build
obj_dir := $(build_dir)/obj

obj := $(addprefix $(obj_dir)/,$(obj_list))
rom := $(build_dir)/$(name).sfc
dbg := $(build_dir)/$(name).dbg

default: $(rom)

all: clean default

$(rom) : $(obj) | $(ld_script)
	$(ld) --dbgfile $(dbg) -o $@ --config $(ld_script) $^

$(obj_dir)/%.o : $(ld_script) Makefile

$(obj_dir):
	@mkdir -p $(obj_dir)

$(obj_dir)/%.o : $(src_dir)/%.s | $(obj_dir)
	$(as) --debug-info -o $@ $<

clean:
	@rm -rf $(build_dir)
