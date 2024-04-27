set_project(test)
add_requires("local_libusb")

set_policy("build.optimization.lto", true)

package("local_libusb")
    set_urls(path.join(os.scriptdir(), "libusb-cmake.7z"))
    add_versions("1.0.26", "49931bf30b8b825dcab86d9ebf37ea330d83ac3904d42f8954ae703d1f0ddccf")

    if get_config('target_os') == "linux" and is_plat("cross") then
        add_syslinks("pthread")
        add_includedirs("include", "include/libusb-1.0")
    end

    if is_plat('android') then
        add_includedirs("include", "include/libusb-1.0")
    end

    on_install("cross" , "linux" ,"android" ,"windows" ,function (package)
        local configs = {}

        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=OFF")
        table.insert(configs, "-DLIBUSB_ENABLE_UDEV=OFF")

        import("package.tools.cmake").install(package,configs)
    end)

target("test")
    set_kind("static")
    add_files("test.cpp")


target("main")
    set_kind("binary")
    add_files("main.cpp")
    add_deps("test")
    add_packages("local_libusb")