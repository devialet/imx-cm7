include_guard()
message("component_serial_manager_uart component is included.")

target_sources(${MCUX_SDK_PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/fsl_component_serial_port_uart.c
)


target_include_directories(${MCUX_SDK_PROJECT_NAME} PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/.
)


#OR Logic component
if(CONFIG_USE_driver_iuart)
     include(driver_iuart)
endif()
if(NOT (CONFIG_USE_driver_iuart))
    message(WARNING "Since driver_iuart is not included at first or config in config.cmake file, use driver_uart by default.")
    include(driver_uart)
endif()

include(component_iuart_adapter)

include(component_serial_manager)

