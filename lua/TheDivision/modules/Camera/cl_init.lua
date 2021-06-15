/*
	Localize all o f the functions
	That are called frequently
*/
local surface = surface;
local draw = draw;
local math = math;
local LerpAngle = _G.LerpAngle;
local LerpVector = _G.LerpVector;

surface.CreateFont( "TheDivision_HUDTest", {
	font = "Tahoma",
	size = 160,
	weight = 600
} );

surface.CreateFont( "TheDivision_HUDHealth", {
	font = "Tahoma",
	size = 24,
	weight = 300
} );

surface.CreateFont( "TheDivision_Clip1Curr", {
	font = "Tahoma",
	size = 20,
	weight = 300
} );

surface.CreateFont( "TheDivision_Clip1Max", {
	font = "Tahoma",
	size = 26,
	weight = 300
} );

--include( "cl_position.lua" );
--include( "cl_trace.lua" );
--include( "cl_updates.lua" );
--include( "cl_hooks.lua" );
TheDivision = TheDivision or {};
TheDivision.Camera = TheDivision.Camera or {};
TheDivision.Camera.Hooks = TheDivision.Camera.Hooks or {};


function TheDivision.Camera:Init()
	self.Config = {
		Offset = {
			Forward = -50,
			Right = 10,
			Up = 5,
		},
		Duck = {
			Up = 15,
			Forward = -20
		},
		Rotate = {
			Pitch = 0,
			Yaw = 0,
			Roll = 0
		},
		Lerp = {
			Max = {
				Position = 0.2,
				Angles = 0.2
			}
		}
	}

	self.Data = {
		CurrentPos = EyePos(),
		CurrentAng = EyeAngles(),
		Duck = false,
		FOV = 90,
		Lock = false,
		Set = false,
		TargetPos = Vector( 0, 0, 0 ),
		TargetAng = Angle( 0, 0, 0 ),
	};
	self.Hooks = self.Hooks or {};
	
end;

function TheDivision.Camera:PostInit()	
	TheDivision.Modules:RegisterHooks( self, self.Hooks );
end;

function TheDivision.Camera:Setup( pos, ang )
	if( self.Data ) then
		if( self.Data.Set == false ) then
			local offsets = self.Config.Offset;
			local rotates = self.Config.Rotate;
			local offsetPos = pos;
			local rotateAng = ang;

			offsetPos = offsetPos + ang:Forward() * offsets.Forward;
			offsetPos = offsetPos + ang:Right() * offsets.Right;
			offsetPos = offsetPos + ang:Up() * offsets.Up;

			rotateAng.p = rotateAng.p + rotates.Pitch;
			rotateAng.y = rotateAng.y + rotates.Yaw;
			rotateAng.r = rotateAng.r + rotates.Roll;

			self:SetTargetPosition( offsetPos );
			self:SetTargetAngles( rotateAng );
			self.Data.Set = true;
		end;
	end;
end;