load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

filegroup(
name = "bullet_files",
srcs = glob(
    include=[
        "**/*"
    ]
)
)
# export VS160COMNTOOLS="/c/Program Files (x86)/Microsoft Visual Studio/2019/Community/Common7/Tools"
cmake_external(
name = "bullet",
lib_source = ":bullet_files",

# make_commands = [
#   "make -j$(nproc)",
 #  "make install",
#],
cache_entries = {
  "BUILD_BULLET3": "ON",
  "USE_MSVC_RUNTIME_LIBRARY_DLL": "ON",
  "BUILD_PYBULLET": "OFF",
  "BUILD_EXTRAS": "OFF",
  "BUILD_EGL": "OFF",
  # Force built libs to be installed
  "INSTALL_LIBS": "ON",
  "BUILD_UNIT_TESTS": "OFF",
  "BUILD_OPENGL3_DEMOS": "OFF",
  "BUILD_BULLET2_DEMOS": "OFF"
},

# Windows only

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
       "make install"
   ]
}),

static_libraries = select({
    "@bazel_tools//src/conditions:windows": [
        "BulletDynamics.lib",
        "BulletCollision.lib",
        "Bullet3Collision.lib",
        "LinearMath.lib",
        "Bullet3Common.lib",
    ],

    # Linux
    "//conditions:default": [
        "libBulletDynamics.a",
        "libBulletCollision.a",
        "libBullet3Collision.a",
        "libLinearMath.a",
        "libBullet3Common.a",
    ]
}),

visibility = ["//visibility:public"]
)