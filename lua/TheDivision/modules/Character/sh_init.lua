/*
	TheDivision
	Shared
	Character
*/

TheDivision = TheDivision or {};
TheDivision.Character = TheDivision.Character or {};
TheDivision.Character.Config = {};
TheDivision.Character.Config.FilePath = "";
TheDivision.Character.Data = TheDivision.Character.Data or {};
TheDivision.Character.Hooks = TheDivision.Character.Hooks or {};
if( SERVER ) then
	AddCSLuaFile( "sh_pmeta.lua" );
end;
include( "sh_pmeta.lua" );

function TheDivision.Character:Init()

end;


function TheDivision.Character:PostInit()
	print( "TheDivision.Character.PostInit" );
end;


function TheDivision.Character:LoadFiles()
	local files, folders = file.Find( self.Config.FilePath .. "*.lua", "LUA" );
	for _,file in pairs( files ) do
		if( !string.match( file, "init" ) ) then
			TheDivision.File:LoadFile( self.Config.FilePath, file );
		end;
	end;
end;

--Character:IsValid( Player/client ):
--	Does the client have a valid character
--	Either cached or stored in a file?
function TheDivision.Character:IsValid( client )
	return false;
end;