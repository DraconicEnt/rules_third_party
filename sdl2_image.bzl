load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def sdl2_image():
    # Load SDL2_Image
    maybe(
        http_archive,
        name = "sdl2_image",
        urls = [
            "https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.tar.gz"
        ],
        sha256 = "bdd5f6e026682f7d7e1be0b6051b209da2f402a2dd8bd1c4bd9c25ad263108d0",
        build_file_content = """
cc_library(
    name = "library",
    srcs = [
        # Headers
        "SDL2_image-2.0.5/SDL_image.h",

        # Source Code
        "SDL2_image-2.0.5/IMG_bmp.c",
        "SDL2_image-2.0.5/IMG_gif.c",
        "SDL2_image-2.0.5/IMG_jpg.c",
        "SDL2_image-2.0.5/IMG_lbm.c",
        "SDL2_image-2.0.5/IMG_pcx.c",
        "SDL2_image-2.0.5/IMG_png.c",
        "SDL2_image-2.0.5/IMG_pnm.c",
        "SDL2_image-2.0.5/IMG_svg.c",
        "SDL2_image-2.0.5/IMG_tga.c",
        "SDL2_image-2.0.5/IMG_tif.c",
        "SDL2_image-2.0.5/IMG_webp.c",
        "SDL2_image-2.0.5/IMG_WIC.c",
        "SDL2_image-2.0.5/IMG_xcf.c",
        "SDL2_image-2.0.5/IMG_xpm.c",
        "SDL2_image-2.0.5/IMG_xv.c",
        "SDL2_image-2.0.5/IMG_xxx.c",
        "SDL2_image-2.0.5/IMG.c"
    ],

    deps = [
        "@sdl2//:library",
        "@png//:png"
    ]
)
        """
    )
