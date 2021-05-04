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
    }),
    target_compatible_with = select({
        "@platforms//os:linux": [],
        "@platforms//os:windows": [],
        "//conditions:default": ["@platforms//:incompatible"]
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
    name = "zlib",
    srcs = [
        "zlib.c"
    ],
    deps = [
        "@zlib//:zlib"
    ]
)

cc_test(
    name = "bullet",
    srcs = [
        "bullet.cpp"
    ],
    deps = [
        "@bullet//:bullet"
    ]
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
        "curl.c"
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
    }),
    target_compatible_with = select({
        "@platforms//os:linux": [],
        "//conditions:default": ["@platforms//:incompatible"]
    })
)


test_suite(
    name = "test_all",
    tests = [
        ":curl",
        ":irrlicht",
        ":enet",
        ":zlib",
        ":physfs",
		":bullet"
    ]
)
