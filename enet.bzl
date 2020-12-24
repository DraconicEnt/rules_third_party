load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def enet():
    # Load ENet
    maybe(
        http_archive,
        name = "enet",
        urls = [
            "https://github.com/lsalzman/enet/archive/v1.3.17.tar.gz"
        ],
        sha256 = "1e0b4bc0b7127a2d779dd7928f0b31830f5b3dcb7ec9588c5de70033e8d2434a",
        build_file_content = """
cc_library(
    name = "enet",
    srcs = glob(
        include = [
            "enet-1.3.17/*.c",
            "enet-1.3.17/*.h",
            "enet-1.3.17/include/enet/*.h"
        ]
    ),
    # NOTE: Autogen?
    defines = [
        "HAS_SOCKLEN_T=1"
    ],
    linkopts = select({
        "@bazel_tools//src/conditions:windows": [
            "Winmm.lib",
            "Ws2_32.lib"
        ],

        "//conditions:default": []
    }),
    alwayslink = True,
    hdrs = glob(
        include = [
            "enet-1.3.17/include/enet/*.h"
        ]
    ),
    includes = [
        "enet-1.3.17/include"
    ],
    visibility = ["//visibility:public"]
)
        """
    )
