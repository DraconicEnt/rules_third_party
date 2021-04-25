load("@rules_third_party//libraries:irrlicht.bzl", "select_irrlicht")

cc_test(
    name = "irrlicht",
    srcs = [
        "irrlicht.cpp"
    ],
    deps = [
        "@irrlicht//:irrlicht"
    ],
    linkopts =  select({
        "@bazel_tools//src/conditions:windows": [],
        "@bazel_tools//src/conditions:darwin": [
            "-framework", "Foundation",
            "-framework", "AppKit",
            "-framework", "OpenGL",
            "-framework", "IOKit"
        ],
        "//conditions:default": [
            "-lGL",
            "-lX11",
            "-lXxf86vm"
        ],
    })
)

cc_test(
    name = "physfs",
    srcs = [
        "physfs.cpp"
    ],
    deps = [
        "@physfs//:physfs"
    ],
    linkopts =  select({
        "@bazel_tools//src/conditions:windows": [
            "User32.lib",
            "Advapi32.lib",
            "Shell32.lib"
        ],
        "@bazel_tools//src/conditions:darwin": [
            "-framework", "Foundation",
            "-framework", "AppKit",
            "-framework", "IOKit"
        ],
        "//conditions:default": [

        ],
    })
)

cc_test(
    name = "enet",
    srcs = [
        "enet.cpp"
    ],
    deps = [
        "@enet//:enet"
    ],
    linkopts =  select({
        "@bazel_tools//src/conditions:windows": [
            "User32.lib",
            "Advapi32.lib",
            "Shell32.lib"
        ],
        "@bazel_tools//src/conditions:darwin": [
            "-framework", "Foundation",
            "-framework", "AppKit",
            "-framework", "IOKit"
        ],
        "//conditions:default": [

        ],
    })
)

cc_test(
    name = "curl",
    srcs = [
        "curl.cpp"
    ],
    deps = [
        "@curl//:curl"
    ],
    linkopts =  select({
        "@bazel_tools//src/conditions:windows": [
            "User32.lib",
            "Advapi32.lib",
            "Shell32.lib"
        ],
        "@bazel_tools//src/conditions:darwin": [
            "-framework", "Foundation",
            "-framework", "AppKit",
            "-framework", "IOKit"
        ],
        "//conditions:default": [

        ],
    })
)
