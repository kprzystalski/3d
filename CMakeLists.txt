cmake_minimum_required(VERSION 3.15)

project(Graphics3DCode CXX C)

include(FetchContent)
include(ExternalProject)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)

set(SOURCE_DIR ${PROJECT_SOURCE_DIR}/src)

set(3rdParty_DIR ${SOURCE_DIR}/3rdParty)
include_directories(${3rdParty_DIR})
include_directories(${SOURCE_DIR})

add_compile_definitions(XE_DEBUG)


# GLAD
set(MAJOR 4)
set(MINOR 6)
set(GLAD_DEBUG OFF)

if(APPLE) #Apple has deprec
set(MAJOR 4)
set(MINOR 1)
endif()

add_compile_definitions(MAJOR=${MAJOR})
add_compile_definitions(MINOR=${MINOR})
set(GLAD_DIR ${3rdParty_DIR}/glad/glad_${MAJOR}_${MINOR})
if(${GLAD_DEBUG})
set(GLAD_DIR ${GLAD_DIR}_debug)
endif()


include_directories(${GLAD_DIR}/glad/include)
file(GLOB_RECURSE glad_SOURCES "${GLAD_DIR}/glad/src/*.c")
add_library(glad OBJECT ${glad_SOURCES})

# GLFW
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_Assignments OFF CACHE BOOL "" FORCE)


FetchContent_Declare(
        glfw
        GIT_REPOSITORY   https://github.com/glfw/glfw.git     
)
FetchContent_MakeAvailable(glfw)

# GLM

FetchContent_Declare(
        glm
        GIT_REPOSITORY https://github.com/g-truc/glm.git
)
FetchContent_MakeAvailable(glm)


if(__VS_CODE__)

# GLSLang

FetchContent_Declare(
        glslang
        GIT_REPOSITORY https://github.com/KhronosGroup/glslang.git

)
FetchContent_MakeAvailable(glslang)


endif()

find_package(OpenGL REQUIRED)

# My part 

link_libraries(OpenGL::GL glfw glm glad)
add_subdirectory(src/Application)


#Assignments
set(ASSIGNMENTS Triangle House Colors Indices Uniforms PVM Pyramid  Resizing Zoom  CameraMovement  Textures Phong MultipleLights NormalMaps )

set(ASSIGNMENTS_DIR ${SOURCE_DIR}/Assignments)
link_libraries(application)

foreach(assignment ${ASSIGNMENTS})
        if(EXISTS ${ASSIGNMENTS_DIR}/${assignment} )
                add_subdirectory(${ASSIGNMENTS_DIR}/${assignment})
        else()
                message("Warning: directory ${ASSIGNMENTS_DIR}/${assignment} does not exists.")        
        endif()
endforeach()
