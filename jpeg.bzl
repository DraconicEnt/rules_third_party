load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# Build config pulled from CMakeLists.txt


def jpeg():
    maybe(
        http_archive,
        name = "jpeg",
        url = "https://downloads.sourceforge.net/project/libjpeg/libjpeg/6b/jpegsrc.v6b.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flibjpeg%2Ffiles%2Flibjpeg%2F6b%2Fjpegsrc.v6b.tar.gz%2Fdownload&ts=1608785831",
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
            "jpeg-6b/*dos*"
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
