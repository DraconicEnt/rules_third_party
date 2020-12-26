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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def freetype():
    maybe(
        http_archive,
        name = "freetype",
        url = "https://download.savannah.gnu.org/releases/freetype/freetype-2.9.1.tar.gz",
        sha256 = "ec391504e55498adceb30baceebd147a6e963f636eb617424bcfc47a169898ce",
        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

cmake_external(
name = "freetype",
lib_source = "@freetype//:freetype-2.9.1",

static_libraries = select({
    "@bazel_tools//src/conditions:windows": [
        "freetype.lib"
    ],
    "//conditions:default": [
        "libfreetype.a"
    ]
}),

deps = [
   "@zlib//:zlib"
],

cache_entries = {
   "SKIP_INSTALL_HEADERS": "NO"
},

generate_crosstool_file = select({
    "@bazel_tools//src/conditions:windows": True,
    "//conditions:default": None
}),

cmake_options = select({
    "@bazel_tools//src/conditions:windows": ["-GNinja"],
    "//conditions:default": None
}),

make_commands = select({
   "@bazel_tools//src/conditions:windows": [
        "ninja",
        # Ninja install is broken
        "mkdir -p freetype/lib",
        "cp freetype.lib freetype/lib"
   ],
   "//conditions:default": [
       "make -j$(nproc)",
       "make install"
   ]
}),

visibility = ["//visibility:public"]
)
        """
    )
