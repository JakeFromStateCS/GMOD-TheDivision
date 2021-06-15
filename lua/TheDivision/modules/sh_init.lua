/*
	TheDivision
	Shared Modules
*/
TheDivision = TheDivision;
TheDivision.Modules = {};
TheDivision.Modules.Config = {};
TheDivision.Modules.Config.FilePath = "TheDivision/modules/";
TheDivision.Modules.Cache = {};
TheDivision.Modules.Data = {};
TheDivision.Modules.Inits = {};
TheDivision.Modules.Hooks = {};

function TheDivision.Modules:Init()
	self:LoadFiles();
end;

function TheDivision.Modules:PostInit()
	TheDivision.Debug:Print( {
		Text = " ",
		Color = Color( 255, 255, 255 ),
		Type = "Content"
	} );
	TheDivision.Debug:Print( {
		Text = "Modules",
		Color = Color( 255, 255, 0 ),
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
			Color = Color( 255, 255, 0 ),
			Type = "Content"
		} );
	end;
	self.Cache = {};
end;

function TheDivision.Modules:LoadFiles()
	local files, folders = file.Find( self.Config.FilePath .. "*", "LUA" );
	
	for index,folderName in pairs( folders ) do
		local fullPath = self.Config.FilePath .. folderName .. "/";
		table.insert( self.Cache, folderName );
		TheDivision.File:LoadFolder( fullPath );
	end;
end;

function TheDivision.Modules:RegisterHooks( parentTable, hookTable )
	if( hookTable ) then
		for hookType, func in pairs( hookTable ) do
			if( self.Hooks[hookType] == nil ) then
				self.Hooks[hookType] = {};
			end;
			hook.Add( hookType, "TheDivision_" .. hookType, function( parentTable, ... )
				local hooks = self.Hooks[hookType];
				local retVal = nil;
				for _,func in pairs( hooks ) do
					retVal = func( parentTable, ... );
				end;
				if( retVal ) then
					return retVal;
				end;
			end );
			table.insert( 
				self.Hooks[hookType], 
				function( ... )
					return func( parentTable, ... );
				end
			);
			
		end;
	end;
end;