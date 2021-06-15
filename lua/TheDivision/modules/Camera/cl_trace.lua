TheDivision = TheDivision or {};
TheDivision.Camera = TheDivision.Camera or {};
TheDivision.Camera.Config = TheDivision.Camera.Config or {};
TheDivision.Camera.Data = TheDivision.Camera.Data or {};
TheDivision.Camera.Hooks = TheDivision.Camera.Hooks or {};

function TheDivision.Camera:GetTrace( endPos )
	local filter = ents.FindByClass( "prop_vehicle_*" );
	table.insert( filter, LocalPlayer() );
	local trace = {
		start = self:GetPosition(),
		endpos = endPos,
		filter = filter
	};
	trace = util.TraceLine( trace );
	--trace = util.QuickTrace( trace.start, ( endPos - trace.start ), filter );
	trace.EndPos = self:GetTargetPosition();
	
	return trace;
end;

function TheDivision.Camera:GetSegmentTrace( count )
	local pos = self:GetPosition();
	local ang = self:GetAngles();
	local target = self:GetTargetPosition();
	local dist = pos:Distance( target );
	local segmentLen = dist / count;

	
	for seg = 1, count do
		local traceData = {
			start = pos + ang:Forward() * seg,
			endpos = pos + ang:Forward() * ( seg + 1 ),
			filter = LocalPlayer()
		};

		local trace = util.TraceLine( traceData );
		trace.EndPos = target;
		return trace;
	end;
end;

function TheDivision.Camera:GetCollidePos()
	local trace = self:GetSegmentTrace( 4 );

	if( trace.Hit or trace.HitWorld ) then
		if( trace.HitPos ) then
			return trace.HitPos + self:GetAngles():Forward()-- * 20 ;
		end;
	end;
end;

function TheDivision.Camera:GetCrosshairPos()
	local client = LocalPlayer();
	local eyeTrace = client:GetEyeTrace();
	local camPos = self:GetPosition();
	local crossDist = -self.Config.Offset.Forward * 2;
	if( eyeTrace.Hit and eyeTrace.HitPos ) then
		local traceData = {
			start = camPos,
			endpos = eyeTrace.HitPos,
			filter = client
		};

		local trace = util.TraceLine( traceData );
		--trace = util.QuickTrace( traceData.start, -self:GetAngles():Forward(), {} );
		if( trace.HitPos ) then
			local traceDist = trace.HitPos:Distance( camPos );
			local crossDiff = math.abs( traceDist - crossDist );
			local crossPos = trace.HitPos - trace.Normal * ( crossDiff );
			return crossPos;
		end;
	end;
end;
