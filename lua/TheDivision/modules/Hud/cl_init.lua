surface.CreateFont( "TheDivision_HUD_Ammo", {
	font = "Tahoma",
	size = 12
} );

TheDivision = TheDivision or {};
TheDivision.Hud = TheDivision.Hud or {};
TheDivision.Hud.Hooks = {};

function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is need for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	return cir;
end

function TheDivision.Hud:Init()

end;


function TheDivision.Hud:PostInit()
	self.Circle = draw.Circle( 120, 120, 100, 25 );
	TheDivision.Modules:RegisterHooks( self, self.Hooks );
end;

function TheDivision.Hud:DrawCrosshair()
	local camPos = TheDivision.Camera:GetPosition();
	local pos = TheDivision.Camera:GetCrosshairPos();
	local ang = TheDivision.Camera:GetAngles();
	local hudSize = 10;
	local cir = self.Circle;

	if( pos and ang ) then
		local vel = LocalPlayer():GetVelocity():Length();
		local offset = math.Clamp( vel / 20, 0, hudSize * 2 );
		local testAng = ( camPos - pos ):Angle();
		local oldAng = Angle( 0, ang.y - 90, -ang.p + 90 );
		cam.Start3D2D( pos, oldAng, 0.25 )
			surface.SetDrawColor( Color( 220, 220, 220 ) );
			--Top
			surface.DrawRect( -0.5, -hudSize - offset, 1, hudSize );
			--Bottom
			surface.DrawRect( -0.5, offset + 1, 1, hudSize );
			
			--Left
			surface.DrawRect( -hudSize - offset, 0.5, hudSize, 1 );
			--Right
			surface.DrawRect( offset + 1, 0.5, hudSize, 1 );
			
		cam.End3D2D();	
	end;
end;

function TheDivision.Hud:DrawBase()
	local camPos = TheDivision.Camera:GetPosition();
	local pos = TheDivision.Camera:GetCrosshairPos();
	local ang = TheDivision.Camera:GetAngles();
	local hudSize = 12;
	local cir = self.Circle;
	--pos = pos + ang:Right() * 10;
	if( pos and ang ) then
		local vel = LocalPlayer():GetVelocity():Length();
		local offset = math.Clamp( vel / 20, 0, hudSize * 2 );
		local testAng = ( camPos - pos ):Angle();
		local oldAng = Angle( 0, ang.y - 90, -ang.p + 90 );
		cam.Start3D2D( pos, oldAng, 0.25 )
			surface.SetDrawColor( Color( 250, 130, 80 ) );
			
			--TopHor
			surface.DrawRect( hudSize * 1.5 + offset, -hudSize - offset, hudSize / 2, 2 );
			surface.DrawRect( -hudSize * 2 - offset, -hudSize - offset, hudSize / 2, 2 );
			
			--BotHor
			surface.DrawRect( hudSize * 1.5 + offset, hudSize + offset, hudSize / 2, 2 );
			surface.DrawRect( -hudSize * 2 - offset, hudSize + offset, hudSize / 2, 2 );
			

			--TopVert
			surface.DrawRect( hudSize * 2 + offset, -hudSize - offset + 2, 2, hudSize / 2 );
			surface.DrawRect( -hudSize * 2 - 1 - offset, -hudSize - offset + 2, 2, hudSize / 2 );
			
			--BotVert
			surface.DrawRect( hudSize * 2 + offset, 1 + offset + hudSize / 2, 2, hudSize / 2 );
			surface.DrawRect( -hudSize * 2 - 1 - offset, 1 + offset + hudSize / 2, 2, hudSize / 2 );
			
		cam.End3D2D();	
	end;
end;

function TheDivision.Hud:Ammo()
	local camPos = TheDivision.Camera:GetPosition();
	local pos = TheDivision.Camera:GetCrosshairPos();
	local ang = TheDivision.Camera:GetAngles();
	local hudSize = 10;
	local cir = self.Circle;
	--pos = pos + ang:Right() * 10;
	if( pos and ang ) then
		local vel = LocalPlayer():GetVelocity():Length();
		local offset = math.Clamp( vel / 20, 0, hudSize * 2 );
		local testAng = ( camPos - pos ):Angle();
		local oldAng = Angle( 0, ang.y - 90, -ang.p + 90 );
		local weapon = LocalPlayer():GetActiveWeapon();
		if( weapon ) then
			if( weapon:IsValid() ) then
				local ammo = weapon:Clip1();
				if( ammo ) then
					if( ammo ~= -1 ) then
						cam.Start3D2D( pos, oldAng, 0.25 )
							surface.SetDrawColor( Color( 255, 255, 255 ) );
							draw.SimpleText(
								ammo,
								"TheDivision_HUD_Ammo",
								hudSize * 2 + offset - 1 - hudSize / 2,
								hudSize * 2 + offset - 6,
								Color( 255, 255, 0 ),
								TEXT_ALIGN_LEFT,
								TEXT_ALIGN_BOTTOM
							);
						cam.End3D2D();
					end;
				end;
			end;
		end;
	end;
end;

function TheDivision.Hud.Hooks:PostDrawOpaqueRenderables()
	hook.Call( "HUDRender" );
end;

function TheDivision.Hud.Hooks:HUDRender()
	self:DrawCrosshair();
	self:DrawBase();
	self:Ammo();
end;

function TheDivision.Hud.Hooks:HUDShouldDraw( element )
	if( element == "CHudCrosshair" ) then
		return false;
	end;
end;