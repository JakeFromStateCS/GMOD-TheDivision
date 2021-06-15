/*
	TheDivision
	Shared Init
*/

TheDivision = TheDivision or {};

--string.Proper( String/text ):
--	Returns the text as a proper noun
--	IE: Capitalize first letter.
function string.Proper( text )
	local self = string;
	local newText = text;
	local firstLetter = self.sub( newText, 1, 1 );
	local upperLetter = self.upper( firstLetter );
	if( firstLetter ~= upperLetter ) then
		newText = self.sub( newText, 2 );
		firstLetter = self.upper( firstLetter );
		newText = firstLetter .. newText;
	end;
	return newText;
end;

if( SERVER ) then
	AddCSLuaFile( "sh_file.lua" );
end;

include( "sh_file.lua" );
