workspace "GEngine"
	architecture "x64"
	configurations{
		"Debug",
		"Release",
		"Dist"
	}

startproject "Sandbox"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

--Include directores relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "GEngine/vendor/GLFW/include"

include "GEngine/vendor/GLFW"


project "GEngine"
	location "GEngine"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")


	pchheader "gepch.h"
	pchsource "%{prj.name}/src/gepch.cpp"

	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs{
		"%{prj.name}/vendor/spdlog/include",
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}"
	}
	
	links{
		"GLFW",
		"opengl32.lib"
	}
	

	filter "system:windows"
		architecture "x86_64"
		cppdialect "C++17"
		staticruntime "Off" -- set to "Off" to enable Multithreaded DLL or Multithreaded Debug DLL
		runtime "Debug" -- set to "Debug" to use /MDd
		systemversion "latest"
		
		defines{
			"GE_PLATFORM_WINDOWS",
			"GE_BUILD_DLL"
		}

		postbuildcommands{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}


	filter "configurations:Debug"
		defines "GE_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "GE_RELEASE"
		symbols "On"

	filter "configurations:Dist"
		defines "GE_DIST"
		symbols "On"


project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs{
		"GEngine/vendor/spdlog/include",
		"GEngine/src"
	}

	links{
		"GEngine"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"
		
		defines{
			"GE_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "GE_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "GE_RELEASE"
		symbols "On"

	filter "configurations:Dist"
		defines "GE_DIST"
		symbols "On"