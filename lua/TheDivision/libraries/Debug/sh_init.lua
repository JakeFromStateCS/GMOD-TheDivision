/*
	TheDivision Debug
	  Shared Library
	   sh_init.lua
*/

TheDivision = TheDivision;
TheDivision.Debug = {};

TheDivision.Debug.Config = {
	PrintEnabled = true,
	PrintTypes = {
		Header = {
			Text = "=",
			Count = 4,
			Color = Color( 255, 255, 255 ),
			TextColor = Color( 255, 150, 0 )
		},
		Category = {
			Text = "-",
			Count = 5,
			--Parent = "Header"
		},
		Content = {
			Text = " ",
			Count = 5,
			--Parent = "Category",
			Color = Color( 255, 150, 0 )
		},
		Divider = {
			Text = "-",
			Count = 5,
			--Parent = "Category"
		}
	}
};
TheDivision.Debug.ParentCache = {};


function TheDivision.Debug:Init()
	
end;

function TheDivision.Debug:GetData( textData )
	if( textData == nil ) then
		return;
	end;

	local DataPoints = {
		"Count",
		"Color",
		"Parent",
		"Text",
		"TextColor",
		"Type"
	};
	local Data = {
		Count = 0,
		Type = "Content",
		Text = "",
		Color = Color( 255, 255, 255 ),
		TextColor = Color( 255, 255, 255 )
	};
	local TypeData = self.Config.PrintTypes[Data.Type];
	if( textData.Type ) then
		TypeData = self.Config.PrintTypes[textData.Type];
	end;

	for index = 1, #DataPoints do
		local key = DataPoints[index];
		if( TypeData[key] ) then
			Data[key] = TypeData[key];
		end;
		if( textData[key] ) then
			Data[key] = textData[key];
		end;
		
	end;

	return Data;
end;

/*
TheDivision.Debug:Print( String/Data.Text, String/type ):
	Types
		- Header:
		- Category
		- Content
	Auto aligns print functions
	Based on Data.Text size and type
	Every type have different
	Align offsets
*/ 
function TheDivision.Debug:Print( textData )
	

	local Data = self:GetData( textData );
	if( Data == nil or Data.Text == "" and Data.Count == 0 ) then
		PrintTable( Data );
		return;
	end;
	

	--The string we want to print
	local printStr = Data.Text;
	local textLen = string.len( Data.Text );
	TheDivision.Debug.ParentCache[Data.Type] = Data.Text;

	--The first and last set
	--Of decorative characters
	--"====Libraries====" = "===="
	local typeText = "";
	if( Data.Type ~= nil ) then
		local typeData = self.Config.PrintTypes[Data.Type];
		local parentType = typeData.Parent;
		local parentData = ( parentType ~= nil and self.Config.PrintTypes[parentType] or {} );
		local parentCache = TheDivision.Debug.ParentCache[parentType];
		local parentLen = 0;
		local lenDiff = 0;
		--print( parentData );
		if( parentCache ) then
			--print( parentCache );
			parentLen = string.len( parentCache );
			lenDiff = math.max( parentLen, textLen ) - math.min( parentLen, textLen );

			
		end;
		if( parentData ) then
			--print( parentData.Text );
		end;
		if( typeData ~= nil ) then
			
			local addLen = math.ceil( parentLen / 2 );
			local target = typeData.Count;
			if( lenDiff > 0 ) then
				target = target + lenDiff;
			end;
			
			if( parentData ) then
				if( parentData.Count ) then
					local add = math.ceil( math.abs( parentLen - textLen ) / 2 );
					target = target / 2 + add;
					--target = target - math.ceil( math.abs( parentLen - textLen ) / 2 );
				end;
			end;
			for count = 1, target do
				typeText = typeText .. typeData.Text;
			end;
		end;
	end;

	MsgC( Data.Color, typeText );
	MsgC( Data.TextColor, Data.Text );
	MsgC( Data.Color, typeText );
	MsgC( Color( 255, 255, 255 ), "\n" );
end;


function TheDivision.Debug:TestFunction( testData )
	local baseTab,
		  funcName = testData.Table,
		  testData.Function;
	--local nameLength = string.len( folderName );
end;

/*
local totalTime = 0;
local totalRuns = 10;

print( "=====Testing Start=====" );
local time = SysTime();

for i = 1, totalRuns do
	local proper = string.Proper( tostring( i ) );
end;
print( "     Testing Done    ");
local finTime = SysTime();
local runTime = finTime - time;
totalTime = totalTime + runTime;
print( "=====Test Results=====")
print( "Time: " .. string.sub( tostring( finTime - time ), 1, 8 ) );
*/