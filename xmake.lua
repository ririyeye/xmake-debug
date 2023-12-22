set_project(test)
add_requires("local_libusb")

package("local_libusb")
    set_urls(path.join(os.scriptdir(), "libusb-1.0.26.tar.bz2"))
    add_versions("v1.0.26", "12ce7a61fc9854d1d2a1ffe095f7b5fac19ddba095c259e6067a46500381b5a5")

    -- add_resources("v1.0.26", "libusb-cmake", "https://github.com/libusb/libusb-cmake.git", "84fb1bba4dde4c266944e7c7aa641a8a15d18f31")
    add_resources("v1.0.26", "libusb-cmake", path.join(os.scriptdir(), "libusb-cmake.tar"), "86696181e290301f9937ec31e147746599eea97855d283f615d47a429fb55365")

    if is_plat("macosx") then
        add_frameworks("CoreFoundation", "IOKit", "Security")
        add_extsources("brew::libusb")
    elseif is_plat("bsd") then
        add_syslinks("pthread")
    elseif is_plat("linux") then
        add_deps("eudev")
        add_syslinks("pthread")
        add_extsources("apt::libusb-dev", "pacman::libusb")
    elseif is_plat("mingw") and is_subhost("msys") then
        add_extsources("pacman::libusb")
    end

    add_deps("cmake")

    add_includedirs("include", "include/libusb-1.0")

    on_install("windows", "linux", "macosx", "bsd", "msys", "android" , "cross", function (package)
        local dir = package:resourcefile("libusb-cmake")
        os.cp(path.join(dir, "CMakeLists.txt"), os.curdir())
        os.cp(path.join(dir, "config.h.in"), os.curdir())
        io.replace("CMakeLists.txt",
            [[get_filename_component(LIBUSB_ROOT "libusb/libusb" ABSOLUTE)]],
            [[get_filename_component(LIBUSB_ROOT "libusb" ABSOLUTE)]], {plain = true})

        local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))

        local packagedeps = {}
        if package:is_plat("linux") then
            table.insert(packagedeps, "eudev")
        end
        import("package.tools.cmake").install(package, configs, {packagedeps = packagedeps})
    end)

    on_test(function (package)
        assert(package:has_cfuncs("libusb_init", {includes = "libusb-1.0/libusb.h"}))
    end)



target("test")
    set_kind("binary")
    add_files("a.cpp")
    add_files("b.cpp")
    add_packages("local_libusb")
