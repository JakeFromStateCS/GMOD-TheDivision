TheDivision = TheDivision or {};
TheDivision.Camera = TheDivision.Camera or {};
TheDivision.Camera.Config = TheDivision.Camera.Config or {};
TheDivision.Camera.Data = TheDivision.Camera.Data or {};
TheDivision.Camera.Hooks = TheDivision.Camera.Hooks or {};


function TheDivision.Camera:UpdateTargetPosition( pos )
	if( self.Data ) then
		--We don't update the position
		--If we lock the position
		--That way we can manually set 
		--The camera position for menus
		if( self.Data.Lock == true ) then
			return;
		else
			local offsets = self.Config.Offset;
			local offsetPos = pos;
			local ang = self:GetTargetAngles();
			local vehicle = LocalPlayer():GetVehicle();

			offsetPos = offsetPos + ang:Forward() * offsets.Forward;
			offsetPos = offsetPos + ang:Right() * offsets.Right;
			offsetPos = offsetPos + ang:Up() * offsets.Up;
			if( self.Data.Duck ) then
				TheDivision.Debug:Print( {
					Color = Color( 180, 180, 255 ),
					Text = "Before:",
					TextColor = Color( 255, 150, 0 ),
					Type = "Category",
				} );
				TheDivision.Debug:Print( {
					Text = offsetPos.z
				} );
				offsetPos = offsetPos + ang:Up() * self.Config.Duck.Up;
				offsetPos = offsetPos + ang:Forward() * self.Config.Duck.Forward;
				TheDivision.Debug:Print( {
					Color = Color( 180, 180, 255 ),
					Text = "After:",
					TextColor = Color( 255, 150, 0 ),
					Type = "Category",
				} );
				TheDivision.Debug:Print( {
					Text = offsetPos.z
				} );
			end;
			if( vehicle ) then
				if( vehicle:IsValid() ) then
					offsetPos = offsetPos - ang:Forward() * 100;
				end;
			end;
			local trace = self:GetTrace( offsetPos );
			if( trace.Hit ) then
				if( trace.HitPos ) then
					offsetPos = trace.HitPos + ang:Forward() * 10;
				end;
			end;
			self:SetTargetPosition( offsetPos );
		end;
	end;
end;

function TheDivision.Camera:UpdateTargetAngles( ang )
	if( self.Data ) then
		--We don't update the position
		--If we lock the position
		--That way we can manually set 
		--The camera position for menus
		if( self.Data.Lock == true ) then
			--return;
		else
			local rotates = self.Config.Rotate;
			local rotateAng = ang;


			rotateAng.p = rotateAng.p + rotates.Pitch;
			rotateAng.y = rotateAng.y + rotates.Yaw;
			rotateAng.r = rotateAng.r + rotates.Roll;
			self:SetTargetAngles( rotateAng );
		end;
	end;
end;

function TheDivision.Camera:UpdateTargetFOV( fov )
	if( self.Data ) then
		--We don't update the position
		--If we lock the position
		--That way we can manually set 
		--The camera position for menus
		if( self.Data.Lock == true ) then
			return;
		else
			self.Data.FOV = fov;
		end;
	end;
end;


function TheDivision.Camera:LerpPosition()
	if( self.Data.Lock == true ) then
		--return;
	end;
	local maxRate = self.Config.Lerp.Max.Position;
	local currPos = self:GetPosition();
	local currAng = self:GetAngles();
	local targetPos = self:GetTargetPosition();
	local newPos = LerpVector( maxRate, currPos, targetPos );
	
	self:SetPosition( newPos );
end;

function TheDivision.Camera:LerpAngles()
	if( self.Data.Lock == true ) then
		--return;
	end;
	local maxRate = self.Config.Lerp.Max.Angles;
	local currAng = self:GetAngles();
	local targetAng = self:GetTargetAngles();
	local newAngle = LerpAngle( maxRate, currAng, targetAng );

	self:SetAngles( newAngle );
end;