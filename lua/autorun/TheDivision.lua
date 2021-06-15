TheDivision = {};
TheDivision.Version = "0.0.1";
local gm = {};
if( GM ) then
	gm = GM;
elseif( GAMEMODE ) then
	gm = GAMEMODE;
end;

if( SERVER ) then
	
	gm.Name = "The Division v" .. TheDivision.Version;
	AddCSLuaFile();
	AddCSLuaFile( "TheDivision/cl_init.lua" );
	include( "TheDivision/sv_init.lua" );
else
	gm.Name = "The Division v" .. TheDivision.Version;
	include( "TheDivision/cl_init.lua" );
end;

if( TheDivision.Init ) then
	TheDivision:Init();
end;
if( TheDivision.PostInit ) then
	TheDivision:PostInit();
end;
