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

cc_library(
    name = "lzma",
    srcs = glob(
        include = [
            "xz-5.2.5/src/liblzma/**/*.c",
            "xz-5.2.5/src/liblzma/**/*.h"
        ],
        exclude = [
            "xz-5.2.5/src/liblzma/check/**/*.c",
            "xz-5.2.5/src/liblzma/common/filter_encoder.c",
            #"xz-5.2.5/src/liblzma/common/filter_decoder.c",
            "xz-5.2.5/src/liblzma/common/stream_encoder_mt.c",
            "xz-5.2.5/src/liblzma/lzma/price_tablegen.c",
            "xz-5.2.5/src/liblzma/lzma/fastpos_tablegen.c"
        ]
    ),
    hdrs = glob(
        include = [
            "xz-5.2.5/src/**/*.h"
        ]
    ),
    includes = [
        "xz-5.2.5/src/common",
        "xz-5.2.5/src/liblzma/lz",
        "xz-5.2.5/src/liblzma/common",
        "xz-5.2.5/src/liblzma/api",
        "xz-5.2.5/src/liblzma/lzma",
        "xz-5.2.5/src/liblzma/delta",
        "xz-5.2.5/src/liblzma/check",
        "xz-5.2.5/src/liblzma/rangecoder",
        "xz-5.2.5/src/liblzma/simple"
    ],
    defines = [
        "HAVE_DECODER_X86",
        "HAVE_DECODER_LZMA1",
        "HAVE_INTTYPES_H=1",
        "HAVE_STDINT_H=1",
        "HAVE_STDBOOL_H=1"
    ],
    visibility = ["//visibility:public"]
)
