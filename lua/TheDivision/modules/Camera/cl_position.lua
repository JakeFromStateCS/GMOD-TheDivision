TheDivision = TheDivision or {};
TheDivision.Camera = TheDivision.Camera or {};
TheDivision.Camera.Config = TheDivision.Camera.Config or {};
TheDivision.Camera.Data = TheDivision.Camera.Data or {};

/*
	Get/Set Pos
	Get/Set Angles
*/
--TheDivision.Camera:SetPosition( Vector/pos )
function TheDivision.Camera:SetPosition( pos )
	self.Data.CurrentPos = pos;
end;

function TheDivision.Camera:GetPosition()
	return self.Data.CurrentPos;
end;

function TheDivision.Camera:SetAngles( ang )
	self.Data.CurrentAng = ang;
end;

function TheDivision.Camera:GetAngles()
	return self.Data.CurrentAng;
end;


/*
	Get/Set TargetPos
	Get/Set TargetAng
*/
function TheDivision.Camera:SetTargetPosition( pos )
	self.Data.TargetPos = pos;
end;

function TheDivision.Camera:GetTargetPosition()
	return self.Data.TargetPos;
end;

function TheDivision.Camera:SetTargetAngles( ang )
	self.Data.TargetAng = ang;
end;

function TheDivision.Camera:GetTargetAngles()
	return self.Data.TargetAng;
end;