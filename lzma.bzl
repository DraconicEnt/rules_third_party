load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def lzma():
    maybe(
        http_archive,
        name = "lzma",
        url = "https://downloads.sourceforge.net/project/lzmautils/xz-5.2.5.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flzmautils%2Ffiles%2Fxz-5.2.5.tar.gz%2Fdownload&ts=1608267662",

        build_file_content = """
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
        "HAVE_INTTYPES_H=1",
        "HAVE_STDINT_H=1",
        "HAVE_STDBOOL_H=1"
    ],
    visibility = ["//visibility:public"]
)
        """
    )
