local PANEL = {};

function PANEL:Init()
	print( "Triangle" );
	self.Triangle = {
		{ x = 2, y = 1 },
		{ x = 2, y = 2 },
		{ x = 1, y = 1.5 }
	};
	setmetatable( self.Triangle, {
		__mul = function( op1, op2 )
			local newTri = {};
			local x, y = self:GetPos();
			for index,vec2D in pairs( op1 ) do
				local newVec = {};
				for key,num in pairs( vec2D ) do
					local newNum = num * op2;
					vec2D[key] = num * op2;
					newVec[key] = newNum;
					op1[index] = vec2D;
				end;
				vec2D.x = vec2D.x + x;
				vec2D.y = vec2D.y + y;
				table.insert( newTri, newVec );
			end;
			return newTri;
		end,
		__add = function( op1, op2 )
			local newTri = {};
			for index,vec2D in pairs( op1 ) do
				local newVec = {};
					vec2D[1] = vec2D[1] + op2.x;
					vec2D[2] = vec2D[2] + op2.y;
					newVec[1] = newVec[1] + op2.x;
					newVec[2] = newVec[2] + op2.y;
					
					op1[index] = vec2D;
				table.insert( newTri, newVec );
			end;
			return newTri;
		end
	} );

end;

function PANEL:UpdateTrianglePos()
	local x, y = self:GetPos();
	local size = self:GetTall() / 2;
	--self.Triangle = self.Triangle + 1;
end;

function PANEL:SetTriangleSize( size )
	local parent = self:GetParent();
	self.Triangle = self.Triangle * size;
	self:SetSize( size * 2, size * 2 );
	self:UpdateTrianglePos();
end;

function PANEL:Paint( w, h )
	surface.SetDrawColor( Color( 170, 70, 0 ) )
		draw.NoTexture()
	--surface.DrawPoly( self.Triangle )
end;
vgui.Register( "TheDivision_CyclerButton", PANEL );
