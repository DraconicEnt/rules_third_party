load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# Build config pulled from CMakeLists.txt


def jpeg():
    maybe(
        http_archive,
        name = "jpeg",
        sha256 = "75c3ec241e9996504fe02a9ed4d12f16b74ade713972f3db9e65ce95cd27e35d",
        url = "https://cfhcable.dl.sourceforge.net/project/libjpeg/libjpeg/6b/jpegsrc.v6b.tar.gz",
        build_file_content = """

filegroup(
    name = "jpeg_headers",
    srcs = glob(
        include = [
            "jpeg-6b/*.h"
        ]
    )
)
cc_library(
    name = "jpeg",
    srcs = glob(
        include = [
            "jpeg-6b/*.c",
            ":jpeg_headers"
        ],
        exclude = [
            "jpeg-6b/*mac*",
            "jpeg-6b/*dos*",
            "jpeg-6b/jpegtran.c",
            "jpeg-6b/rdjpgcom.c",
            "jpeg-6b/wrjpgcom.c",
            "jpeg-6b/cjpeg.c",
            "jpeg-6b/jmemname.c",
            "jpeg-6b/jmemnobs.c",
            "jpeg-6b/ckconfi.c",
            "jpeg-6b/ansi2knr.c",
            "jpeg-6b/djpeg.c"
        ]
    ),
    hdrs = [
        ":jpeg_headers"
    ],
    includes = [
        "jpeg-6b"
    ],

    visibility = ["//visibility:public"]
)
"""
    )
