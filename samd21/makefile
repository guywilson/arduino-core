###############################################################################
#                                                                             #
# MAKEFILE for arduino-core                                                   #
#                                                                             #
# Guy Wilson (c) 2021                                                         #
#                                                                             #
###############################################################################

PROJNAME=libcore-samd21

# Target device
DEVICE=cortex-m0plus

# Set this to the board variant, used to build the correct variant.cpp file
BOARD_VARIANT=mkrwan1300
# BOARD_VARIANT=mkrnb1500
# BOARD_VARIANT=arduino_zero
# BOARD_VARIANT=mkrwifi1010
# BOARD_VARIANT=mkrvidor4000
# BOARD_VARIANT=mkrgsm1400
# BOARD_VARIANT=mkrfox1200
# BOARD_VARIANT=mkrzero
# BOARD_VARIANT=mkr1000
# BOARD_VARIANT=nano_33_iot
# BOARD_VARIANT=circuitplay
# BOARD_VARIANT=arduino_mzero

# What is our target
TARGET=$(PROJNAME).a

# Build output directory
BUILD=build

# Arduino base directory
ARDUINOBASE=/Users/guy/Library/Arduino15/packages/arduino
CMSISBASE=$(ARDUINOBASE)/tools/CMSIS
SAMDBASE=$(ARDUINOBASE)/hardware/samd/1.8.11

# Source directory
CORE_SRC=$(SAMDBASE)/cores/arduino
USB_SRC=$(CORE_SRC)/USB
API_SRC=$(CORE_SRC)/api
STARTUP_SRC=$(ARDUINOBASE)/tools/CMSIS-Atmel/1.2.0/CMSIS/Device/ATMEL/samd21/source/as_gcc
VARIANT_SRC=$(SAMDBASE)/variants/$(BOARD_VARIANT)

# Library directory
LIBDIR=lib

# Dependency directory
DEP = dep

# Tools
CC=arm-none-eabi-gcc
CPP=arm-none-eabi-g++
ASM=arm-none-eabi-gcc
LIB=arm-none-eabi-ar

# Pre/Post compile steps
PRECOMPILE = @ mkdir -p $(BUILD) $(DEP)
POSTCOMPILE = @ mv -f $(DEP)/$*.Td $(DEP)/$*.d

# Include dir flags
INCLUDEFLAGS=-I$(CMSISBASE)/4.5.0/CMSIS/Include/ -I$(ARDUINOBASE)/tools/CMSIS-Atmel/1.2.0/CMSIS/Device/ATMEL/ -I$(ARDUINOBASE)/tools/CMSIS-Atmel/1.2.0/CMSIS/Device/ATMEL/samd21/include/ -I$(SAMDBASE)/cores/arduino/api/deprecated -I$(SAMDBASE)/cores/arduino/api/deprecated-avr-comp -I$(SAMDBASE)/cores/arduino -I$(SAMDBASE)/variants/mkrwan1300

# C compiler flags
CFLAGS=-c -mcpu=$(DEVICE) -mthumb -g -Os -Wall -std=gnu11 -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -DF_CPU=48000000L -DARDUINO=10813 -DARDUINO_SAMD_MKRWAN1310 -DARDUINO_ARCH_SAMD -DUSE_ARDUINO_MKR_PIN_LAYOUT -D__SAMD21G18A__ -DUSB_VID=0x2341 -DUSB_PID=0x8059 -DUSBCON "-DUSB_MANUFACTURER=\"Arduino LLC\"" "-DUSB_PRODUCT=\"Arduino MKR WAN 1310\"" -DUSE_BQ24195L_PMIC -DVERY_LOW_POWER $(INCLUDEFLAGS)
CPPFLAGS=-c -mcpu=$(DEVICE) -g -Os -mthumb -Wall -std=gnu++11 -ffunction-sections -fdata-sections -fno-threadsafe-statics -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -DF_CPU=48000000L -DARDUINO=10813 -DARDUINO_SAMD_MKRWAN1310 -DARDUINO_ARCH_SAMD -DUSE_ARDUINO_MKR_PIN_LAYOUT -D__SAMD21G18A__ -DUSB_VID=0x2341 -DUSB_PID=0x8059 -DUSBCON "-DUSB_MANUFACTURER=\"Arduino LLC\"" "-DUSB_PRODUCT=\"Arduino MKR WAN 1310\"" -DUSE_BQ24195L_PMIC -DVERY_LOW_POWER $(INCLUDEFLAGS)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEP)/$*.Td
ASMFLAGS=-c -g -x assembler-with-cpp -DF_CPU=48000000L -DARDUINO=10813 -DARDUINO_SAMD_MKRWAN1310 -DARDUINO_ARCH_SAMD -DUSE_ARDUINO_MKR_PIN_LAYOUT -D__SAMD21G18A__ -DUSB_VID=0x2341 -DUSB_PID=0x8059 -DUSBCON "-DUSB_MANUFACTURER=\"Arduino LLC\"" "-DUSB_PRODUCT=\"Arduino MKR WAN 1310\"" -DUSE_BQ24195L_PMIC -DVERY_LOW_POWER $(INCLUDEFLAGS)

