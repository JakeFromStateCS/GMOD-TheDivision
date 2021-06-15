/*
	TheDivision
	Shared Libaries
*/
TheDivision = TheDivision;
TheDivision.Libraries = {};
TheDivision.Libraries.Config = {};
TheDivision.Libraries.Config.FilePath = "TheDivision/libraries/";
TheDivision.Libraries.Cache = {};
TheDivision.Libraries.Data = {};
TheDivision.Libraries.Inits = {};
TheDivision.Libraries.Hooks = {};

function TheDivision.Libraries:Init()
	self:LoadFiles();
end;

function TheDivision.Libraries:PostInit()
	TheDivision.Debug:Print( {
		Text = " ",
		Color = Color( 255, 255, 255 ),
		Type = "Content"
	} );
	TheDivision.Debug:Print( {
		Text = "Libraries",
		Color = Color( 255, 150, 0 ),
		Type = "Content"
	} );
	TheDivision.Debug:Print( {
		Text = "---------",
		Color = Color( 255, 200, 0 ),
		TextColor = Color( 255, 255, 0 ),
		Type = "Category"
	} );
	for index,folderName in pairs( self.Cache ) do
		TheDivision.Debug:Print( {
			Text = index .. "." .. folderName,
			Color = Color( 255, 150, 0 ),
			Type = "Content"
		} );
	end;
	self.Cache = {};
end;

function TheDivision.Libraries:LoadFiles()
	local files, folders = file.Find( self.Config.FilePath .. "*", "LUA" );
	
	for index,folderName in pairs( folders ) do
		local fullPath = self.Config.FilePath .. folderName .. "/";
		
		table.insert( self.Cache, folderName );
		TheDivision.File:LoadFolder( fullPath );
	end;
end;