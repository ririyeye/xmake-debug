set_project(test)
add_requires("local_libusb")

package("local_libusb")
    set_urls(path.join(os.scriptdir(), "libusb/libusb-1.0.26.tar.bz2"))
    add_versions("1.0.26", "12ce7a61fc9854d1d2a1ffe095f7b5fac19ddba095c259e6067a46500381b5a5")

    if is_plat("linux") then
        add_syslinks("pthread")
        add_includedirs("include", "include/libusb-1.0")    
    end

    if get_config('target_os') == "linux" and is_plat("cross") then
        add_syslinks("pthread")
        add_includedirs("include", "include/libusb-1.0")
    end

    on_install("cross" , "linux" ,function (package)
        local configs = {}

        table.insert(configs,"--enable-udev=false")
        table.insert(configs,"--disable-shared")

        import("package.tools.autoconf").install(package,configs)
    end)

    on_fetch("windows" , function (package)
        -- add dll
        local result = {}

        result.links = {"libusb-1.0"}
        result.includedirs = path.join(os.scriptdir() , "libusb" , "windows" , "libusb-1.0")
        if get_config("arch") == "x64" then 
            result.linkdirs = path.join(os.scriptdir() , "libusb" , "windows" , "x64")
        else
            result.linkdirs = path.join(os.scriptdir() , "libusb" , "windows" , "win32")
        end
        return result
    end)


target("test")
    set_kind("binary")
    add_files("a.cpp")
    add_files("b.cpp")
    add_packages("local_libusb")
