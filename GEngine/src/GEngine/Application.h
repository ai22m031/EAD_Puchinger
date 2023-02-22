#pragma once

#include "Core.h"

namespace GEngine {
	class GEngine_API Application
	{
		public:
			Application();
			virtual ~Application();
			void Run();
	
	};
	//To be defined in Client
	Application* CreateApplication();

}
	

