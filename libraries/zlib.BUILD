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

filegroup(
    name = "zlib_headers",
    srcs = [
        # Public Headers
        "zlib-1.2.11/zconf.h",
        "zlib-1.2.11/zlib.h",

        # Private Headers
        "zlib-1.2.11/crc32.h",
        "zlib-1.2.11/deflate.h",
        "zlib-1.2.11/gzguts.h",
        "zlib-1.2.11/inffast.h",
        "zlib-1.2.11/inffixed.h",
        "zlib-1.2.11/inflate.h",
        "zlib-1.2.11/inftrees.h",
        "zlib-1.2.11/trees.h",
        "zlib-1.2.11/zutil.h",
    ]
)

cc_library(
    name = "zlib",
    srcs = [
        ":zlib_headers",

        # Source Code
        "zlib-1.2.11/adler32.c",
        "zlib-1.2.11/compress.c",
        "zlib-1.2.11/crc32.c",
        "zlib-1.2.11/deflate.c",
        "zlib-1.2.11/gzclose.c",
        "zlib-1.2.11/gzlib.c",
        "zlib-1.2.11/gzread.c",
        "zlib-1.2.11/gzwrite.c",
        "zlib-1.2.11/inflate.c",
        "zlib-1.2.11/infback.c",
        "zlib-1.2.11/inftrees.c",
        "zlib-1.2.11/inffast.c",
        "zlib-1.2.11/trees.c",
        "zlib-1.2.11/uncompr.c",
        "zlib-1.2.11/zutil.c"
    ],
    hdrs = [
        ":zlib_headers"
    ],
    includes = [
        "zlib-1.2.11"
    ],
    copts = select({
        "@bazel_tools//src/conditions:windows": [

        ],

        "//conditions:default": [
            "-Wno-implicit-function-declaration"
        ]
    }),

    visibility = ["//visibility:public"]
)
