/*
	TheDivision
	Client
	Character
	Hooks
*/

TheDivision = TheDivision or {};
TheDivision.Character = TheDivision.Character or {};
TheDivision.Character.Hooks = TheDivision.Character.Hooks or {};
TheDivision.Character.Commands = TheDivision.Character.Commands or {};

function TheDivision.Character.Hooks:CameraRender( pos, ang )
	print( "gg" );
	local curPos = TheDivision.Camera:GetPosition();
	local tarPos = TheDivision.Camera:GetTargetPosition();
	local tarAng = TheDivision.Camera:GetTargetAngles();
	local client = LocalPlayer();
	local panel = self.Panel;
	if( panel ) then
		if( panel:IsValid() ) then
			local width = panel:GetWide();
			local height = panel:GetTall();
			local x, y = panel:GetPos();
			
			cam.Start3D2D( pos + ang:Forward() * 10, Angle( ang.r - 180, ang.y + 90, 90 - ang.p ), 1 )
					
			cam.End3D2D();
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
end;