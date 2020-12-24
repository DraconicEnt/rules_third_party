load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def harfbuzz():
    maybe(
        new_git_repository,
        name = "harfbuzz",
        remote = "https://github.com/harfbuzz/harfbuzz.git",
        # Tag 2.7.2
        commit = "9c98b2b9a9e43669c5e2b37eaa41b1e07de1ede3",
        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

filegroup(
name = "harfbuzz_files",
srcs = glob(
    include=[
        "**/*"
    ]
)
)

cmake_external(
name = "harfbuzz",
lib_source = ":harfbuzz_files",

generate_crosstool_file = select({
    "@bazel_tools//src/conditions:windows": True,
    "//conditions:default": False
}),

cmake_options = select({
   "@bazel_tools//src/conditions:windows": ["-GNinja"],
   "//conditions:default": None
}),

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

static_libraries = select({
    "@bazel_tools//src/conditions:windows": [
        "harfbuzz.lib"
    ],

    # Linux
    "//conditions:default": [
        "libharfbuzz.a"
    ]
}),

visibility = ["//visibility:public"]
)
        """
    )
