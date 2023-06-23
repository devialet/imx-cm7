#!/bin/sh
export ARMGCC_DIR=/usr
if [ -d "CMakeFiles" ];then rm -rf CMakeFiles; fi
if [ -f "Makefile" ];then rm -f Makefile; fi
if [ -f "cmake_install.cmake" ];then rm -f cmake_install.cmake; fi
if [ -f "CMakeCache.txt" ];then rm -f CMakeCache.txt; fi
if [ -z "$1" ]; then
    echo "usage: $0 <platform>"
    exit 0
fi
if [ "$1" = "imx8mp" ]; then
    cmake -DTARGET_PLATFORM="MIMX8ML8" -DTARGET_INCLUDE="imx8mp" -DCMAKE_TOOLCHAIN_FILE="../../../sdk/tools/cmake_toolchain_files/armgcc.cmake" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=debug  .
elif [ "$1" = "imx8mn" ]; then
    cmake -DTARGET_PLATFORM="MIMX8MN6" -DTARGET_INCLUDE="imx8mn" -DCMAKE_TOOLCHAIN_FILE="../../../sdk/tools/cmake_toolchain_files/armgcc.cmake" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=debug  .
else
    echo "usage: $0 <platform>"
fi
make -j 2>&1 | tee build_log.txt
