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
    name = "png_headers",
    srcs = [
        # Public Headers
        "libpng-1.6.37/pngstruct.h",
        "libpng-1.6.37/pnginfo.h",
        "libpng-1.6.37/pngdebug.h",

        # Private Headers
        "libpng-1.6.37/pngpriv.h",

        "@rules_third_party//:pnglibconf.h"
    ]
)

cc_library(
    name = "png",
    srcs = [
        ":png_headers",

        # Source Code - Intel Specific
        "libpng-1.6.37/intel/intel_init.c",
        "libpng-1.6.37/intel/filter_sse2_intrinsics.c",

        # Source Code
        "libpng-1.6.37/png.c",
        "libpng-1.6.37/pngerror.c",
        "libpng-1.6.37/pngget.c",
        "libpng-1.6.37/pngmem.c",
        "libpng-1.6.37/pngpread.c",
        "libpng-1.6.37/pngread.c",
        "libpng-1.6.37/pngrio.c",
        "libpng-1.6.37/pngrtran.c",
        "libpng-1.6.37/pngrutil.c",
        "libpng-1.6.37/pngset.c",
        "libpng-1.6.37/pngtrans.c",
        "libpng-1.6.37/pngwio.c",
        "libpng-1.6.37/pngwrite.c",
        "libpng-1.6.37/pngwtran.c",
        "libpng-1.6.37/pngwutil.c"
    ],
    hdrs = [
        ":png_headers"
    ],
    includes = [
        "libpng-1.6.37",
        "@rules_third_party//:"
    ],
    deps = [
        "@zlib//:zlib"
    ],

    visibility = ["//visibility:public"]
)
