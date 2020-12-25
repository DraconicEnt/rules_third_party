load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

load("//:zlib.bzl", "zlib")

def png():
    # Ensure dependencies are loaded
    zlib()

    maybe(
        http_archive,
        name = "png",
        sha256 = "505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca",
        url = "https://downloads.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.xz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flibpng%2Ffiles%2Flibpng16%2F1.6.37%2Flibpng-1.6.37.tar.xz%2Fdownload&ts=1607941742",
        build_file_content = """

filegroup(
    name = "png_headers",
    srcs = [
        # Public Headers
        "libpng-1.6.37/pngstruct.h",
        "libpng-1.6.37/pnginfo.h",
        "libpng-1.6.37/pngdebug.h",

        # Private Headers
        "libpng-1.6.37/pngpriv.h",

        "@third_party//:pnglibconf.h"
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
        "@third_party//:"
    ],
    deps = [
        "@zlib//:zlib"
    ],

    visibility = ["//visibility:public"]
)
        """
    )