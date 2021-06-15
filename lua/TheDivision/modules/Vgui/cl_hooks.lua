/*
	TheDivision
	Client Vgui
*/

TheDivision = TheDivision or {};
TheDivision.Vgui = TheDivision.Vgui or {};
TheDivision.Vgui.Hooks = TheDivision.Vgui.Hooks or {};
TheDivision.Camera = TheDivision.Camera;
TheDivision.Camera.Data = TheDivision.Camera.Data;

function TheDivision.Vgui.Hooks:CameraRender( pos, ang )
	local curPos = TheDivision.Camera:GetPosition();
	local tarPos = TheDivision.Camera:GetTargetPosition();
	local tarAng = TheDivision.Camera:GetTargetAngles();
	local client = LocalPlayer();
	local panel = self.Panel;
	if( !panel or panel and !panel:IsValid() ) then
		panel = TheDivision.Character.Panel;
	end;
	if( panel ) then
		if( panel:IsValid() ) then
			local width = panel:GetWide();
			local height = panel:GetTall();
			local x, y = panel:GetPos();
			
			cam.Start3D2D( pos + ang:Forward() * 10, Angle( ang.r - 180, ang.y + 90, 90 - ang.p ), 1 )
					
			cam.End3D2D();
			
		end;
	end;

	if( TheDivision.Camera.Data.DrawClientOverlay ) then
		cam.Start3D( tarPos, tarAng );
			if( pos == curPos ) then
				render.SuppressEngineLighting( true );
					local weapon = client:GetActiveWeapon();
					local vehicle = client:GetVehicle();

					if( weapon:IsValid() ) then
						weapon:DrawModel();
					end;
					if( vehicle:IsValid() ) then
						vehicle:DrawModel();
					end;
					client:DrawModel();
				render.SuppressEngineLighting( false );
			end;
		cam.End3D();
	end;
end;

function TheDivision.Vgui.Hooks:Think()
	local panel = self.Panel;
	local console = gui.IsConsoleVisible();
	local menu = gui.IsGameUIVisible();
	if( !panel or panel and !panel:IsValid() ) then
		if( menu and !console ) then
			if( self.CloseMenu and TheDivisionCharacterMenu == nil ) then
				self.CloseMenu();
				self.OpenMenu( "TD_Base_Menu" );
			elseif( TheDivisionCharacterMenu ) then
				TheDivisionCharacterMenu:Remove();
				TheDivisionCharacterMenu = nil;
				self.CloseMenu();
				self.OpenMenu( "TD_Base_Menu" );
			end;
		end;
	else
		if( !menu or menu and console ) then
			self.CloseMenu();
		end;
	end;
end;

function TheDivision.Vgui.Hooks:HUDShouldDraw( element )
	if( self.Panel ) then
		if( self.Panel:IsValid() ) then
			return false;
		end;
	end;
end;