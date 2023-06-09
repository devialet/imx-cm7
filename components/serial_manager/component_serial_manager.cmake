include_guard()
message("component_serial_manager component is included.")

target_sources(${MCUX_SDK_PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/fsl_component_serial_manager.c
)


target_include_directories(${MCUX_SDK_PROJECT_NAME} PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/.
)


#OR Logic component
if(CONFIG_USE_component_serial_manager_uart)
     include(component_serial_manager_uart)
endif()
if(CONFIG_USE_component_serial_manager_usb_cdc)
     include(component_serial_manager_usb_cdc)
endif()
if(CONFIG_USE_component_serial_manager_virtual)
     include(component_serial_manager_virtual)
endif()
if(CONFIG_USE_component_serial_manager_swo)
     include(component_serial_manager_swo)
endif()
if(CONFIG_USE_component_serial_manager_rpmsg)
     include(component_serial_manager_rpmsg)
endif()
if(CONFIG_USE_component_serial_manager_spi)
     include(component_serial_manager_spi)
endif()
if(NOT (CONFIG_USE_component_serial_manager_uart OR CONFIG_USE_component_serial_manager_usb_cdc OR CONFIG_USE_component_serial_manager_virtual OR CONFIG_USE_component_serial_manager_swo OR CONFIG_USE_component_serial_manager_rpmsg OR CONFIG_USE_component_serial_manager_spi))
    message(WARNING "Since component_serial_manager_uart/component_serial_manager_usb_cdc/component_serial_manager_virtual/component_serial_manager_swo/component_serial_manager_rpmsg/component_serial_manager_spi is not included at first or config in config.cmake file, use component_serial_manager_uart by default.")
    include(component_serial_manager_uart)
endif()

include(driver_common)

include(component_lists)

