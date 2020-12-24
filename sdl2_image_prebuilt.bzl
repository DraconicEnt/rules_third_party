load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def sdl2_image_prebuilt():
    # Load SDL2 Image prebuilt
    maybe(
        http_archive,
        name = "sdl2_image_prebuilt",
        url = "https://www.libsdl.org/projects/SDL_image/release/SDL2_image-devel-2.0.5-VC.zip",
        build_file_content = """
cc_import(
name = "sdl2_image_prebuilt",
hdrs = [
    "SDL2_image-2.0.5/include/SDL_image.h"
],
static_library = "SDL2_image-2.0.5/lib/x64/SDL2_image.lib",
visibility = ["//visibility:public"]
)
        """
    )
