/*
	TheDivision
	Character
	Commands
*/

TheDivision = TheDivision or {};
TheDivision.Character = TheDivision.Character or {};
TheDivision.Character.Hooks = TheDivision.Character.Hooks or {};
TheDivision.Character.Commands = TheDivision.Character.Commands or {};

function TheDivision.Character.Commands:OpenMenu()
	local menu = "TD_Character_Menu";
	local panel = vgui.Create( menu );
	if( TheDivisionCharacterMenu ) then
		TheDivisionCharacterMenu:Remove();
	end;
	TheDivisionCharacterMenu = panel;
end;

function TheDivision.Character.Commands:CloseMenu()
	if( TheDivision.Character.Panel ) then
		TheDivision.Character.Panel:Remove();
		TheDivisionCharacterMenu:Remove();
		TheDivision.Character.Panel = nil;
		TheDivisionCharacterMenu = nil;
	end;
	TheDivision.Camera.Data.Lock = false;
	TheDivision.Camera.Data.DrawClientOverlay = false;
end;

TheDivision.Commands:RegisterCommands( "Character", TheDivision.Character.Commands );