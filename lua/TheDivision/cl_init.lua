/*
	TheDivision
	Client Init
*/

TheDivision = TheDivision or {};



include( "sh_init.lua" );

--TheDivision:Init():
--	First function to be called.
function TheDivision:Init()
	self.File:LoadFile( "TheDivision/libraries/Debug/", "sh_init.lua" );
	TheDivision.Debug:Print( {
		Text = "TheDivision",
		Color = Color( 255, 100, 0 ),
		TextColor = Color( 255, 255, 255 ),
		Type = "Header"
	} );
	self.File:LoadFolder( "TheDivision/libraries/" );
	self.File:LoadFolder( "TheDivision/modules/" );
end;

function TheDivision:PostInit()
	self.File:CallPostInits();
end;