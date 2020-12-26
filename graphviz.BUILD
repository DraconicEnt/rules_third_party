load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

filegroup(
name = "graphviz_files",
srcs = glob(
    include=[
        "**/*"
    ]
)
)

cmake_external(
name = "graphviz",
lib_source = ":graphviz_files",

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
       "cp plugin/core/*.so* graphviz/lib",
       "cp plugin/pango/*.so* graphviz/lib",
       "cp plugin/gd/*.so* graphviz/lib",
       "cp plugin/dot_layout/*.so* graphviz/lib",
       "cp plugin/neato_layout/*.so* graphviz/lib"
   ]
}),

shared_libraries = select({
    "@bazel_tools//src/conditions:windows": [

    ],

    # Linux
    "//conditions:default": [
        "libcdt.so",
        "libcdt.so.5",

        "libxdot.so.4.0.0",
        "libxdot.so",
        "libxdot.so.4",

        "libpathplan.so.4.0.0",
        "libpathplan.so",
        "libpathplan.so.4",
        "libcdt.so.5.0.0",

        "libcgraph.so.6",
        "libcgraph.so",
        "libcgraph.so.6.0.0",

        "libgvc.so",
        "libgvc.so.6",
        "libgvc.so.6.0.0",

        # Plugins
        "libgvplugin_pango.so",
        "libgvplugin_pango.so.6",
        "libgvplugin_pango.so.6.0.0",

        "libgvplugin_dot_layout.so",
        "libgvplugin_dot_layout.so.6",
        "libgvplugin_dot_layout.so.6.0.0",

        "libgvplugin_gd.so.6",
        "libgvplugin_gd.so.6.0.0",
        "libgvplugin_gd.so",

        "libgvplugin_core.so",
        "libgvplugin_core.so.6",
        "libgvplugin_core.so.6.0.0",

        "libgvplugin_neato_layout.so",
        "libgvplugin_neato_layout.so.6",
        "libgvplugin_neato_layout.so.6.0.0"
    ]
}),

binaries = select({
    "@bazel_tools//src/conditions:windows": [
        "dot.exe"
    ],

    # Linux
    "//conditions:default": [
        "dot"
    ]
}),

cache_entries = select({
    "@bazel_tools//src/conditions:windows": {
        "BISON_EXECUTABLE": "$EXT_BUILD_DEPS/bison_windows/bin/bison_windows.exe",
        "FLEX_EXECUTABLE": "$EXT_BUILD_DEPS/bison_windows/bin/flex_windows.exe"
    },

    # Linux
    "//conditions:default": {
        "CMAKE_CXX_FLAGS": "-I $EXT_BUILD_DEPS/harfbuzz/include/harfbuzz",
        "CMAKE_C_FLAGS": "-I $EXT_BUILD_DEPS/harfbuzz/include/harfbuzz",
        "BISON_EXECUTABLE": "$EXT_BUILD_DEPS/bison_linux/bin/bison"
    }
}),

deps = [
    "@zlib//:zlib",
    "@harfbuzz//:harfbuzz"
] + select({
    "@bazel_tools//src/conditions:windows": ["@bison_windows//:bison_windows", "@bison_windows//:flex_windows"],
    "//conditions:default": ["@bison_linux//:bison_linux"]
}),

visibility = ["//visibility:public"]
)
