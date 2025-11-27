# RmlUi for WiiU

This is a WiiU port of **RmlUi** (libRocket-compatible UI library).
Original project: [RmlUi](https://github.com/mikke89/RmlUi)

## Features

* HTML/CSS-like UI construction
* Lightweight C++ library
* Ported to run on WiiU
* Declarative UI unlike immediate-mode UI like ImGui

## Build & Install

1. Clone the repository

```bash
git clone <repository URL>
cd librmlui
```

2. Build

```bash
make
```

3. Install

```bash
make install
```

> `make install` copies necessary headers and libraries to the designated location.

## Dependencies

* devkitPPC / devkitPro
* libpng, zlib, etc. (as needed)

## References

* Original RmlUi: [https://github.com/mikke89/RmlUi](https://github.com/mikke89/RmlUi)
