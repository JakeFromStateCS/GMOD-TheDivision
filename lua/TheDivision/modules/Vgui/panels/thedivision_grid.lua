/*
	TheDivision_Grid
	* Just vertical for now
*/
local prefix = "TheDivision_Grid ";
local PANEL = {};

function PANEL:Init()
	print( prefix .. "- 9: Init" );
	self.Items = {};
	self.MaxWidth = 0;
	self.MaxHeight = 0;
	self.TotalHeight = 0;
end;

function PANEL:AddItem( panel )
	self:SetupPanel( panel );	
	self:UpdateSize( panel );
	self:UpdatePos( panel );
	table.insert( self.Items, panel );
	
	return panel;
end;

function PANEL:RemoveItemID( panelID )
	local panel = self.Items[panelID];
	if( panel ) then
		panel:Remove();
		table.remove( self.Items, panelID );
		self.TotalHeight = 0;
		for id=panelID, #self.Items do
			panel = self.Items[id];
			if( panel ) then
				panel.ID = id;
				self:UpdateSize( panel );
			end;
		end;
		self:SetTall( self.TotalHeight );
	end;
end;

function PANEL:RemoveItem( panel )
	local id = panel.ID;
	if( id ) then
		if( self.Items[id] ) then
			table.remove( self.Items, id );
			for id=id, #self.Items do
				panel = self.Items[id];
				if( panel ) then
					panel.ID = id;
					self:UpdateSize( panel );
				end;
			end;
		end;
		panel:Remove( panel.Callback );
	end;
end;


function PANEL:ClearItems( callback )
	local len = #self.Items;
	for i = 0, len - 1, 1 do
 		local panel = self.Items[len - i];
 		if( panel.ID == 1 ) then
			panel.Callback = callback;
		end;
		self:RemoveItem( panel );
	end;
	--callback();
end;

function PANEL:SetupPanel( panel )
	local prevPanelIndex = #self.Items;
	panel.ID = prevPanelIndex + 1;
	panel:SetParent( self );
	panel:SetWide( self:GetWide() );

end;

function PANEL:UpdatePos( panel )
	local prevPanel = self.Items[panel.ID - 1];
	if( prevPanel ) then
		local x, y = prevPanel:GetPos();
		local newY = y + prevPanel:GetTall() + 4;
		panel:SetPos( x, newY )
	end;
end;

function PANEL:UpdateSize( panel )
 	self.MaxWidth = math.Max( self.MaxWidth, panel:GetWide() );
	self.TotalHeight = self.TotalHeight + panel:GetTall() + 4;
	panel:SetWide( self.MaxWidth );
end;

function PANEL:UpdatePanels()
	local len = #self.Items;
	for i = 0, len - 1, 1 do
 		local panel = self.Items[len - i];
		self:UpdateSize( panel );
		self:UpdatePos( panel );
	end;
end;

function PANEL:SizeToContents()
	self.TotalHeight = 0;
	
	local len = #self.Items;
	for i = 0, len - 1, 1 do
 		local panel = self.Items[len - i];
		panel.Update = false;
		self:UpdateSize( panel );
	end;
 	self:SetTall( self.TotalHeight );
	self:SetWide( self.MaxWidth );
	self:UpdatePanels();
end;

function PANEL:Think()
	for id, panel in pairs( self.Items ) do
		if( panel ) then
			if( !panel:IsValid() ) then
				--self:RemoveItem( id );
				return;
			end;
		else
			--self:RemoveItem( id );
			return;
		end;
	end;
end;

function PANEL:Paint( w, h )
	surface.SetDrawColor( Color( 20, 20, 20, 100 ) );
	surface.DrawRect( 0, 0, w, h );

	surface.SetDrawColor( Color( 0, 0, 0 ) );
	surface.DrawOutlinedRect( 0, 0, w, h );
end;
vgui.Register( "TheDivision_Grid", PANEL );