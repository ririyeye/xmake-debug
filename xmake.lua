set_project(test)

set_policy("build.optimization.lto", true)


target("test")
    set_kind("static")
    add_files("test.cpp")


target("main")
    set_kind("binary")
    add_files("main.cpp")
    add_deps("test")