# Lib tool flags
LIBFLAGS=rcs

COMPILE.c = $(CC) $(CFLAGS) $(INCLUDEFLAGS) $(DEPFLAGS) -o $@
COMPILE.cpp = $(CPP) $(CPPFLAGS) $(INCLUDEFLAGS) $(DEPFLAGS) -o $@
COMPILE.asm = $(ASM) $(ASMFLAGS) $(INCLUDEFLAGS) $(DEPFLAGS) -o $@
LIB.o = $(LIB) $(LIBFLAGS) $@

CSRCFILES1 = $(wildcard $(CORE_SRC)/*.c)
CSRCFILES2 = $(wildcard $(USB_SRC)/*.c)
CSRCFILES3 = $(wildcard $(STARTUP_SRC)/*.c)

CPPSRCFILES1 = $(wildcard $(CORE_SRC)/*.cpp)
CPPSRCFILES2 = $(wildcard $(USB_SRC)/*.cpp)
CPPSRCFILES3 = $(wildcard $(API_SRC)/*.cpp)
CPPSRCFILES4 = $(wildcard $(VARIANT_SRC)/*.cpp)

ASMSRCFILES = $(wildcard $(CORE_SRC)/*.S)

DEPFILES = $(patsubst $(CORE_SRC)/%.S, $(DEP)/%.d, $(ASMSRCFILES)) $(patsubst $(CORE_SRC)/%.c, $(DEP)/%.d, $(CSRCFILES1)) $(patsubst $(USB_SRC)/%.c, $(DEP)/%.d, $(CSRCFILES2)) $(patsubst $(STARTUP_SRC)/%.c, $(DEP)/%.d, $(CSRCFILES3)) $(patsubst $(CORE_SRC)/%.cpp, $(DEP)/%.d, $(CPPSRCFILES1)) $(patsubst $(USB_SRC)/%.cpp, $(DEP)/%.d, $(CPPSRCFILES2)) $(patsubst $(API_SRC)/%.cpp, $(DEP)/%.d, $(CPPSRCFILES3)) $(patsubst $(VARIANT_SRC)/%.cpp, $(DEP)/%.d, $(CPPSRCFILES4))
OBJFILES := $(patsubst $(CORE_SRC)/%.S, $(BUILD)/%.o, $(ASMSRCFILES)) $(patsubst $(CORE_SRC)/%.c, $(BUILD)/%.o, $(CSRCFILES1)) $(patsubst $(USB_SRC)/%.c, $(BUILD)/%.o, $(CSRCFILES2)) $(patsubst $(STARTUP_SRC)/%.c, $(BUILD)/%.o, $(CSRCFILES3)) $(patsubst $(CORE_SRC)/%.cpp, $(BUILD)/%.o, $(CPPSRCFILES1)) $(patsubst $(USB_SRC)/%.cpp, $(BUILD)/%.o, $(CPPSRCFILES2)) $(patsubst $(API_SRC)/%.cpp, $(BUILD)/%.o, $(CPPSRCFILES3)) $(patsubst $(VARIANT_SRC)/%.cpp, $(BUILD)/%.o, $(CPPSRCFILES4))
OBJFILES := $(filter-out $(BUILD)/main.o, $(OBJFILES))

# Target
all: $(LIBDIR)/$(TARGET)

###############################################################################
#
# Create the library
#
###############################################################################
$(LIBDIR)/$(TARGET): $(OBJFILES)
	$(LIB.o) $(OBJFILES)

###############################################################################
#
# Compile source
#
###############################################################################
$(BUILD)/%.o: $(CORE_SRC)/%.S
$(BUILD)/%.o: $(CORE_SRC)/%.S $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.asm) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(CORE_SRC)/%.c
$(BUILD)/%.o: $(CORE_SRC)/%.c $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.c) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(USB_SRC)/%.c
$(BUILD)/%.o: $(USB_SRC)/%.c $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.c) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(STARTUP_SRC)/%.c
$(BUILD)/%.o: $(STARTUP_SRC)/%.c $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.c) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(CORE_SRC)/%.cpp
$(BUILD)/%.o: $(CORE_SRC)/%.cpp $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.cpp) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(USB_SRC)/%.cpp
$(BUILD)/%.o: $(USB_SRC)/%.cpp $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.cpp) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(API_SRC)/%.cpp
$(BUILD)/%.o: $(API_SRC)/%.cpp $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.cpp) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(VARIANT_SRC)/%.cpp
$(BUILD)/%.o: $(VARIANT_SRC)/%.cpp $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.cpp) $<
	$(POSTCOMPILE)

.PRECIOUS = $(DEP)/%.d
$(DEP)/%.d: ;

-include $(DEPFILES)

clean:
	rm $(BUILD)/*
	rm $(LIBDIR)/$(TARGET)
