TheDivision = TheDivision or {};
TheDivision.Vgui = TheDivision.Vgui or {};
TheDivision.Vgui.Config = {};
TheDivision.Vgui.Config.FilePath = "TheDivision/modules/Vgui/";
TheDivision.Vgui.Hooks = TheDivision.Vgui.Hooks or {};

if( SERVER ) then
	AddCSLuaFile();
	--TheDivision.File:LoadFolder( "TheDivision/modules/Vgui/panels/" );
	--AddCSLuaFile( "panels/base_menu.lua" );
	--AddCSLuaFile( "panels/character_menu.lua" );
	AddCSLuaFile( "cl_init.lua" );
else
	--TheDivision.Vgui = TheDivision.Vgui or {};
	--TheDivision.File:LoadFolder( "TheDivision/modules/Vgui/panels/" );
	--include( "panels/base_menu.lua" );
	--include( "panels/character_menu.lua" );
	include( "cl_init.lua" );
end;

function TheDivision.Vgui:Init()
	
end;

function TheDivision.Vgui:PostInit()
	
	self:LoadFiles();
	self:LoadPanels();
	TheDivision.Modules:RegisterHooks( self, self.Hooks );
end;

function TheDivision.Vgui:LoadFiles()
	local files, folders = file.Find( self.Config.FilePath .. "*.lua", "LUA" );
	for _,file in pairs( files ) do
		if( !string.match( file, "init" ) ) then
			print( file );
			TheDivision.File:LoadFile( self.Config.FilePath, file );
		end;
	end;
end;

function TheDivision.Vgui:LoadPanels()
	local modPath = TheDivision.Modules.Config.FilePath;
	local files, folders = file.Find( modPath .. "*", "LUA" );
	for _,folder in pairs( folders ) do
		local localPath = modPath .. folder .. "/";
		local files, folders = file.Find( localPath .. "panels/*.lua", "LUA" );
		for _,file in pairs( files ) do
			print( folder .. " - " .. file );
			TheDivision.File:LoadFile( localPath .. "panels/", file );
		end;
	end;
end;

print( "LoadPanels" );