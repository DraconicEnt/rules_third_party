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

# Renderer configuration
config_setting(
    name = "no_renderer_direct3d8",
    define_values = {
        "irrlicht_d3d8": "disabled",
    }
)

config_setting(
    name = "no_renderer_direct3d9",
    define_values = {
        "irrlicht_d3d9": "disabled",
    }
)

config_setting(
    name = "no_renderer_opengl",
    define_values = {
        "irrlicht_opengl": "disabled",
    }
)

config_setting(
    name = "no_renderer_software",
    define_values = {
        "irrlicht_software": "disabled",
    }
)

config_setting(
    name = "no_renderer_burnings",
    define_values = {
        "irrlicht_burnings": "disabled",
    }
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
    copts = select({
       "@bazel_tools//src/conditions:windows": [

       ],
       "//conditions:default": [
            "-std=gnu++11"
        ],
    }),

    defines = [
        "IRRLICHT_EXPORTS=1",
        "NO_IRR_COMPILE_WITH_ZIP_ENCRYPTION_"
    # Handle D3D8
    ] + select({
         "//conditions:default": [],
        ":no_renderer_direct3d8": ["NO_IRR_COMPILE_WITH_DIRECT3D_8_"]
    # Handle D3D9
    }) + select({
        "//conditions:default": [],
        ":no_renderer_direct3d9": ["NO_IRR_COMPILE_WITH_DIRECT3D_9_"]
    # Handle OpenGL
    }) + select({
        "//conditions:default": [],
        ":no_renderer_opengl": ["NO_IRR_COMPILE_WITH_OPENGL_"]
    # Handle software
    }) + select({
        "//conditions:default": [],
        ":no_renderer_software": ["NO_IRR_COMPILE_WITH_SOFTWARE_"]
    # Handle burnings
    }) + select({
        "//conditions:default": [],
        ":no_renderer_burnings": ["NO_IRR_COMPILE_WITH_BURNINGSVIDEO_"]
    # Platform specific defines
    }) + select({
        "@bazel_tools//src/conditions:windows": [
            "_WIN64",
            "WIN64",
            "_WINDOWS",
            "_MBCS",
            "_USRDLL"
        ],
        "//conditions:default": [

        ]
    }),

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
