# CROSS COMPILER SETTING
SET(CMAKE_SYSTEM_NAME Generic)
CMAKE_MINIMUM_REQUIRED (VERSION 3.10.0)

# THE VERSION NUMBER
SET (Tutorial_VERSION_MAJOR 1)
SET (Tutorial_VERSION_MINOR 0)

# ENABLE ASM
ENABLE_LANGUAGE(ASM)

SET(CMAKE_STATIC_LIBRARY_PREFIX)
SET(CMAKE_STATIC_LIBRARY_SUFFIX)

SET(CMAKE_EXECUTABLE_LIBRARY_PREFIX)
SET(CMAKE_EXECUTABLE_LIBRARY_SUFFIX)

# CURRENT DIRECTORY
SET(ProjDirPath ${CMAKE_CURRENT_SOURCE_DIR})

SET(EXECUTABLE_OUTPUT_PATH ${ProjDirPath}/${CMAKE_BUILD_TYPE})
SET(LIBRARY_OUTPUT_PATH ${ProjDirPath}/${CMAKE_BUILD_TYPE})


project(sai_low_power_audio)

set(MCUX_BUILD_TYPES debug release)

set(MCUX_SDK_PROJECT_NAME sai_low_power_audio.elf)

if (NOT DEFINED SdkRootDirPath)
    SET(SdkRootDirPath ${ProjDirPath}/../../../../..)
endif()

include(${ProjDirPath}/flags.cmake)

include(${ProjDirPath}/config.cmake)

add_executable(${MCUX_SDK_PROJECT_NAME} 
"${ProjDirPath}/../srtm_config.h"
"${ProjDirPath}/../app_srtm.c"
"${ProjDirPath}/../app_srtm.h"
"${ProjDirPath}/../FreeRTOSConfig.h"
"${ProjDirPath}/../rpmsg_config.h"
"${ProjDirPath}/../lpm.c"
"${ProjDirPath}/../lpm.h"
"${ProjDirPath}/../sai_low_power_audio.c"
"${ProjDirPath}/../sai_low_power_audio.h"
"${ProjDirPath}/../pin_mux.c"
"${ProjDirPath}/../pin_mux.h"
"${ProjDirPath}/../rsc_table.c"
"${ProjDirPath}/../rsc_table.h"
"${ProjDirPath}/../remoteproc.h"
"${ProjDirPath}/../board.c"
"${ProjDirPath}/../board.h"
"${ProjDirPath}/../clock_config.c"
"${ProjDirPath}/../clock_config.h"
"${ProjDirPath}/../fsl_iomuxc.h"
"${SdkRootDirPath}/components/srtm/channels/srtm_rpmsg_endpoint.h"
"${SdkRootDirPath}/components/srtm/channels/srtm_rpmsg_endpoint.c"
"${SdkRootDirPath}/components/srtm/services/srtm_audio_service.h"
"${SdkRootDirPath}/components/srtm/services/srtm_audio_service.c"
"${SdkRootDirPath}/components/srtm/services/srtm_sai_sdma_adapter.h"
"${SdkRootDirPath}/components/srtm/services/srtm_sai_sdma_adapter.c"
"${SdkRootDirPath}/components/srtm/services/srtm_pdm_sdma_adapter.h"
"${SdkRootDirPath}/components/srtm/services/srtm_pdm_sdma_adapter.c"
"${SdkRootDirPath}/components/srtm/services/srtm_i2c_service.h"
"${SdkRootDirPath}/components/srtm/services/srtm_i2c_service.c"
)

target_include_directories(${MCUX_SDK_PROJECT_NAME} PUBLIC
    ${ProjDirPath}/..
    ${SdkRootDirPath}/components/srtm/channels
    ${SdkRootDirPath}/components/srtm/services
)

set(CMAKE_MODULE_PATH
    ${SdkRootDirPath}/devices/MIMX8ML8/drivers
    ${SdkRootDirPath}/middleware/multicore
    ${SdkRootDirPath}/devices/MIMX8ML8
    ${SdkRootDirPath}/devices/MIMX8ML8/utilities
    ${SdkRootDirPath}/components/uart
    ${SdkRootDirPath}/components/serial_manager
    ${SdkRootDirPath}/components/lists
    ${SdkRootDirPath}/CMSIS/Core/Include
    ${SdkRootDirPath}/components/srtm/port
    ${SdkRootDirPath}/components/srtm
    ${SdkRootDirPath}/rtos/freertos/freertos-kernel
)

# include modules
include(driver_igpio)

include(driver_ii2c)

include(driver_gpt)

include(driver_gpc_2)

include(driver_pdm)

include(driver_pdm_sdma)

include(middleware_multicore_rpmsg_lite)

include(middleware_multicore_rpmsg_lite_freertos)

include(driver_clock)

include(driver_sai)

include(driver_sai_sdma)

include(driver_common)

include(driver_rdc)

include(driver_audiomix)

include(device_CMSIS)

include(utility_debug_console)

include(component_iuart_adapter)

include(component_serial_manager)

include(component_lists)

include(component_serial_manager_uart)

include(driver_iuart)

include(device_startup)

include(utility_assert)

include(CMSIS_Include_core_cm)

include(driver_sdma)

include(driver_memory)

include(driver_mu)

include(driver_srtm_freertos)

include(driver_srtm)

include(middleware_multicore_rpmsg_lite_imx8mp_m7_freertos)

include(middleware_freertos-kernel)

include(middleware_freertos-kernel_extension)

include(middleware_freertos-kernel_heap_4)

include(utilities_misc_utilities)

include(device_system)


IF(NOT DEFINED TARGET_LINK_SYSTEM_LIBRARIES)  
    SET(TARGET_LINK_SYSTEM_LIBRARIES "-lm -lc -lgcc -lnosys")  
ENDIF()  

TARGET_LINK_LIBRARIES(${MCUX_SDK_PROJECT_NAME} PRIVATE -Wl,--start-group)

target_link_libraries(${MCUX_SDK_PROJECT_NAME} PRIVATE ${TARGET_LINK_SYSTEM_LIBRARIES})

TARGET_LINK_LIBRARIES(${MCUX_SDK_PROJECT_NAME} PRIVATE -Wl,--end-group)

ADD_CUSTOM_COMMAND(TARGET ${MCUX_SDK_PROJECT_NAME} POST_BUILD COMMAND ${CMAKE_OBJCOPY}
-Obinary ${EXECUTABLE_OUTPUT_PATH}/${MCUX_SDK_PROJECT_NAME} ${EXECUTABLE_OUTPUT_PATH}/sai_low_power_audio.bin)

