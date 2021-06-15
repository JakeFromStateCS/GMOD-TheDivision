/*
	TheDivision
	Server-Side
	Character
*/
/*
	Player joins
	Player selects character
	Player spawns

	Player given items
	Player stats set

	

	Player dies
	Player leaves
*/

TheDivision = TheDivision or {};
TheDivision.Character = TheDivision.Character or {};
TheDivision.Character.Config = {};
TheDivision.Character.Config.FilePath = "";
TheDivision.Character.Data = TheDivision.Character.Data or {};
TheDivision.Character.Hooks = TheDivision.Character.Hooks or {};

function TheDivision.Character:Init()

end;

function TheDivision.Character:PostInit()

	TheDivision.Modules:RegisterHooks( self, self.Hooks );
end;

function TheDivision.Character:LoadFiles()
	
end;

--Character:PlayerInitialSpawn( player/client ):
--	Delete the client's character on spawn
--	Or on death, then prompt them to create
--	One when they next spawn.
function TheDivision.Character.Hooks:PlayerInitialSpawn( client )
	local hasChar = client:HasCharacter();
	if( hasChar == false ) then
		--Make the client open the character menu.
		--Do not spawn them or something
		client:ConCommand( "TheDivision_Character_OpenMenu" );
	else

	end;
end;
