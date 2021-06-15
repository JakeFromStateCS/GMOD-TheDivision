TheDivision = TheDivision or {};
TheDivision.Character = TheDivision.Character;


function TheDivision.Character:GetGenderButtons()
	local buttons = {
		{
			callback = function( self )
				local parent = self:GetParent();
				local menu = parent:GetParent();
				surface.PlaySound( "buttons/button24.wav" );
				parent:ClearItems( function()
					menu:SetupButtons();
				end );
			end,
			text = "Gender",
			color = Color( 170, 70, 0 ),
			linecolor = Color( 230, 100, 20 )
		},
		{
			callback = function()
				RunConsoleCommand( "TheDivision_Character_CloseMenu" );
				surface.PlaySound( "buttons/button9.wav" );
			end,
			text = "Male",
			color = Color( 50, 50, 50 ),
			linecolor = Color( 50, 50, 50 )
		},
		{
			callback = function( self )
				surface.PlaySound( "buttons/button9.wav" );
				DarkRP.setPreferredJobModel( LocalPlayer():Team(), "models/player/Group01/Female_03.mdl" );
				local parent = self:GetParent();
				local menu = TheDivision.Character.Panel;
				local buttons = TheDivision.Character:GetFemaleButtons();
				menu:Transition( buttons );
			end,
			text = "Female",
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