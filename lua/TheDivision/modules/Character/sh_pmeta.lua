/*
	TheDivision
	Player Meta	
*/
TheDivision = TheDivision or {};
TheDivision.Character = TheDivision.Character or {};
TheDivision.Character.Data = TheDivision.Character.Data or {};


local meta = FindMetaTable( "Player" );

function meta:HasCharacter()
	return TheDivision.Character:IsValid( self );
end;