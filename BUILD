load("@rules_pkg//:pkg.bzl", "pkg_tar")

exports_files(["test.cpp"])

filegroup(
    name = "mygui_tools",
    srcs = [
        "@mygui//:library"
    ],
    visibility = ["//visibility:public"]
)

pkg_tar(
    name = "mygui_tools_archive",
    srcs = [
        ":mygui_tools",
        "@mygui//:mygui_tools_data"
    ],
    deps = [
        "@mygui//:mygui_resources_archive"
    ]
)
