surface.CreateFont( "TheDivision_BaseMenu_Title", {
	font = "Arial",
	size = 80,
	weight = 600
} );

surface.CreateFont( "TheDivision_BaseMenu_Title_Sub", {
	font = "Arial",
	size = 60,
	weight = 600
} );


surface.CreateFont( "TheDivision_BaseMenu_Version", {
	font = "Arial",
	size = 14,
	weight = 400
} );


local PANEL = {};

function PANEL:Init()
	if( TheDivision.Vgui.Panel ) then
		TheDivision.Vgui.CloseMenu();
	end;
	self:SetSize( ScrW(), ScrH() );
	self:SetPos( 0, 0 );
	self.Create = CurTime() + 0.75;
	self.MaxAlpha = 100;
	self.TitlePos = -100;

	self:SetTitle( "" );
	self.btnClose:SetVisible( false );
	self.btnMinim:SetVisible( false );
	self.btnMaxim:SetVisible( false );

	self.Grid = vgui.Create( "TheDivision_Grid", self );
	self.Grid:SetSize( self:GetWide() / 5, self:GetTall() );
	self.Grid:SetPos( self:GetWide() / 4 / 3, self:GetTall() / 3 );
	self.Buttons = {};
	self:SetupButtons();
	self:MakePopup();
	self:SetupCamera();

	self.OldRemove = self.Remove;

	function self.Remove()
		TheDivision.Camera.Data.Lock = false;
		TheDivision.Camera.Data.DrawClientOverlay = false;
		self:OldRemove();
	end;
end;

function PANEL:AddButton( buttonData )
	local text = buttonData.text;
	local callback = buttonData.callback;
	local pos = buttonData.position or { x = 0, y = 0 };
	local label = vgui.Create( "TheDivision_Button" );

	label:SetFont( "TheDivision_Button" );
	label:SetTextColor( Color( 255, 255, 255 ) );
	label:SetText( text );
	label:SetPos( pos.x, pos.y );
	label:SizeToContents();
	self.Grid:AddItem( label );
	if( buttonData.color ) then
		label:SetColor( buttonData.color );
	end;
	if( buttonData.linecolor ) then
		label:SetLineColor( buttonData.linecolor );
	end;
	if( buttonData.callback ) then
		label.OnMousePressed = function()
			callback( label );
		end;
	end;
	self.Buttons[text] = {
		text = text,
		callback = callback,
		label = label,
		position = pos,
		color = color,
		linecolor = linecolor
	};

	return self.Buttons[text];
end;

function PANEL:SetupCamera()
	local client = LocalPlayer();
	local eyePos = client:EyePos();
	local eyeAng = client:EyeAngles();
	local clientPos = client:GetPos();
	local clientAng = client:GetAngles();
	local camPos = TheDivision.Camera:GetPosition();
	local camAng = TheDivision.Camera:GetAngles();
	local tarPos = TheDivision.Camera:GetTargetPosition();
	local tarAng = TheDivision.Camera:GetTargetAngles();
	
	local targetAng = clientAng;
	targetAng.p = 0;
	targetAng.y = targetAng.y + 180;

	local targetPos = eyePos;
	targetPos = targetPos + targetAng:Forward() * TheDivision.Camera.Config.Offset.Forward;
	targetPos = targetPos + targetAng:Forward() * -10;
	targetPos.z = clientPos.z - 26 + 60;

	TheDivision.Camera:SetTargetPosition( targetPos );
	TheDivision.Camera:SetTargetAngles( targetAng );

	TheDivision.Vgui.Panel = self;
	TheDivision.Camera.Data.Lock = true;
	TheDivision.Camera.Data.DrawClientOverlay = true;
end;

function PANEL:Transition( buttons )
	--local buttons = newMenu.Buttons;
	if( buttons ) then
		self.Grid:ClearItems( function()
			for _,button in pairs( buttons ) do
				PrintTable( button );
				self:AddButton( button );
			end;
			self.Grid:SizeToContents();
		end );
	end;
