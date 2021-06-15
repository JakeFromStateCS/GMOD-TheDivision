TheDivision = TheDivision or {};
TheDivision.Camera = TheDivision.Camera or {};
if( SERVER ) then
	AddCSLuaFile();
	--TheDivision.File:LoadFile( "TheDivision/modules/Camera/", "cl_init.lua" );
	--TheDivision.File:LoadFile( "TheDivision/modules/Camera/", "cl_position.lua" );
	--TheDivision.File:LoadFile( "TheDivision/modules/Camera/", "cl_trace.lua" );
	--TheDivision.File:LoadFile( "TheDivision/modules/Camera/", "cl_updates.lua" );
	--TheDivision.File:LoadFile( "TheDivision/modules/Camera/", "cl_hooks.lua" );
	AddCSLuaFile( "cl_position.lua" );
	AddCSLuaFile( "cl_trace.lua" );
	AddCSLuaFile( "cl_updates.lua" );
	AddCSLuaFile( "cl_hooks.lua" );
	AddCSLuaFile( "cl_init.lua" );
else
	--TheDivision.File:LoadFolder( "TheDivision/modules/Camera/" );
	include( "cl_position.lua" );
	include( "cl_trace.lua" );
	include( "cl_updates.lua" );
	include( "cl_hooks.lua" );
	include( "cl_init.lua" );

	if( TheDivision.Camera.Init ) then
		TheDivision.Camera:Init();
	end;
	if( TheDivision.Camera.PostInit ) then
		TheDivision.Camera:PostInit();
	end;
end;