/*
	TheDivision
	Client Vgui
*/

TheDivision = TheDivision or {};
TheDivision.Vgui = TheDivision.Vgui or {};
TheDivision.Vgui.Hooks = TheDivision.Vgui.Hooks or {};
TheDivision.Camera = TheDivision.Camera;
TheDivision.Camera.Data = TheDivision.Camera.Data;

function TheDivision.Vgui.OpenMenu( menu )
	local panel = vgui.Create( menu );
	if( TheDivisionEscapeMenu ) then
		TheDivisionEscapeMenu:Remove();
	end;
	TheDivisionEscapeMenu = panel;
end;

concommand.Add( "+td_menu", function()
	--TheDivision.Vgui.CloseMenu();
	TheDivision.Vgui.OpenMenu( "TD_Base_Menu" );
end );

function TheDivision.Vgui.CloseMenu()
	if( TheDivision.Vgui.Panel ) then
		TheDivision.Vgui.Panel:Remove();
		TheDivision.Vgui.Panel = nil;
	end;
	if( TheDivisionEscapeMenu ) then
		TheDivisionEscapeMenu:Remove();
		--TheDivisionEscapeMenu = nil;
	end;
	TheDivision.Camera.Data.Lock = false;
	TheDivision.Camera.Data.DrawClientOverlay = false;
end;
concommand.Add( "-td_menu", TheDivision.Vgui.CloseMenu );

function TheDivision.Vgui:GetOptionsButtons()
	local buttons = {
		{
			callback = function( self )
				local parent = self:GetParent();
				local menu = TheDivision.Vgui.Panel;
				if( menu ) then
					local grid = menu.Grid;
					surface.PlaySound( "buttons/button24.wav" );
					grid:ClearItems( function()
						menu:SetupButtons();
					end );
				end;
			end,
			text = "Options",
			color = Color( 170, 70, 0 ),
			linecolor = Color( 230, 100, 20 )
		},
		{
			callback = function()
				RunConsoleCommand( "cancelselect" );
				surface.PlaySound( "buttons/button9.wav" );
			end,
			text = "Camera",
			color = Color( 50, 50, 50 ),
			linecolor = Color( 50, 50, 50 )
		},
		{
			callback = function()
				RunConsoleCommand( "cancelselect" );
			end,
			text = "Close",
			color = Color( 50, 50, 50 ),
			linecolor = Color( 50, 50, 50 )
		}
	};
	return buttons;
end;