# freertos/lwip template // cmake template  taken from
# pico-examples/pico_w/wifi/freertos/iperf

# Generated Cmake Pico project file

cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Initialise pico_sdk from installed location
# (note this can come from environment, CMake cache etc)
# set(PICO_SDK_PATH "d:/RaspberryPiPico2/pico-sdk")

set(PICO_BOARD pico CACHE STRING "Board type")

# Pull in Raspberry Pi Pico SDK (must be before project)
include(pico_sdk_import.cmake)

if (PICO_SDK_VERSION_STRING VERSION_LESS "1.4.0")
  message(FATAL_ERROR "Raspberry Pi Pico SDK version 1.4.0 (or later) required. Your version is ${PICO_SDK_VERSION_STRING}")
endif()



project(usb_audio3 C CXX ASM)

# Initialise the Raspberry Pi Pico SDK
pico_sdk_init()

# Add executable. Default name is the project name, version 0.2.1


add_executable(usb_audio3
	src/usb_sound_card.c
#	src/buffer.c
	src/usb_device.c
	src/usb_stream_helper.c
#	src/audio_i2s.c
)

target_compile_definitions(usb_audio3 PRIVATE
            AUDIO_FREQ_MAX=48000

            # ours are zero based, so say so
            PICO_USBDEV_USE_ZERO_BASED_INTERFACES=0

            # need large descriptor
            PICO_USBDEV_MAX_DESCRIPTOR_SIZE=256


            PICO_USBDEV_ISOCHRONOUS_BUFFER_STRIDE_TYPE=1
            PICO_USBDEV_ENABLE_DEBUG_TRAgCE

            PICO_AUDIO_I2S_MONO_OUTPUT=0
            PICO_AUDIO_I2S_MONO_INPUT=0
)

# pico_generate_pio_header(usb_audio3 ${CMAKE_CURRENT_LIST_DIR}/src/audio_i2s.pio)

pico_set_program_name(usb_audio3 "usb_audio3")
pico_set_program_version(usb_audio3 "0.1.0")


# Add the standard include files to the build
target_include_directories(usb_audio3 PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}
  ${CMAKE_CURRENT_LIST_DIR}/src
#  ${CMAKE_CURRENT_LIST_DIR}/../.. # for our common lwipopts or any other standard includes, if required
)

#target_sources(usb_audio3 INTERFACE
#    ${CMAKE_CURRENT_LIST_DIR}/audio.cpp
#    $<$<NOT:$<BOOL:${PICO_NO_HARDWARE}>>:${CMAKE_CURRENT_LIST_DIR}/audio_utils.S>
#)



# Add any user requested libraries
target_link_libraries(usb_audio3
    pico_stdlib
#    usb_device
#    pico_audio_i2s
    pico_multicore
#########################
#    usb_common
    hardware_irq
    hardware_dma
    hardware_pio
    pico_fix_rp2040_usb_device_enumeration
#    pico_audio_headers
    pico_sync
#    pico_audio
)

pico_add_extra_outputs(usb_audio3)

