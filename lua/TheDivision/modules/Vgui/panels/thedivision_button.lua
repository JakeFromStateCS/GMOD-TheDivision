/*
	TheDivision Button
*/
surface.CreateFont( "TheDivision_Button", {
	font = "Arial",
	size = 26,
	weight = 400
} );

local PANEL = {};

function PANEL:Init()
	self.Font = "TheDivision_Button";
	self.Text = "";
	self.TextColor = Color( 255, 255, 255 );
	self.BGColor = Color( 170, 70, 0 );
	self.LineColor = Color( 230, 100, 20, 0 );
	self.Padding = {
		t = 10,
		b = 10,
		l = 5,
		r = 5
	};
	self.OldRemove = self.Remove;
	self.RemoveDelay = 0.3;
	function self:Remove( callback )
		self.RemoveTime = CurTime();
		--self:SetParent();
		self:MoveToFront();
		timer.Simple( self.RemoveDelay, function()
			if( callback ) then
				callback();
			end;
			self:OldRemove();
		end );
	end;
end;

function PANEL:SetFont( font )
	self.Font = font;
end;

function PANEL:SetText( text )
	self.Text = text;
end;

function PANEL:SetTextColor( color )
	self.TextColor = color;
end;

function PANEL:SetColor( color )
	self.BGColor = color;
end;

function PANEL:SetLineColor( color )
	self.LineColor = color;
end;

function PANEL:SizeToContents()
	local parent = self:GetParent();
	surface.SetFont( self.Font );
	local w, h = surface.GetTextSize( self.Text );
	local padding = self.Padding;
	self:SetSize(
		w + ( padding.l + padding.r ),
		h + ( padding.t + padding.b )
	);

	--self:SetWide( 300 );
end;

function PANEL:OnCursorEntered()
	if( self.OldColor == nil ) then
		self.OldColor = self.BGColor;
	end;
	if( self.OldLineColor == nil ) then
		self.OldLineColor = self.LineColor;
	end;
	self:SetColor( Color( 170, 70, 0 ) );
	self:SetLineColor( Color( 230, 100, 20 ) );
end;

function PANEL:OnCursorExited()
	local color = self.OldColor or Color( 50, 50, 50 );
	local lineCol = self.OldLineColor or Color( 50, 50, 50 );
	self:SetColor( color );
	self:SetLineColor( lineCol );
	self.OldColor = nil;
	self.OldLineColor = nil;
end;

function PANEL:Think()
	local parent = self:GetParent();
	if( parent ) then
		local updateReady = parent.Update;
		if( updateReady and !self.Update ) then
			self:SetWide( parent:GetWide() );
			self.Update = true;
		elseif( self.Update ) then

		end;
	end;
end;

function PANEL:Paint( w, h )
	local percent = 1;
	local targetPerc = 1.5;
	local maxPercent = 1.5;
	local rate = ( targetPerc - percent ) / self.RemoveDelay / 10;
	local thing2 = 0;
	if( self.RemoveTime ) then
		local target = self.RemoveTime + self.RemoveDelay;
		local diff = target - CurTime();
		thing2 = 1 - diff / self.RemoveDelay
		local thing = ( targetPerc - percent ) / self.RemoveDelay;
		
		percent = targetPerc - thing * diff;
		DisableClipping( true );
	end;
	local x, y = self:GetPos();
	w = w * percent;
	h = h * percent;
	x = x * percent;
	y = y * percent;

	local alpha = math.Clamp( 255 - 255 * thing2, 0, 255 );
	self.BGColor.a = alpha
	self.LineColor.a =alpha;
	surface.SetDrawColor( self.BGColor );
	surface.DrawRect( 0, 4, w, h - 4 );

	surface.SetDrawColor( self.LineColor );
	surface.DrawRect( 0, 0, w, 4 );

	if( self.LineColor != self.BGColor ) then
		surface.SetDrawColor( Color( 0, 0, 0 ) );
		surface.DrawRect( 0, 4, w, 4 );
	end;


	surface.SetDrawColor( Color( 200, 200, 200 ) );
	local debugSize = 8;
	for i=0, 1 do
		for k=0, 1 do
			surface.DrawRect(
				--X
				i * w - debugSize / 2,
				--Y
				k * h - debugSize / 2,
				--W
				debugSize,
				--H
				debugSize
			);
		end;
	end;

	draw.SimpleText(
		self.Text,
		self.Font,
		w / 2,
		h / 2 + 2,
		self.TextColor,
		TEXT_ALIGN_CENTER,
		TEXT_ALIGN_CENTER
	);

	if( self.RemoveTime ) then
		DisableClipping( false )
	end;
end;

function PANEL:OnMousePressed()
	--
end;
vgui.Register( "TheDivision_Button", PANEL );