end;

function PANEL:SetupButtons()
	self:AddButton( {
		callback = function()
			RunConsoleCommand( "cancelselect" );
		end,
		text = "Continue Game",
		color = Color( 50, 50, 50 ),
		linecolor = Color( 50, 50, 50 )
	} );

	self:AddButton( {
		callback = function( self )
			local parent = self:GetParent();
			local menu = parent:GetParent();
			parent:ClearItems( function()
				RunConsoleCommand( "TheDivision_Character_OpenMenu" );
				RunConsoleCommand( "cancelselect" );
			end );
		end,
		text = "Character Customization",
		color = Color( 50, 50, 50 ),
		linecolor = Color( 50, 50, 50 )
	} );

	self:AddButton( {
		callback = function()
			local buttons = TheDivision.Vgui:GetOptionsButtons();
			self:Transition( buttons );
			
			--RunConsoleCommand( "TheDivision_Character_OpenMenu" );
		end,
		text = "Options",
		color = Color( 50, 50, 50 ),
		linecolor = Color( 50, 50, 50 )
	} );

	self:AddButton( {
		callback = function()
			RunConsoleCommand( "disconnect" );
		end,
		text = "Quit",
		color = Color( 50, 50, 50 ),
		linecolor = Color( 50, 50, 50 )
	} );
	self.Grid:SizeToContents();
end;

function PANEL:Think()
	if( TheDivision == nil or TheDivision.Vgui == nil ) then
		RunConsoleCommand( "say", "Remove" );
		self:Remove();
	end;
	self:MoveToFront();
end;

function PANEL:OnMousePressed()
	local mouseX = gui.MouseX();
	local mouseY = gui.MouseY();
	/*
	for _,buttonData in pairs( self.Buttons ) do
		local position = buttonData.position;
		local panel = buttonData.label;
		--position = panel:GetPos();
		local w = panel:GetWide();
		local h = panel:GetTall();
		local dist = math.sqrt(
			( position.x - mouseX )^2 +
			( position.y - mouseY )^2
		);
		if( mouseX >= position.x ) then
			if( mouseX <= position.x + w ) then
				if( mouseY >= position.y ) then
					if( mouseY <= position.y + h ) then
						buttonData.callback();
						return;
					end;
				end;
			end;
		end;
	end;
	*/
end;

function PANEL:Paint( w, h )
	--local x, y = self:GetPos();
	--local w, h = self:GetWide(), self:GetTall();
	local percent = ( self.Create - CurTime() + 0.25 );
	local alpha = ( self.MaxAlpha * percent );
	local titlePos = self.TitlePos * percent;
	alpha = math.Clamp( alpha, 0, self.MaxAlpha );
	self.TitlePos = math.Clamp( self.TitlePos + 10, -100, 40 );

	surface.SetDrawColor( Color( 0, 0, 0 ) );
	surface.DrawRect( 0, 0, w, h );
	surface.SetDrawColor( Color( 20, 20, 20, self.MaxAlpha - alpha ) );
	surface.DrawRect( 0, 0, w, h );
	
	draw.SimpleText(
		"The Division",
		"TheDivision_BaseMenu_Title",
		w - 80,
		self.TitlePos,
		Color( 200, 100, 0 ),
		TEXT_ALIGN_RIGHT,
		TEXT_ALIGN_TOP
	);

	
	surface.SetFont( "TheDivision_BaseMenu_Title_Sub" );
	local subW, subH = surface.GetTextSize( "Alpha" );

	if( TheDivision.Version ) then
		draw.SimpleText(
			"v." .. TheDivision.Version .. " Alpha",
			"TheDivision_BaseMenu_Title_Sub",
			w - 80,
			self.TitlePos + 80,
			Color( 255, 255, 255 ),
			TEXT_ALIGN_RIGHT,
			TEXT_ALIGN_TOP
		);
	end;
end;
vgui.Register( "TD_Base_Menu", PANEL, "DFrame" );
