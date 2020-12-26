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
