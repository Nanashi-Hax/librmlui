# --- devkitPro WiiU Toolchain ---

# Target system
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR powerpc)

set(WIIU ON)
set(__WIIU__ ON)
set(RMLUI_FONT_ENGINE_FREETYPE ON)

# Detect DEVKITPRO
if(NOT DEFINED ENV{DEVKITPRO})
    if(EXISTS "C:/devkitPro")
        set(DEVKITPRO "C:/devkitPro")
    elseif(EXISTS "D:/devkitPro")
        set(DEVKITPRO "D:/devkitPro")
    elseif(EXISTS "/opt/devkitpro")
        set(DEVKITPRO "/opt/devkitpro")
    else()
        set(DEVKITPRO "C:/devkitPro")
    endif()
else()
    set(DEVKITPRO $ENV{DEVKITPRO})
endif()

set(DEVKITPPC "${DEVKITPRO}/devkitPPC")

# Cross compiler
set(CMAKE_C_COMPILER "${DEVKITPPC}/bin/powerpc-eabi-gcc.exe")
set(CMAKE_CXX_COMPILER "${DEVKITPPC}/bin/powerpc-eabi-g++.exe")
set(CMAKE_ASM_COMPILER "${DEVKITPPC}/bin/powerpc-eabi-gcc.exe")
set(CMAKE_AR "${DEVKITPPC}/bin/powerpc-eabi-gcc-ar.exe")
set(CMAKE_RANLIB "${DEVKITPPC}/bin/powerpc-eabi-gcc-ranlib.exe")

# Root paths
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Compiler flags
set(COMMON_FLAGS "-mcpu=750 -meabi -mhard-float -ffunction-sections -fdata-sections")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COMMON_FLAGS}" CACHE STRING "Common C flags")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COMMON_FLAGS}" CACHE STRING "Common C++ flags")

# Preprocessor definitions
add_definitions(-D__WIIU__ -DWIIU -DRMLUI_FONT_ENGINE_FREETYPE)

# FreeType detection (devkitPro portlibs)
set(FREETYPE_INCLUDE_DIRS "${DEVKITPRO}/portlibs/ppc/include/freetype2")
set(FREETYPE_LIBRARY "${DEVKITPRO}/portlibs/ppc/lib/libfreetype.a")
