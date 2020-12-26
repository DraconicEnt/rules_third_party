load("//:graphviz.bzl", "run_graphviz")

exports_files(["pnglibconf.h"])

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
