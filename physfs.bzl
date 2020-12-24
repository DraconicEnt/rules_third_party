load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def physfs():
    # PhysicsFS
    maybe(
        http_archive,
        name = "physfs",
        urls = [
            "https://www.icculus.org/physfs/downloads/physfs-3.0.2.tar.bz2"
        ],
        sha256 = "304df76206d633df5360e738b138c94e82ccf086e50ba84f456d3f8432f9f863",
        build_file_content = """
cc_library(
    name = "physfs",
    srcs = glob(
        include = [
            "physfs-3.0.2/src/*.c",
            "physfs-3.0.2/src/*.h",
        ]
    ),
    defines = [
        "PHYSFS_SUPPORTS_ZIP=1"
    ],
    hdrs = glob(
        include = [
            "physfs-3.0.2/src/*.h",
        ]
    ),
    includes = [
        "physfs-3.0.2/src"
    ],
    linkopts = select({
        "@bazel_tools//src/conditions:windows": [
            "Advapi32.lib",
            "User32.lib",
            "Shell32.lib"
        ],

        "//conditions:default": []
    }),
    visibility = ["//visibility:public"]
)
        """
    )
