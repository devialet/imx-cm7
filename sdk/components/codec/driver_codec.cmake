include_guard()
message("driver_codec component is included.")

target_sources(${MCUX_SDK_PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/fsl_codec_common.c
)


target_include_directories(${MCUX_SDK_PROJECT_NAME} PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/.
)


#OR Logic component
if(CONFIG_USE_component_wm8904_adapter)
     include(component_wm8904_adapter)
endif()
if(CONFIG_USE_component_wm8960_adapter)
     include(component_wm8960_adapter)
endif()
if(CONFIG_USE_component_wm8962_adapter)
     include(component_wm8962_adapter)
endif()
if(CONFIG_USE_component_wm8524_adapter)
     include(component_wm8524_adapter)
endif()
if(CONFIG_USE_component_sgtl_adapter)
     include(component_sgtl_adapter)
endif()
if(CONFIG_USE_component_da7212_adapter)
     include(component_da7212_adapter)
endif()
if(CONFIG_USE_component_ak4497_adapter)
     include(component_ak4497_adapter)
endif()
if(CONFIG_USE_component_tfa9xxx_adapter)
     include(component_tfa9xxx_adapter)
endif()
if(CONFIG_USE_component_tfa9896_adapter)
     include(component_tfa9896_adapter)
endif()
if(CONFIG_USE_component_cs42888_adapter)
     include(component_cs42888_adapter)
endif()
if(CONFIG_USE_component_cs42448_adapter)
     include(component_cs42448_adapter)
endif()
if(CONFIG_USE_component_codec_adapters)
     include(component_codec_adapters)
endif()
if(NOT (CONFIG_USE_component_wm8904_adapter OR CONFIG_USE_component_wm8960_adapter OR CONFIG_USE_component_wm8962_adapter OR CONFIG_USE_component_wm8524_adapter OR CONFIG_USE_component_sgtl_adapter OR CONFIG_USE_component_da7212_adapter OR CONFIG_USE_component_ak4497_adapter OR CONFIG_USE_component_tfa9xxx_adapter OR CONFIG_USE_component_tfa9896_adapter OR CONFIG_USE_component_cs42888_adapter OR CONFIG_USE_component_cs42448_adapter OR CONFIG_USE_component_codec_adapters))
    message(WARNING "Since component_wm8904_adapter/component_wm8960_adapter/component_wm8962_adapter/component_wm8524_adapter/component_sgtl_adapter/component_da7212_adapter/component_ak4497_adapter/component_tfa9xxx_adapter/component_tfa9896_adapter/component_cs42888_adapter/component_cs42448_adapter/component_codec_adapters is not included at first or config in config.cmake file, use component_wm8904_adapter by default.")
    include(component_wm8904_adapter)
endif()

include(driver_common)

