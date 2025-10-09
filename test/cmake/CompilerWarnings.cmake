option(CT_TREAT_WARNINGS_AS_ERRORS "Treat warnings as errors" OFF)

function(ct_set_compiler_warnings TARGET)

    set(GCC_CLANG_COMMON_WARNINGS
        -Wall -Wextra # baseline reasonable and standard warnings
        -Wno-self-move # don't warn on self-move because it's often used in tests
        -pedantic # warn on language extensions
        -Wold-style-cast # warn on use of C-style casts
        -Wextra-semi # warn about redundant semicolons
        -Woverloaded-virtual # warn on overloading (not overriding) a virtual function
        -Wzero-as-null-pointer-constant # warn on using literal '0' as a pointer
        # -Wnull-dereference # warn if nullptr dereference is detected (disabled, might cause false-positives)
  )

    set(GCC_WARNINGS
        ${GCC_CLANG_COMMON_WARNINGS}
        -Wimplicit-fallthrough=5 # warn if a switch case falls through without a [[fallthrough]] attribute
        -Wshadow=compatible-local # warn if a local variable shadows another of compatible type
        -Wduplicated-branches # warn if an else-if has identical branches
        -Wduplicated-cond # warn if an if-else-if chain has duplicated conditions
        -Wsuggest-override # warn about overriding virtual functions without marking them with the override keyword
        # False-positives:
        -Wno-array-bounds
        -Wno-maybe-uninitialized
        -Wno-restrict
        -Wno-stringop-overflow -Wno-stringop-overread
        -Wno-use-after-free
  )

    set(CLANG_WARNINGS
        ${GCC_CLANG_COMMON_WARNINGS}
        -Wimplicit-fallthrough # warn if a switch case falls through without an explicit annotation
        -Wshadow-uncaptured-local # warn if a local declaration shadows another from parent context
        -Wloop-analysis # warn on common errors when using loops
        -Wno-self-assign-overloaded # don't warn on self-assign because it's often used in tests
  )

    set(MSVC_WARNINGS /W4 /permissive-)

    if(CT_TREAT_WARNINGS_AS_ERRORS)
        message(STATUS "Warnings are treated as errors")
        list(APPEND GCC_WARNINGS -Werror -pedantic-errors)
        list(APPEND CLANG_WARNINGS -Werror -pedantic-errors)
        list(APPEND MSVC_WARNINGS /WX)
    endif()

    if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        target_compile_options(${TARGET} PRIVATE ${MSVC_WARNINGS})
        target_compile_definitions(${TARGET} PRIVATE -D_CRT_SECURE_NO_WARNINGS)
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        target_compile_options(${TARGET} PRIVATE ${GCC_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        target_compile_options(${TARGET} PRIVATE ${CLANG_WARNINGS})
    else()
        message(WARNING "No compiler warnings set for CXX compiler: '${CMAKE_CXX_COMPILER_ID}'")
    endif()

endfunction()
