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

load("@rules_foreign_cc//foreign_cc:defs.bzl", "cmake")

filegroup(
    name = "xml2_files",
    srcs = glob(
        include=[
            "**/*"
    ])
)

cmake(
    name = "xml2",
    lib_source = ":xml2_files",

    cache_entries = {
        "LIBXML2_WITH_LZMA": "OFF",
        "LIBXML2_WITH_PYTHON": "OFF",
        "LIBXML2_WITH_ICONV": "OFF",
        "Iconv_LIBRARY": "$EXT_BUILD_DEPS/iconv/lib/iconv.lib",
        "Iconv_INCLUDE_DIR": "$EXT_BUILD_DEPS/iconv/include"
    },

    # Windows only
    generate_crosstool_file = select({
        "@bazel_tools//src/conditions:windows": True,
        "//conditions:default": False
    }),

    cmake_options = select({
       "@bazel_tools//src/conditions:windows": ["-GNinja"],
       "//conditions:default": None
    }),

    deps = [
        "@zlib//:zlib"
    ],

    out_shared_libs = select({
        "@bazel_tools//src/conditions:windows": [],
        "@bazel_tools//src/conditions:darwin": [
            "libxml2.dylib",
            "libxml2.2.9.10.dylib"
        ],
        "//conditions:default": [
            "libxml2.so",
            "libxml2.so.2.9.10"
        ]
    }),

    out_static_libs = select({
        "@bazel_tools//src/conditions:windows": ["libxml2.lib"],
        "//conditions:default": []
    }),

    visibility = ["//visibility:public"]
)
