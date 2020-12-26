
filegroup(
    name = "bzip2_headers",
    srcs = glob(
        include = [
            "*.h"
        ]
    )
)

cc_library(
    name = "bzip2",
    srcs = glob(
        include = [
            ":bzip2_headers",
            "blocksort.c",
            "huffman.c",
            "crctable.c",
            "randtable.c",
            "compress.c",
            "decompress.c",
            "bzlib.c"
        ]
    ),
    hdrs = [
        ":bzip2_headers"
    ],
    includes = [
        "."
    ],

    visibility = ["//visibility:public"]
)
