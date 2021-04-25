"""
    Copyright 2020 Robert MacGregor

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""

load("@bazel_skylib//lib:selects.bzl", "selects")
load("@rules_foreign_cc//foreign_cc:defs.bzl", "make")

filegroup(
    name = "irrlicht_includes",
    srcs = glob(
        include = [
            "irrlicht-1.8.4/include/**/*.h",
            "irrlicht-1.8.4/include/**/*.hpp",
            "irrlicht-1.8.4/source/Irrlicht/**/*.h",
            "irrlicht-1.8.4/source/Irrlicht/**/*.hpp"
        ]
    )
)

filegroup(
    name = "irrlicht_sources",
    srcs = glob(
        include = [
            "irrlicht-1.8.4/source/Irrlicht/**/*.c",
            "irrlicht-1.8.4/source/Irrlicht/**/*.cpp"
        ],
        # Ignore files we don't want
        exclude = [
            "irrlicht-1.8.4/source/Irrlicht/bzip2/dlltest.c",
            "irrlicht-1.8.4/source/Irrlicht/bzip2/bzip2.c",
            "irrlicht-1.8.4/source/Irrlicht/bzip2/unzcrash.c",
            "irrlicht-1.8.4/source/Irrlicht/bzip2/mk251.c",
            "irrlicht-1.8.4/source/Irrlicht/bzip2/spewG.c",
            "irrlicht-1.8.4/source/Irrlicht/bzip2/bzip2recover.c",

            "irrlicht-1.8.4/source/Irrlicht/libpng/pngtest.c",

            "irrlicht-1.8.4/source/Irrlicht/jpeglib/example.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/jpegtran.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/djpeg.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/cjpeg.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/jmemansi.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/jmemname.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/jmemmac.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/jmemdos.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/wrjpgcom.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/rdjpgcom.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/cdjpeg.c",
            "irrlicht-1.8.4/source/Irrlicht/jpeglib/ansi2knr.c",
        ]
    )
)

# Renderer configuration
config_setting(
    name = "no_renderer_direct3d8",
    define_values = {
        "irrlicht_d3d8": "disabled",
    }
)

config_setting(
    name = "no_renderer_direct3d9",
    define_values = {
        "irrlicht_d3d9": "disabled",
    }
)

config_setting(
    name = "no_renderer_opengl",
    define_values = {
        "irrlicht_opengl": "disabled",
    }
)

config_setting(
    name = "no_renderer_software",
    define_values = {
        "irrlicht_software": "disabled",
    }
)

config_setting(
    name = "no_renderer_burnings",
    define_values = {
        "irrlicht_burnings": "disabled",
    }
)

user_config_defines = select({
    "//conditions:default": [],
    ":no_renderer_direct3d8": ["NO_IRR_COMPILE_WITH_DIRECT3D_8_=1"]
    # Handle D3D9
    }) + select({
        "//conditions:default": [],
        ":no_renderer_direct3d9": ["NO_IRR_COMPILE_WITH_DIRECT3D_9_=1"]
    # Handle OpenGL
    }) + select({
        "//conditions:default": [],
        ":no_renderer_opengl": ["NO_IRR_COMPILE_WITH_OPENGL_=1"]
    # Handle software
    }) + select({
        "//conditions:default": [],
        ":no_renderer_software": ["NO_IRR_COMPILE_WITH_SOFTWARE_=1"]
    # Handle burnings
    }) + select({
        "//conditions:default": [],
        ":no_renderer_burnings": ["NO_IRR_COMPILE_WITH_BURNINGSVIDEO_=1"]
    }
)

cc_library(
    name = "irrlicht",
    srcs = [
        ":irrlicht_sources"
    ],
    hdrs = [
        ":irrlicht_includes"
    ],
    includes = [
        "irrlicht-1.8.4/include",

        "irrlicht-1.8.4/source/Irrlicht/zlib",
        "irrlicht-1.8.4/source/Irrlicht/jpeglib",
        "irrlicht-1.8.4/source/Irrlicht/libpng",
    ],
    defines = [
        "IRRLICHT_EXPORTS=1",

        "PNG_THREAD_UNSAFE_OK",
        "DPNG_NO_MMX_CODE",
        "PNG_NO_MNG_FEATURES"
    ] + user_config_defines,
    copts = [
        "-Wall",
        "-pipe",
        "-fno-exceptions",
        "-fno-rtti",
        "-fstrict-aliasing",

        # Required for FS to compile
        "-U__STRICT_ANSI__"
    ],
    linkopts = select({
        "//conditions:default": [
            "-lGL",
            "-lXxf86vm"
        ],

        "@bazel_tools//src/conditions:windows": [
            "gdi32.lib",
            "opengl32.lib",
            "d3dx9d.lib",
            "winmm.lib",
        ]
    }),

    visibility = ["//visibility:public"],
)
