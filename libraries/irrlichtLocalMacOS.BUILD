cc_library(
    name = "irrlicht_headers",

    #srcs = glob(["include/*.h"]),
    hdrs = glob(["include/irrlicht/*.h"]),
    includes = ["include/irrlicht"],
    visibility = ["//visibility:public"],
)

cc_import(
    name = "irrlicht_lib",

    static_library = "lib/libIrrlicht.a",
    visibility = ["//visibility:public"]
)

cc_library(
    name = "irrlicht",
    deps = [
         "irrlicht_headers",
         "irrlicht_lib"
    ],
    visibility = ["//visibility:public"],
)
