.PHONY=run

C_FILES := $(filter-out $(wildcard examples/*), $(shell find . -type f -name '*.c' -not -path './examples/*'))
H_FILES := $(filter-out $(wildcard examples/*), $(shell find . -type f -name '*.h' -not -path './examples/*'))

# Compile 30cc with gcc
STAGE1_CC ?= cc
STAGE1_CFLAGS := -std=gnu99 -Og -ggdb
STAGE1_BIN := ./30cc_gcc

# Compile 30cc with gcc-generated 30cc
STAGE2_CC := ./30cc_gcc
STAGE2_BIN := ./30cc_30cc

# Compile 30cc with 30cc-generated 30cc
STAGE3_CC := ./30cc_30cc
STAGE3_BIN := ./30cc

$(STAGE1_BIN): $(H_FILES) $(C_FILES)
	$(STAGE1_CC) $(STAGE1_CFLAGS) $(C_FILES) -o $(STAGE1_BIN)

$(STAGE2_BIN): $(STAGE1_BIN) **/*.h **/*.c
	rm -rf target1
	for file in $(C_FILES) ; do \
		mkdir -p target1/$$(dirname $${file}); \
		$(STAGE2_CC) $${file} --asm > target1/$${file}.asm; \
		nasm -f elf64 target1/$${file}.asm -o target1/$${file}.o; \
	done
	ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -o $(STAGE2_BIN) $$(find target1 -type f -name '*.o')
	rm -rf target1

$(STAGE3_BIN): $(STAGE2_BIN) **/*.h **/*.c
	rm -rf target2
	for file in $(C_FILES) ; do \
		mkdir -p target2/$$(dirname $${file}); \
		$(STAGE2_CC) $${file} --asm > target2/$${file}.asm; \
		nasm -f elf64 target2/$${file}.asm -o target2/$${file}.o; \
	done
	ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -o $(STAGE3_BIN) $$(find target2 -type f -name '*.o')
	rm -rf target2

run: $(BIN)
	@./30cc $(program) --asm > out.asm
	@nasm -f elf64 out.asm -o out.o
	@ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -o out out.o
	@echo "$ ./out \"$(arguments)\""
	@echo "-------------"
	@./out $(arguments)
