"""
    Copyright 2020 Robert MacGregor

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

def osg():
    # Load OpenSceneGraph
    maybe(
        new_git_repository,
        name = "osg",
        remote = "https://github.com/openscenegraph/OpenSceneGraph.git",
        # Tag 3.6.5
        commit = "a827840baf0786d72e11ac16d5338a4ee25779db",
        shallow_since = "1580468587 +0000",
        build_file_content = """
load("@rules_foreign_cc//foreign_cc:defs.bzl", "cmake")

filegroup(
    name = "osg_sources",
    srcs = glob(
        include = [
            "**/*"
        ]
    )
)

cmake(
name = "osg",
lib_source = ":osg_sources",

# DCMTK_DIR
cache_entries = select({
    "@bazel_tools//src/conditions:windows": {
    #    "FREETYPE_LIBRARY": "$EXT_BUILD_DEPS/freetype/lib/freetype.lib",
#        "FREETYPE_INCLUDE_DIRS": "$EXT_BUILD_DEPS/freetype/include",
        "BUILD_PRESENT3D_WITH_SDL": "OFF",
        "LIBXML2_LIBRARY": "$EXT_BUILD_DEPS/xml2/lib/libxml2.lib",
        "LIBXML2_INCLUDE_DIR": "$EXT_BUILD_DEPS/xml2/include",
        "_OPENTHREADS_ATOMIC_USE_WIN32_INTERLOCKED_EXITCODE": "0",
        "_OPENTHREADS_ATOMIC_USE_WIN32_INTERLOCKED_EXITCODE__TRYRUN_OUTPUT": "0"
    },
    "//conditions:default": {
        "LUA_LIBRARIES": "OFF",
        "BUILD_PRESENT3D_WITH_SDL": "OFF",
        "LIBXML2_LIBRARY": "$EXT_BUILD_DEPS/xml2/lib/libxml2.so",
        "LIBXML2_INCLUDE_DIR": "$EXT_BUILD_DEPS/xml2/include/libxml2",
        #"FREETYPE_LIBRARY": "$EXT_BUILD_DEPS/freetype/lib/libfreetype.a",
        #"FREETYPE_INCLUDE_DIRS": "$EXT_BUILD_DEPS/freetype/include",
    }
}),

deps = [
    "@xml2//:xml2",
    "@zlib//:zlib",
    # "@curl//:curl",
    #"@freetype//:freetype"
],

out_static_libs = select({
    "@bazel_tools//src/conditions:windows": [
        "osgUI.lib",
        "osgParticle.lib",
        "osgGA.lib",
        "osgManipulator.lib",
        "osgShadow.lib",
        "osgWidget.lib",
        "osgPresentation.lib",
        "osgText.lib",
        "osgFX.lib",
        "osgTerrain.lib",
        "osgViewer.lib",
        "OpenThreads.lib",
        "osgVolume.lib",
        "osgUtil.lib",
        "osgSim.lib",
        "osgAnimation.lib",
        "osgDB.lib",
        "osg.lib"
    ],

    "//conditions:default": []
}),

out_binaries = select({
    "@bazel_tools//src/conditions:windows": [
        "osg161-osg.dll",
        "osg161-osgViewer.dll",
        "ot21-OpenThreads.dll",
        "osg161-osgText.dll",
        "osg161-osgUtil.dll",
        "osg161-osgGA.dll",
        "osg161-osgDB.dll"
    ],

    # Linux
    "//conditions:default": [
    ]
}),

out_shared_libs = select({
    "@bazel_tools//src/conditions:windows": [

    ],

    # Linux
    "//conditions:default":[
        "libosgUI.so",
        "libosgParticle.so",
        "libosgGA.so",
        "libosgManipulator.so",
        "libosgShadow.so",
        "libosgWidget.so",
        "libosgPresentation.so",
        "libosgText.so",
        "libosgFX.so",
        "libosgTerrain.so",
        "libosgViewer.so",
        "libOpenThreads.so",
        "libosgVolume.so",
        "libosgUtil.so",
        "libosgSim.so",
        "libosgAnimation.so",
        "libosgDB.so",
        "libosg.so",

        "libosgUI.so.161",
        "libosgParticle.so.161",
        "libosgGA.so.161",
        "libosgManipulator.so.161",
        "libosgShadow.so.161",
        "libosgWidget.so.161",
        "libosgPresentation.so.161",
        "libosgText.so.161",
        "libosgFX.so.161",
        "libosgTerrain.so.161",
        "libosgViewer.so.161",
        "libOpenThreads.so.21",
        "libosgVolume.so.161",
        "libosgUtil.so.161",
        "libosgSim.so.161",
        "libosgAnimation.so.161",
        "libosgDB.so.161",
        "libosg.so.161"
    ]
}),

generate_crosstool_file = select({
    "@bazel_tools//src/conditions:windows": True,
    "//conditions:default": False
}),

generate_args = select({
   "@bazel_tools//src/conditions:windows": ["-GNinja"],
   "//conditions:default": None
}),

visibility = ["//visibility:public"]
)
    """
    )
