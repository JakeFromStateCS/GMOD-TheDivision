TheDivision = TheDivision or {};
TheDivision.Character = TheDivision.Character;


function TheDivision.Character:GetFemaleButtons()
	local buttons = {
		{
			callback = function( self )
				local parent = self:GetParent();
				local menu = self;
				local buttons = TheDivision.Character:GetGenderButtons();
				self:Transition( buttons );
			end,
			text = "Female",
			color = Color( 170, 70, 0 ),
			linecolor = Color( 230, 100, 20 )
		},
		{
			callback = function()
				RunConsoleCommand( "TheDivision_Character_CloseMenu" );
				surface.PlaySound( "buttons/button9.wav" );
			end,
			text = "Preset",
			color = Color( 50, 50, 50 ),
			linecolor = Color( 50, 50, 50 )
		},
		{
			callback = function()
				RunConsoleCommand( "TheDivision_Character_CloseMenu" );
			end,
			text = "Close",
			color = Color( 50, 50, 50 ),
			linecolor = Color( 50, 50, 50 )
		}
	};
	return buttons;
end;

print( "hi" );