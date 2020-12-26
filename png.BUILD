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
