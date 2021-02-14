#!/bin/bash

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

# Source directory
SRC=src

# Build output directory
BUILD=build

# Library directory
LIBDIR=lib

# Arduino base directory
ARDUINOBASE=/Users/guy/Library/Arduino15/packages/arduino
CMSISBASE=$ARDUINOBASE/tools/CMSIS
SAMDBASE=$ARDUINOBASE/hardware/samd/1.8.11

# Source directories
CORE_SRC=$SAMDBASE/cores/arduino
USB_SRC=$CORE_SRC/USB
API_SRC=$CORE_SRC/api
STARTUP_SRC=$ARDUINOBASE/tools/CMSIS-Atmel/1.2.0/CMSIS/Device/ATMEL/samd21/source/as_gcc
VARIANT_SRC=$SAMDBASE/variants/$BOARD_VARIANT

# What is our target
TARGET=$LIBDIR/$PROJNAME.a

# Tools
CC=arm-none-eabi-gcc
CPP=arm-none-eabi-g++
ASM=arm-none-eabi-gcc
LIB=arm-none-eabi-ar

# Include dir flags
INCLUDEFLAGS="-I$CMSISBASE/4.5.0/CMSIS/Include/ -I$ARDUINOBASE/tools/CMSIS-Atmel/1.2.0/CMSIS/Device/ATMEL/ -I$ARDUINOBASE/tools/CMSIS-Atmel/1.2.0/CMSIS/Device/ATMEL/samd21/include/ -I$SAMDBASE/cores/arduino/api/deprecated -I$SAMDBASE/cores/arduino/api/deprecated-avr-comp -I$SAMDBASE/cores/arduino -I$SAMDBASE/variants/$BOARD_VARIANT"

# C compiler flags
CFLAGS="-c -mcpu=$DEVICE -mthumb -g -Os -Wall -std=gnu11 -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -DF_CPU=48000000L -DARDUINO=10813 -DARDUINO_SAMD_MKRWAN1310 -DARDUINO_ARCH_SAMD -DUSE_ARDUINO_MKR_PIN_LAYOUT -D__SAMD21G18A__ -DUSB_VID=0x2341 -DUSB_PID=0x8059 -DUSBCON \"-DUSB_MANUFACTURER=\"Arduino LLC\" \"-DUSB_PRODUCT=\"Arduino MKR WAN 1310\" -DUSE_BQ24195L_PMIC -DVERY_LOW_POWER $INCLUDEFLAGS"
CPPFLAGS="-c -mcpu=$DEVICE -g -Os -mthumb -Wall -std=gnu++11 -ffunction-sections -fdata-sections -fno-threadsafe-statics -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -DF_CPU=48000000L -DARDUINO=10813 -DARDUINO_SAMD_MKRWAN1310 -DARDUINO_ARCH_SAMD -DUSE_ARDUINO_MKR_PIN_LAYOUT -D__SAMD21G18A__ -DUSB_VID=0x2341 -DUSB_PID=0x8059 -DUSBCON \"-DUSB_MANUFACTURER=\"Arduino LLC\" \"-DUSB_PRODUCT=\"Arduino MKR WAN 1310\" -DUSE_BQ24195L_PMIC -DVERY_LOW_POWER $INCLUDEFLAGS"
ASMFLAGS="-c -g -x assembler-with-cpp -DF_CPU=48000000L -DARDUINO=10813 -DARDUINO_SAMD_MKRWAN1310 -DARDUINO_ARCH_SAMD -DUSE_ARDUINO_MKR_PIN_LAYOUT -D__SAMD21G18A__ -DUSB_VID=0x2341 -DUSB_PID=0x8059 -DUSBCON \"-DUSB_MANUFACTURER=\"Arduino LLC\" \"-DUSB_PRODUCT=\"Arduino MKR WAN 1310\" -DUSE_BQ24195L_PMIC -DVERY_LOW_POWER $INCLUDEFLAGS"

# Lib tool flags
LIBFLAGS=rcs

rm $BUILD/*
rm $SRC/*
rm $LIBDIR/*

mkdir -p $SRC
mkdir -p $BUILD

cp $CORE_SRC/*.S $SRC

cp $CORE_SRC/*.c $SRC 
cp $USB_SRC/*.c $SRC
cp $STARTUP_SRC/*.c $SRC

cp $CORE_SRC/*.cpp $SRC
cp $USB_SRC/*.cpp $SRC
cp $API_SRC/*.cpp $SRC
cp $VARIANT_SRC/*.cpp $SRC

OBJFILES=

###############################################################################
#
# Compile source
#
###############################################################################
for s in $SRC/*.S
do
    so="${$s/$SRC/$BUILD}/.o"
	$ASM $ASMFLAGS $INCLUDEFLAGS -o $so $s
    OBJFILES=$OBJFILES $so
done

for c in $SRC/*.c
do
    co=${$c/$SRC/$BUILD}/.o
	$CC $CFLAGS $INCLUDEFLAGS -o $co $c
    OBJFILES=$OBJFILES $co
done

for cpp in $SRC/*.cpp
do
    cppo=${$cpp/$SRC/$BUILD}/.o
	$CPP $CPPFLAGS $INCLUDEFLAGS -o $cppo $cpp
    OBJFILES=$OBJFILES $cppo
done

###############################################################################
#
# Create the library
#
###############################################################################
$LIB $LIBFLAGS $TARGET $OBJFILES
