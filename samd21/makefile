###############################################################################
#                                                                             #
# MAKEFILE for rtwc - A weather station with a real-time scheduler            #
#                                                                             #
# Guy Wilson (c) 2018                                                         #
#                                                                             #
###############################################################################

PROJNAME=libcore-samd21

# Target device
DEVICE=cortex-m0plus

# Target architecture size
ARCHSIZE=32

# What is our target
TARGET=$(PROJNAME).a

# Build output directory
BUILD=build

# Source directory
CORE_SRC=/Users/guy/Library/Arduino15/packages/arduino/hardware/samd/1.8.11/cores/arduino
USB_SRC=$(CORE_SRC)/USB
API_SRC=$(CORE_SRC)/api

# Arduino base directory
ARDUINOBASE=/Users/guy/Library/Arduino15/packages/arduino
CMSISBASE=$(ARDUINOBASE)/tools/CMSIS
SAMDBASE=$(ARDUINOBASE)/hardware/samd/1.8.11

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
CFLAGS=-c -mcpu=$(DEVICE) -mthumb -Wall -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -DF_CPU=48000000L -DARDUINO=10813 -DARDUINO_SAMD_MKRWAN1310 -DARDUINO_ARCH_SAMD -DUSE_ARDUINO_MKR_PIN_LAYOUT -D__SAMD21G18A__ -DUSE_BQ24195L_PMIC -DVERY_LOW_POWER $(INCLUDEFLAGS)
CPPFLAGS=-c -mcpu=$(DEVICE) -mthumb -Wall -std=gnu++11 -ffunction-sections -fdata-sections -nostdlib -fno-threadsafe-statics --param max-inline-insns-single=500 -DF_CPU=48000000L -DARDUINO=10813 -DARDUINO_SAMD_MKRWAN1310 -DARDUINO_ARCH_SAMD -DUSE_ARDUINO_MKR_PIN_LAYOUT -D__SAMD21G18A__ -DUSE_BQ24195L_PMIC -DVERY_LOW_POWER $(INCLUDEFLAGS)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEP)/$*.Td
ASMFLAGS=-c -x assembler-with-cpp -DF_CPU=48000000L -DARDUINO=10813 -DARDUINO_SAMD_MKRWAN1310 -DARDUINO_ARCH_SAMD -DUSE_ARDUINO_MKR_PIN_LAYOUT -D__SAMD21G18A__ -DUSE_BQ24195L_PMIC -DVERY_LOW_POWER $(INCLUDEFLAGS)

# Lib tool flags
LIBFLAGS=rcs

COMPILE.c = $(CC) $(CFLAGS) $(INCLUDEFLAGS) $(DEPFLAGS) -o $@
COMPILE.cpp = $(CPP) $(CPPFLAGS) $(INCLUDEFLAGS) $(DEPFLAGS) -o $@
COMPILE.asm = $(ASM) $(ASMFLAGS) $(INCLUDEFLAGS) $(DEPFLAGS) -o $@
LIB.o = $(LIB) $(LIBFLAGS) $@

CORECSRCFILES = $(wildcard $(CORE_SRC)/*.c)
USBCSRCFILES = $(wildcard $(USB_SRC)/*.c)
CORECPPSRCFILES = $(wildcard $(CORE_SRC)/*.cpp)
USBCPPSRCFILES = $(wildcard $(USB_SRC)/*.cpp)
APICPPSRCFILES = $(wildcard $(API_SRC)/*.cpp)
COREASMSRCFILES = $(wildcard $(CORE_SRC)/*.S)
DEPFILES = $(patsubst $(CORE_SRC)/%.S, $(DEP)/%.d, $(COREASMSRCFILES)) $(patsubst $(CORE_SRC)/%.c, $(DEP)/%.d, $(CORECSRCFILES)) $(patsubst $(USB_SRC)/%.c, $(DEP)/%.d, $(USBCSRCFILES)) $(patsubst $(CORE_SRC)/%.cpp, $(DEP)/%.d, $(CORECPPSRCFILES)) $(patsubst $(USB_SRC)/%.cpp, $(DEP)/%.d, $(USBCPPSRCFILES)) $(patsubst $(API_SRC)/%.cpp, $(DEP)/%.d, $(APICPPSRCFILES))
OBJFILES := $(patsubst $(CORE_SRC)/%.S, $(BUILD)/%.o, $(COREASMSRCFILES)) $(patsubst $(CORE_SRC)/%.c, $(BUILD)/%.o, $(CORECSRCFILES)) $(patsubst $(USB_SRC)/%.c, $(BUILD)/%.o, $(USBCSRCFILES)) $(patsubst $(CORE_SRC)/%.cpp, $(BUILD)/%.o, $(CORECPPSRCFILES)) $(patsubst $(USB_SRC)/%.cpp, $(BUILD)/%.o, $(USBCPPSRCFILES)) $(patsubst $(API_SRC)/%.cpp, $(BUILD)/%.o, $(APICPPSRCFILES))
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
$(BUILD)/%.o: $(CORE_SRC)/%.c
$(BUILD)/%.o: $(CORE_SRC)/%.c $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.c) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(CORE_SRC)/%.cpp
$(BUILD)/%.o: $(CORE_SRC)/%.cpp $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.cpp) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(CORE_SRC)/%.S
$(BUILD)/%.o: $(CORE_SRC)/%.S $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.asm) $<
	$(POSTCOMPILE)

$(BUILD)/%.o: $(USB_SRC)/%.c
$(BUILD)/%.o: $(USB_SRC)/%.c $(DEP)/%.d
	$(PRECOMPILE)
	$(COMPILE.c) $<
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

.PRECIOUS = $(DEP)/%.d
$(DEP)/%.d: ;

-include $(DEPFILES)

clean:
	rm $(BUILD)/*
	rm $(LIBDIR)/$(TARGET)
