TheDivision = TheDivision or {};
TheDivision.Camera = TheDivision.Camera or {};
TheDivision.Camera.Config = TheDivision.Camera.Config or {};
TheDivision.Camera.Data = TheDivision.Camera.Data or {};
TheDivision.Camera.Hooks = TheDivision.Camera.Hooks or {};


/*
	Hooks
*/

function TheDivision.Camera.Hooks:Think()
	local client = LocalPlayer();
	if( client:KeyDown( IN_DUCK ) ) then
		if( !self.Data.Duck ) then
			--self.Config.Offset.Up = self.Config.Offset.Up + self.Config.Duck.Up;
			self.Data.Duck = true;
		end;
	else
		if( self.Data.Duck ) then
			--self.Config.Offset.Up = self.Config.Offset.Up - self.Config.Duck.Up;
			self.Data.Duck = false;
		end;
	end;
end;

function TheDivision.Camera.Hooks:CalcView( client, pos, ang, fov )
	self:Setup( pos, ang );
	self:UpdateTargetPosition( pos );
	self:UpdateTargetAngles( ang );
	self:UpdateTargetFOV( fov );
	self:LerpPosition();
	self:LerpAngles();
	local view = {
		origin = self:GetPosition(),
		angles = self:GetAngles(),
		fov = fov,
		drawviewer = true
	};
	return view;
end;

function TheDivision.Camera.Hooks:PostDrawHUD()
	
end;

function TheDivision.Camera.Hooks:PostDrawOpaqueRenderables()
	
end;

function TheDivision.Camera.Hooks:PostRenderVGUI()
	local pos = self:GetPosition();
	local ang = self:GetAngles();

	hook.Call( "CameraRender", self, pos, ang );
end;