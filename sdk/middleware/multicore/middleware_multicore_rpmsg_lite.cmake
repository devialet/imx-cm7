include_guard()
message("middleware_multicore_rpmsg_lite component is included.")

target_sources(${MCUX_SDK_PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/rpmsg_lite/lib/common/llist.c
    ${CMAKE_CURRENT_LIST_DIR}/rpmsg_lite/lib/rpmsg_lite/rpmsg_lite.c
    ${CMAKE_CURRENT_LIST_DIR}/rpmsg_lite/lib/rpmsg_lite/rpmsg_ns.c
    ${CMAKE_CURRENT_LIST_DIR}/rpmsg_lite/lib/virtio/virtqueue.c
)


target_include_directories(${MCUX_SDK_PROJECT_NAME} PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/rpmsg_lite/lib/include
)


#OR Logic component
if(CONFIG_USE_middleware_multicore_rpmsg_lite_freertos)
     include(middleware_multicore_rpmsg_lite_freertos)
endif()
if(CONFIG_USE_middleware_multicore_rpmsg_lite_bm)
     include(middleware_multicore_rpmsg_lite_bm)
endif()
if(CONFIG_USE_middleware_multicore_rpmsg_lite_xos)
     include(middleware_multicore_rpmsg_lite_xos)
endif()
if(NOT (CONFIG_USE_middleware_multicore_rpmsg_lite_freertos OR CONFIG_USE_middleware_multicore_rpmsg_lite_bm OR CONFIG_USE_middleware_multicore_rpmsg_lite_xos))
    message(WARNING "Since middleware_multicore_rpmsg_lite_freertos/middleware_multicore_rpmsg_lite_bm/middleware_multicore_rpmsg_lite_xos is not included at first or config in config.cmake file, use middleware_multicore_rpmsg_lite_bm by default.")
    include(middleware_multicore_rpmsg_lite_bm)
endif()

