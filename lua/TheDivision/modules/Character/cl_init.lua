/*
	TheDivision
	Client
	Character
	Init
*/

TheDivision = TheDivision or {};
TheDivision.Character = TheDivision.Character or {};
TheDivision.Character.Hooks = TheDivision.Character.Hooks or {};
TheDivision.Character.Commands = TheDivision.Character.Commands or {};

function TheDivision.Character:Init()

end;

function TheDivision.Character:PostInit()
	if( TheDivisionCharacterMenu ) then
		TheDivisionCharacterMenu:Remove();
		TheDivisionCharacterMenu = nil;
		RunConsoleCommand( "TheDivision_Character_OpenMenu" );
	end;
	
	TheDivision.Modules:RegisterHooks( self.Hooks );
end;