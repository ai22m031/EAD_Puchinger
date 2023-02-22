#pragma once

#ifdef GE_PLATFORM_WINDOWS
	#ifdef GE_BUILD_DLL
		#define GEngine_API __declspec(dllexport)
	#else
		#define GEngine_API __declspec(dllimport)
	#endif
#else
	#error GEngine only support Windows!
#endif