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
load("@rules_foreign_cc//tools/build_defs:make.bzl", "make")

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

filegroup(
    name = "irrlicht_files",
    srcs = glob(
        include=[
            "irrlicht-1.8.4/**/*"
        ]
    )
)

irrlicht_defines = select({
    "//conditions:default": [],
    ":no_renderer_direct3d8": ["export NO_IRR_COMPILE_WITH_DIRECT3D_8_=1"]
    # Handle D3D9
    }) + select({
        "//conditions:default": [],
        ":no_renderer_direct3d9": ["export NO_IRR_COMPILE_WITH_DIRECT3D_9_=1"]
    # Handle OpenGL
    }) + select({
        "//conditions:default": [],
        ":no_renderer_opengl": ["export NO_IRR_COMPILE_WITH_OPENGL_=1"]
    # Handle software
    }) + select({
        "//conditions:default": [],
        ":no_renderer_software": ["export NO_IRR_COMPILE_WITH_SOFTWARE_=1"]
    # Handle burnings
    }) + select({
        "//conditions:default": [],
        ":no_renderer_burnings": ["export NO_IRR_COMPILE_WITH_BURNINGSVIDEO_=1"]
    }
)

make_command = select({
    "//conditions:default": [
        "pushd source/Irrlicht",
        "make -j$(nproc)"
    ],

    "@bazel_tools//src/conditions:darwin": [
        "pushd source/Irrlicht/MacOSX",
        # xcodebuild fails - if it does work where does it end up at?
        "xcodebuild",
    ]
})

collect_command = select({
    "//conditions:default": [
        # Make install doesn't work so we install it ourselves
        "mkdir -p $INSTALLDIR/lib",
        "mkdir -p $INSTALLDIR/include",
        "cp lib/Linux/libIrrlicht.a $INSTALLDIR/lib",
        "cp include/*.h $INSTALLDIR/include",
    ],

    "@bazel_tools//src/conditions:windows": [
        # Make install doesn't work so we install it ourselves
        "mkdir -p $INSTALLDIR/lib",
        "mkdir -p $INSTALLDIR/include",
        "cp lib/Win64-visualStudio/libIrrlicht.lib $INSTALLDIR/lib",
        "cp include/*.h $INSTALLDIR/include",
    ],

    "@bazel_tools//src/conditions:darwin": [

    ]
})

make(
    name = "irrlicht",
    lib_source = ":irrlicht_files",

    static_libraries = select({
        "@bazel_tools//src/conditions:windows": ["libIrrlicht.lib"],
        "//conditions:default": ["libIrrlicht.a"]
    }),

    make_commands = irrlicht_defines + make_command + [
        "popd",
    ] + collect_command,
    visibility = ["//visibility:public"]
)
