#Path for the p4 compiler and Program loader that loads code into NIC
P4DIR = /opt/netronome/p4/bin
CURRENT_PATH=${PWD}
P4COMPILER = $(P4DIR)/nfp4build
NFW_LOADER = $(P4DIR)/rtecli

#compiles all the p4 files
SRC=$(wildcard *.p4)
#generic p4 config file
P4CFG=$(wildcard *.p4cfg)

#necessary plugin file
DEPS = plugin.c

#where the output json file is stored
OUTPUT_PATH = ${PWD}/out

#binary file after compiling p4 code
OUTPUT_FILE = compiled_file.nffw

default:
	$(P4COMPILER) -p out -o $(OUTPUT_FILE) -r -e -l lithium -4 $(SRC) -c $(DEPS)

run:
	@$(MAKE)
	$(NFW_LOADER) design-load -f $(OUTPUT_FILE) -p $(OUTPUT_PATH)/pif_design.json
	$(NFW_LOADER) config-reload -c $(P4CFG)

clean:
	rm -rf *.list *.nffw ./out *.yml *~ Makefile-nfp4build
