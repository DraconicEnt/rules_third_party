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
