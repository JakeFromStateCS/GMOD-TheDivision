/*
	TheDivision
	Shared FileSystem
*/

TheDivision = TheDivision or {};
TheDivision.File = {};
TheDivision.File.Cache = {};
TheDivision.File.Config = {};
TheDivision.File.Config.FilePath = "lua/TheDivision/";

--A list of files we want to send to the client
--
TheDivision.File.CSLua = {};

TheDivision.File.Data = {};
TheDivision.File.Loaded = {};



/*
	TheDivision.File.FolderIndexes = {
		1 = "Debug",
		2 = "Libraries"
	}
	TheDivision.File.FolderCalls[1] = {
		PreInit = function,
		Init = function,
		PostInit = function
	}
*/
TheDivision.File.FolderCalls = {};
TheDivision.File.FolderIndexes = {};

/*
	The modules and libraries need a standardized way
	To store data and handle data easily

	Essentially a data api that they interact with
*/

--TheDivision.File:LoadFile( String/path, String/fileName ):
--	Loads the specified file and automates the client caching
--	Process. ( AddCSLuaFile, include, etc );
--	Also automates project structure.
function TheDivision.File:LoadFile( path, fileName )
	local prefix = string.sub( fileName, 1, 2 );
	local pathSplit = string.Split(
		path,
		"/"
	);

	local folderName = pathSplit[#pathSplit - 1];

	--The file name stripped of prefix
	--	And file extension. sv_test.lua = "test";
	--		Used for logging and debugging
	local minFileName = string.sub( fileName, 4, -5 );
	local propFileName = string.Proper( minFileName );
	local propFolderName = string.Proper( folderName );
	table.insert( self.Loaded, propFolderName );

	--sh or cl
	if( prefix ~= "sv" ) then
		--either way we include
		if( CLIENT ) then
			include( path .. fileName );
		else
			AddCSLuaFile( path .. fileName );
			--we only include serverside if it is shared
			if( prefix == "sh" ) then
				include( path .. fileName );
			end;
		end;
	else
		include( path .. fileName );
	end;

	local tabData = TheDivision[propFolderName];
	if( tabData ~= nil ) then
		local folderCall = {};
		local insert = false;

		if( tabData.PreInit ) then
			folderCall.PreInit = tabData.PreInit;
			insert = true;
		end;

		if( tabData.Init ~= nil ) then
			--folderCall.Init = tabData.Init;
			tabData:Init();
		end;

		if( tabData.PostInit ~= nil ) then
			folderCall.PostInit = tabData.PostInit;
			insert = true;
		end;

		if( insert == true ) then
			table.insert( self.FolderCalls, folderCall );
			self.FolderIndexes[propFolderName] = #self.FolderCalls;
		end;
	end;
end;

--TheDivision.File.RequestFile( String/path, String/fileName ):
--	
function TheDivision.File.RequestFile( path, fileName )
	local prefix = string.sub( fileName, 1, 2 );

end;

--TheDivision.File:LoadFolder( String/folderPath ):
--	Loads the *_init.lua file
--	The *_init.lua file should be in every sub folder.
--	It defines the loading functions
--	As well as how to handle any files below it.
function TheDivision.File:LoadFolder( folderPath )
	local pathSplit = string.Split(
		folderPath,
		"/"
	);

	local folderName = pathSplit[#pathSplit - 1];

	local propFolderName = string.Proper( folderName );
	local loadOrder = {
		"sv",
		"sh",
		"cl"
	};
	for _,prefix in pairs( loadOrder ) do
		local exists = file.Exists( folderPath .. prefix .. "_init.lua", "LUA" );
		if( exists ) then
			local files, folders = file.Find( folderPath .. prefix .. "_init.lua", "LUA" );
			local initFile = files[1];
			if( initFile ~= nil ) then
				self:LoadFile( folderPath, initFile );
			end;
			files, folders = file.Find( folderPath .. "*.lua", "LUA" );
			
			for _,file in pairs( files ) do
				if( !string.match( file, "init" ) ) then
					self:LoadFile( folderPath, file );
				end;
			end;
			
		end;
	end;
end;

function TheDivision.File:GetIndex( folderName )
	for storedName, index in pairs( self.FolderIndexes ) do
		if( storedName == folderName ) then
			return index;
		end;
	end;
end;

function TheDivision.File:GetName( folderIndex )
	for storedName,index in pairs( self.FolderIndexes ) do
		if( index == folderIndex ) then
			return storedName;
		end;
	end;
end;

--TheDivision.File:CallInits():
--	Loops through our Inits folder
--	Checks if a library with the name exists
--	Checks if library has an Init func
function TheDivision.File:CallInits()
	local count = #self.FolderCalls;
	if( count > 0 ) then
		for index = 1, count do
			local folderName = self:GetName( index );
			if( folderName ) then
				local folderData = self.FolderCalls[index];

				if( folderData ) then
					local tableData = TheDivision[folderName];
					if( tableData ) then
						local init = tableData.Init;
						if( init ) then

							tableData:Init();
							--folderData.Init = nil;
							local count = table.Count( folderData );
							if( count == 0 ) then
								--table.remove( self.FolderCalls, index );
								self.FolderIndexes[folderName] = nil;
							end;
							--table.remove( self.FolderCalls, index );
							--self.FolderIndexes[folderName] = nil;
						end;
					end;
				end;
			end;
		end;
	end;
end;

function TheDivision.File:CallPostInits()
	local count = #self.FolderCalls;
	if( count > 0 ) then
		for index = 1, count do
			local folderName = self:GetName( index );
			if( folderName ) then
				local folderData = self.FolderCalls[index];

				if( folderData ) then
					local tableData = TheDivision[folderName];
					if( tableData ) then
						local postInit = tableData.PostInit;
						if( postInit ) then
							tableData:PostInit();
							--folderData.Init = nil;
							local count = table.Count( folderData );
							if( count == 0 ) then
								--table.remove( self.FolderCalls, index );
								self.FolderIndexes[folderName] = nil;
							end;
							--table.remove( self.FolderCalls, index );
							self.FolderIndexes[folderName] = nil;
						end;
					end;
				end;
			end;
		end;
	end;
end;