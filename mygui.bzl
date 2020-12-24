load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def mygui():
    # Load MyGUI
    maybe(
        new_git_repository,
        name = "mygui",
        remote = "https://github.com/MyGUI/mygui.git",
        commit = "42594b05f87f9cfa6ade9fe4c296ec49b2c9982e", # Tag MyGUI3.4.0
        shallow_since = "1581378518 +0300",
        build_file_content = """
load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

filegroup(
    name = "mygui_tools_data",
    srcs = glob(
        include = [
            "Media/**/*"
        ]
    ),
    visibility = ["//visibility:public"]
)

pkg_tar(
    name = "mygui_tools_data_archive",
    srcs = [
        ":mygui_tools_data"
    ],
    strip_prefix = "/external/mygui/Media",
    package_dir = "Media"
)

genrule(
    name = "mygui_resources_xml",
    cmd = "\\n".join([
        "echo '<?xml version=\\"1.0\\" encoding=\\"UTF-8\\"?>' > $@",
        "echo '<Paths>' >> $@",
        "echo '<Path root=\\"true\\">Media</Path>' >> $@",
        "echo '<Path>Media/MyGUI_Media</Path>' >> $@",
        "echo '</Paths>' >> $@"
    ]),
    outs = [
        "resources.xml"
    ]
)

pkg_tar(
    name = "mygui_resources_archive",
    srcs = [
        ":mygui_resources_xml"
    ],
    deps = [
        ":mygui_tools_data_archive"
    ],
    visibility = ["//visibility:public"]
)

filegroup(
    name = "mygui_tools",
    srcs = [
        ":library"
    ],
    visibility = ["//visibility:public"]
)

pkg_tar(
    name = "mygui_tools_archive",
    srcs = [
        ":mygui_tools",
        ":mygui_tools_data"
    ],
    deps = [
        ":mygui_resources_archive"
    ]
)


cmake_external(
    name = "library",
    lib_source = "@mygui//:.",

    deps = [
        "@freetype//:freetype"
    ],

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
            "make install",
            "mkdir -p library/bin",
            "cp bin/LayoutEditor library/bin",
            "cp bin/SkinEditor library/bin",
            "cp bin/ImageEditor library/bin",
            "cp bin/FontEditor library/bin"
        ]
    }),

    cache_entries = {
        "FREETYPE_DIR": "$EXT_BUILD_DEPS/freetype",
        "MYGUI_INSTALL_DOCS": "FALSE",
        "MYGUI_BUILD_DEMOS": "FALSE",
        "MYGUI_BUILD_TOOLS": "ON",
        "MYGUI_BUILD_UNITTESTS": "FALSE",
        "MYGUI_BUILD_TEST_APP": "FALSE",
        "MYGUI_RENDERSYSTEM": "7"
    },

    binaries = [
        "LayoutEditor",
        "SkinEditor",
        "ImageEditor",
        "FontEditor"
    ],

 #  static_libraries = [
  #     "libCommon.a",
  #     "libMyGUI.OpenGL3Platform.a"
  # ],

    shared_libraries = [
        "libMyGUIEngine.so",
        "libEditorFramework.so"
    ],
    visibility = ["//visibility:public"]
)
        """
    )
