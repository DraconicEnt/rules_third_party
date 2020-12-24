load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def doxygen():
    maybe(
        new_git_repository,
        name = "doxygen",
        remote = "https://github.com/doxygen/doxygen.git",
        # Tag Release_1_8_20
        commit = "f246dd2f1c58eea39ea3f50c108019e4d4137bd5",
        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

filegroup(
name = "doxygen_files",
srcs = glob(
    include=[
        "**/*"
    ]
)
)

cmake_external(
name = "doxygen",
lib_source = ":doxygen_files",

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

binaries = select({
    "@bazel_tools//src/conditions:windows": [
        "doxygen.exe"
    ],

    # Linux
    "//conditions:default": [
        "doxygen"
    ]
}),

visibility = ["//visibility:public"]
)
        """
    )
