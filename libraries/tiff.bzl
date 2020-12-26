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

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def tiff():
    maybe(
        http_archive,
        name = "tiff",
        url = "https://download.osgeo.org/libtiff/tiff-4.1.0.tar.gz",
        sha256 = "5d29f32517dadb6dbcd1255ea5bbc93a2b54b94fbf83653b4d65c7d6775b8634",
        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

cmake_external(
name = "tiff",
lib_source = "@tiff//:tiff-4.1.0",

shared_libraries = select({
    "@bazel_tools//src/conditions:windows": [

    ],
    "//conditions:default": [
        "libtiff.so"
    ]
}),

static_libraries = select({
    "@bazel_tools//src/conditions:windows": [
        "tiff.lib"
    ],
    "//conditions:default": [

    ]
}),

# Windows only
generate_crosstool_file = True,
cmake_options = ["-GNinja"],
make_commands = [
   "ninja",
   "ninja install",
   "ls",
   "ls tiff",
   "ls tiff/bin",
   "ls tiff/lib"
],

visibility = ["//visibility:public"]
)
        """
    )
