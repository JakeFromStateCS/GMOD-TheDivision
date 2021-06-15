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
	TheDivision.Vgui.CloseMenu();
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
	self.Grid:SizeToContents();
	self:MakePopup();
	self:SetupCamera();
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
	targetPos = targetPos - targetAng:Forward() * 15;

	targetPos = targetPos - targetAng:Right() * 10;
	
	targetPos.z = clientPos.z - 20 + 60;

	TheDivision.Camera:SetTargetPosition( targetPos );
	TheDivision.Camera:SetTargetAngles( targetAng );

	TheDivision.Character.Panel = self;
	TheDivision.Camera.Data.Lock = true;
	TheDivision.Camera.Data.DrawClientOverlay = true;
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

function PANEL:AddCycler( cyclerData )
	local text = cyclerData.text;
	local callback = cyclerData.callback;
	local pos = cyclerData.position or { x = 0, y = 0 };
	local label = vgui.Create( "TheDivision_Cycler" );

	label:SetFont( "TheDivision_Button" );
	label:SetTextColor( Color( 255, 255, 255 ) );
	label:SetText( text );
	label:SetPos( pos.x, pos.y );
	label:SizeToContents();
	self.Grid:AddItem( label );
	if( cyclerData.color ) then
		label:SetColor( cyclerData.color );
	end;
	if( cyclerData.linecolor ) then
		label:SetLineColor( cyclerData.linecolor );
	end;
	if( cyclerData.callback ) then
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
		callback = function( self )
			surface.PlaySound( "buttons/button9.wav" );
			local parent = self:GetParent();
			local menu = parent:GetParent();
			surface.PlaySound( "buttons/button24.wav" );
			parent:ClearItems( function()
				gui.ActivateGameUI()
				--RunConsoleCommand( "TheDivision_Character_CloseMenu" );
				
			end );
			
		end,
		text = "Character Customization",
		color = Color( 170, 70, 0 ),
		linecolor = Color( 230, 100, 20 )
	} );

	--Gender Button
	self:AddButton( {
		callback = function()
			local parent = self:GetParent();
			local menu = self;
			local buttons = TheDivision.Character:GetGenderButtons();
			self:Transition( buttons );
		end,
		text = "Gender",
		color = Color( 50, 50, 50 ),
		linecolor = Color( 50, 50, 50 )
	} );
	

	self:AddButton( {
		callback = function()
			RunConsoleCommand( "TheDivision_Character_CloseMenu" );
		end,
		text = "Close",
		color = Color( 50, 50, 50 ),
		linecolor = Color( 50, 50, 50 )
	} );

	self:AddCycler( {
		callback = function()
			RunConsoleCommand( "TheDivision_Character_CloseMenu" );
		end,
		text = "Close",
		color = Color( 50, 50, 50 ),
		linecolor = Color( 50, 50, 50 )
	} );
	
	self.Grid:SizeToContents();
end;

function PANEL:Think()
	if( TheDivision == nil or TheDivision.Vgui == nil ) then
		--self:Remove();
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
		"",
		"TheDivision_BaseMenu_Title",
		w - 80,
		self.TitlePos,
		Color( 200, 100, 0 ),
		TEXT_ALIGN_RIGHT,
		TEXT_ALIGN_TOP
	);
end;
vgui.Register( "TD_Character_Menu", PANEL, "DFrame" );
