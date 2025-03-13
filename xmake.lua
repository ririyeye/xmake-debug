set_project(test)

set_toolchains("arm-none-eabi")

toolchain("arm-none-eabi")
    set_kind("standalone")
    if is_host("windows") then
        set_sdkdir("E:\\work\\xpack-arm-none-eabi-gcc-14.2.1-1.1\\")
    else
        set_sdkdir("/home/wangyang/toolchain/xpack-arm-none-eabi-gcc-14.2.1-1.1")
    end
    add_links(
        "stdc++",
        "supc++"
    )

    local mcu = { "-mcpu=cortex-m4", "-mfpu=fpv4-sp-d16", "-mfloat-abi=hard", "-mthumb" }
    table.join2(mcu, { "-fdata-sections", "-ffunction-sections" })

    add_defines("USE_STDPERIPH_DRIVER", "GD32E11X", "USE_USB_FS")

    add_cxflags(
        mcu,
        { force = true }
    )

    add_asflags(
        mcu,
        "-x assembler-with-cpp",
        { force = true }
    )

    add_ldflags(
        mcu,
        "--specs=nano.specs",
        "-Wl,--undefined=_exit -Wl,--defsym=_exit=0",
        "-Wl,--gc-sections",
        -- "-u _printf_float",
        { force = true }
    )
toolchain_end()

includes("@builtin/check")

target("test")

    configvar_check_sizeof("MD5_DAT_LEN", "int")

    -- on_config(function (target)
    --     local len = target:check_sizeof("int")
    --     target:add("defines", "MD5_DAT_LEN=" .. len)
    -- end)


    set_kind("binary")
    add_files("a.cpp")
    add_files("b.cpp")
    add_files("syscalls.c")
    add_packages("local_libusb")
