option(CT_HARDENED "Should the standard library be hardened" OFF)
option(CT_SANITIZED "Should the build be sanitized" OFF)

function(ct_configure_compiler)

    set(isGCC OFF)
    set(isClang OFF)
    set(isMSVC OFF)

    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(isGCC ON)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set(isClang ON)
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        set(isMSVC ON)
    endif()

    set(compilerOptions "")
    set(compilerDefinitions "")
    set(linkerOptions "")

    if(isClang)
        list(APPEND compilerOptions -stdlib=libc++)
        list(APPEND linkerOptions -stdlib=libc++)
        message(STATUS "Using libc++ as a standard library")
    endif()

    if(CT_HARDENED)
        if(isGCC)
            list(APPEND compilerDefinitions _GLIBCXX_DEBUG)
            message(STATUS "Enabled debug mode for libstdc++")
        elseif(isClang)
            list(APPEND compilerDefinitions _LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_DEBUG)
            message(STATUS "Enabled hardening mode for libc++")
        else()
            # TODO: https://github.com/microsoft/STL/wiki/STL-Hardening
            message(STATUS "Hardening is not supported for CXX compiler: '${COMPILER_ID}'")
        endif()
    endif()

    if(CT_SANITIZED)
        if(isGCC OR isClang)
            list(APPEND compilerOptions -fsanitize=undefined,address)
            list(APPEND linkerOptions -fsanitize=undefined,address)
            list(APPEND compilerOptions
                -fno-sanitize-recover=all
                -fno-optimize-sibling-calls
                -fno-omit-frame-pointer
            )
            message(STATUS "Enabled UBSan and ASan")
        elseif(isMSVC)
            list(APPEND compilerOptions /fsanitize=address)
            message(STATUS "Enabled ASan")
        else()
            message(WARNING "Sanitized builds are not supported for CXX compiler: '${COMPILER_ID}'")
        endif()
    endif()

    message(STATUS "Setting global compiler options: ${compilerOptions}")
    message(STATUS "Setting global compiler definitions: ${compilerDefinitions}")
    message(STATUS "Setting global linker options: ${linkerOptions}")

    add_compile_options(${compilerOptions})
    add_compile_definitions(${compilerDefinitions})
    add_link_options(${linkerOptions})

endfunction()
