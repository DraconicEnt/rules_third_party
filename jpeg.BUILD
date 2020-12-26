
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
