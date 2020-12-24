load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def allegro():
    # Load Allegro
    maybe(
        new_git_repository,
        name = "allegro",
        remote = "https://github.com/liballeg/allegro5.git",
        # 5.2.6
        commit = "5e0db6b985eb2714fd276d8808b45f31ea6f52d9",
        shallow_since = "1581300180 -0800",
        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

cmake_external(
name = "allegro",
lib_source = "@allegro//:.",

generate_crosstool_file = select({
    "@bazel_tools//src/conditions:windows": True,
    "//conditions:default": False
}),

cmake_options = select({
   "@bazel_tools//src/conditions:windows": ["-GNinja"],
   "//conditions:default": None
}),

cache_entries = select({
    "@bazel_tools//src/conditions:windows": {
    #    "PHYSFS_INCLUDE_DIR": "$EXT_BUILD_DEPS/physfs/include",
#        "PHYSFS_LIBRARY": "$EXT_BUILD_DEPS/physfs/lib/physfs-static.lib",
    },

    "//conditions:default": {
        "PHYSFS_INCLUDE_DIR": "$EXT_BUILD_DEPS/include",
        "PHYSFS_LIBRARY": "$EXT_BUILD_DEPS/lib/libphysfs.a"
    }
}),

linkopts = [

],

make_commands = select({
    "@bazel_tools//src/conditions:windows": [
        "ninja",
        "ninja install"
    ],
    "//conditions:default": [
        "make -j$(nproc)",
        "make install"
    ]
}),

deps = [
    "@enet//:enet",
    "@zlib//:zlib",
    "@physfs//:physfs"
],

static_libraries = select({
    "@bazel_tools//src/conditions:windows": [
        "allegro_physfs.lib",
        "allegro_acodec.lib",
        "allegro_color.lib",
        # "allegro_ttf.lib",
        "allegro_font.lib",
        "allegro_image.lib",
        "allegro_main.lib",
        "allegro.lib",
        "allegro_audio.lib",
        "allegro_memfile.lib",
        "allegro_primitives.lib",
    ],

    "//conditions:default": []
}),

binaries = select({
    "@bazel_tools//src/conditions:windows": [
        "allegro-5.2.dll",
        "allegro_physfs-5.2.dll"
    ],

    "//conditions:default": [
    ]
}),

shared_libraries = select({
    "@bazel_tools//src/conditions:windows": [

    ],

    "//conditions:default": [
        "liballegro_physfs.so",
        "liballegro_physfs.so.5.2",
        "liballegro_acodec.so",
        "liballegro_acodec.so.5.2",
        "liballegro_color.so",
        "liballegro_color.so.5.2",
        "liballegro_ttf.so",
        "liballegro_ttf.so.5.2",
        "liballegro_font.so",
        "liballegro_font.so.5.2",
        "liballegro_image.so",
        "liballegro_image.so.5.2",
        "liballegro_main.so",
        "liballegro_main.so.5.2",
        "liballegro.so",
        "liballegro.so.5.2",
        "liballegro_audio.so",
        "liballegro_audio.so.5.2",
        "liballegro_memfile.so",
        "liballegro_memfile.so.5.2",
        "liballegro_primitives.so",
        "liballegro_primitives.so.5.2"
    ]
}),

visibility = ["//visibility:public"]
)
        """
    )
