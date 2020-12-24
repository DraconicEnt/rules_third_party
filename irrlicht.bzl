load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# load("//:png.bzl", "png")
# load("//:jpeg.bzl", "jpeg")
# load("//:bzip2.bzl", "bzip2")

def irrlicht():
    # Ensure dependencies are loaded.
#    png()
#    jpeg()
#    bzip2()

    maybe(
        http_archive,
        name = "irrlicht",
        patches = [
            "@third_party//:COSOperator.patch"
        ],
        urls = [
            "http://downloads.sourceforge.net/irrlicht/irrlicht-1.8.4.zip"
        ],
        sha256 = "f42b280bc608e545b820206fe2a999c55f290de5c7509a02bdbeeccc1bf9e433",

        build_file_content = """

filegroup(
    name = "irrlicht_includes",
    srcs = glob(
        include = [
            "irrlicht-1.8.4/include/**/*.h",
            "irrlicht-1.8.4/include/**/*.hpp",
            "irrlicht-1.8.4/source/Irrlicht/**/*.h",
            "irrlicht-1.8.4/source/Irrlicht/**/*.hpp",
        ]
    )
)

cc_library(
    name = "irrlicht",
    srcs = [
        ":irrlicht_includes"
    ] + glob(
        include = [
            "irrlicht-1.8.4/source/Irrlicht/*.c",
            "irrlicht-1.8.4/source/Irrlicht/*.cpp",

            # Use Irrlicht's LZMA for now
            "irrlicht-1.8.4/source/Irrlicht/lzma/*.c",
        ],
        exclude = [
            "irrlicht-1.8.4/source/Irrlicht/zlib/**/*",
            # "irrlicht-1.8.4/source/Irrlicht/bzip2/**/*",
            # "irrlicht-1.8.4/source/Irrlicht/libpng/**/*",

            # "irrlicht-1.8.4/source/Irrlicht/jpeglib/**/*",
            "irrlicht-1.8.4/source/Irrlicht/MacOSX/**/*"
        ]
    ),
    copts = [
        "-std=gnu++11"
    ],
    defines = [
        "NO_IRR_COMPILE_WITH_ZIP_ENCRYPTION_"
    ],
    hdrs = [
        ":irrlicht_includes"
    ],
    deps = [
        # "@png//:png",
        # "@jpeg//:jpeg",
        # "@bzip2//:bzip2"
    ],
    linkopts = [
        "-lGL",
        "-lXxf86vm",
        "-lX11"
    ],

    includes = [
        "irrlicht-1.8.4/include",
        "irrlicht-1.8.4/source/Irrlicht"
    ],
    visibility = ["//visibility:public"]
)
    """
    )
