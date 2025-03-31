set_project(test)
add_rules("plugin.compile_commands.autoupdate", {outputdir = "."})


includes("@builtin/check")
check_macros("__STDC_FORMAT_MACROS" ,"PRId64" ,{ include = "inttypes.h" , defined = false})
-- check_macros("__STDC_FORMAT_MACROS" ,"PRId64" ,{ include = "inttypes.h" })
target("test")
    set_kind("binary")
    add_files("a.cpp")
    add_files("b.cpp")
