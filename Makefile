# --- devkitPro WiiU RmlUi Builder ---

ifeq ($(strip $(DEVKITPRO)),)
$(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>/devkitpro")
endif

BASH := $(DEVKITPRO)/msys2/usr/bin/bash.exe

RMLUI_DIR := $(CURDIR)
BUILD_DIR := WiiU

INSTALL_INC := $(DEVKITPRO)/portlibs/ppc/include
INSTALL_LIB := $(DEVKITPRO)/portlibs/ppc/lib

CMAKE_FLAGS := -G "MSYS Makefiles" \
	-DCMAKE_TOOLCHAIN_FILE=CMake/Toolchains/WiiU.cmake \
	-DRMLUI_BACKEND=auto \
	-DRMLUI_SAMPLES=OFF \
	-DRMLUI_TESTS=OFF

# --- Targets ---
all: configure build

configure:
	@echo "== Configuring RmlUi..."
	$(BASH) -c 'cd "$(RMLUI_DIR)" && cmake $(CMAKE_FLAGS) -B "$(BUILD_DIR)"'

build:
	@echo "== Building RmlUi..."
	$(BASH) -c 'cd "$(RMLUI_DIR)" && cmake --build "$(BUILD_DIR)"'

clean:
	@echo "== Cleaning build..."
	$(BASH) -c 'cd "$(RMLUI_DIR)" && rm -rf "$(BUILD_DIR)"'

install:
	@echo "== Installing headers to $(INSTALL_INC)"
	$(BASH) -c 'mkdir -p "$(INSTALL_INC)"'
	$(BASH) -c 'cp -r "$(RMLUI_DIR)/Include/RmlUi" "$(INSTALL_INC)"'

	@echo "== Installing libs to $(INSTALL_LIB)"
	$(BASH) -c 'mkdir -p "$(INSTALL_LIB)"'
	# *.a はシェル側で展開させる
	$(BASH) -c 'cp $(RMLUI_DIR)/$(BUILD_DIR)/*.a "$(INSTALL_LIB)"'
