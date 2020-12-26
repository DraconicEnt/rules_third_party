load("//:graphviz.bzl", "run_graphviz")

exports_files([
    "pnglibconf.h",
    "allegro.BUILD",
    "bullet.BUILD",
    "bzip2.BUILD",
    "curl.BUILD",
    "enet.BUILD",
    "freetype.BUILD",
    "graphviz.BUILD",
    "harfbuzz.BUILD",
    "iconv.BUILD",
    "irrlicht.BUILD",
    "jpeg.BUILD",
    "lzma.BUILD",
    "physfs.BUILD"
])

genquery(
    name = "irrlicht_dependencies_diagram",
    opts = [
        "--output",
        "graph"
    ],
    expression = "deps(@irrlicht//:irrlicht)",
    scope = ["@irrlicht//:irrlicht"],
)

run_graphviz(
    name = "irrlicht_dependency_diagram_png",
    input = ":irrlicht_dependencies_diagram",
    output = "irrlicht_dependencies.png"
)
