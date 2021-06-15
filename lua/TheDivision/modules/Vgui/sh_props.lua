if( Props ) then
	if( Props.GhostEnt ) then
		Props.GhostEnt:Remove();
	end;
end;
Props = {};
Props.Config = {};
Props.Config.Models = {
	["models/props_borealis/bluebarrel001.mdl"] = true,
	["models/props_interiors/vendingmachinesoda01a_door.mdl"] = true,
	["models/props_c17/shelfunit01a.mdl"] = true,
	["models/props_c17/furnituretable001a.mdl"] =  true,
	["models/props_c17/furnituredrawer001a_chunk05.mdl"] =  true,
	["models/props_c17/furnituredrawer001a_chunk06.mdl"] = true,
	["models/props_c17/furnituredrawer002a.mdl"] =  true,
	["models/props_junk/wood_crate002a.mdl"] =  true,
	["models/props_junk/wood_pallet001a.mdl"] = true,
	["models/props_junk/cardboard_box001a.mdl"] =  true,
	["models/props_junk/wood_crate001a.mdl"] =  true,
	["models/props_c17/furnituredrawer003a.mdl"] =  true,
	["models/props_lab/blastdoor001a.mdl"] = 	 true,
	["models/props_lab/blastdoor001c.mdl"] = 	 true,
	["models/props_c17/furnituredrawer001a.mdl"] = true,
	["models/props_c17/furniturecupboard001a.mdl"] = true,
	["models/props_c17/furnituredresser001a.mdl"] =  true,
	["models/props_c17/furnituretable002a.mdl"] =  true,
	["models/props_borealis/borealis_door001a.mdl"] = true,
	["models/props_borealis/mooring_cleat01.mdl"] =  true,
	["models/props_c17/furniturebathtub001a.mdl"] =  true,
	["models/props_c17/furniturebed001a.mdl"] =  true,
	["models/props_c17/furniturewashingmachine001a.mdl"] =  true,
	["models/props_debris/metal_panel02a.mdl"] =  true,
	["models/props_debris/metal_panel01a.mdl"] =  true,
	["models/props_interiors/radiator01a.mdl"] = true,
	["models/props_interiors/refrigerator01a.mdl"] =  true,
	["models/props_interiors/refrigeratordoor01a.mdl"] = true,
	["models/props_interiors/refrigeratordoor02a.mdl"] = true,
	["models/props_junk/trashdumpster02.mdl"] =  true,
	["models/props_junk/trashdumpster01a.mdl"] =  true,
	["models/props_wasteland/kitchen_counter001c.mdl"] = true,
	["models/props_wasteland/kitchen_counter001a.mdl"] = true,
	["models/props_wasteland/kitchen_counter001b.mdl"] = true,
	["models/props_wasteland/kitchen_counter001d.mdl"] = true,
	["models/props_c17/fence01a.mdl"] = 	 true,
	["models/props_c17/fence01b.mdl"] = 	 true,
	["models/props_c17/fence02a.mdl"] = 	 true,
	["models/props_c17/fence02b.mdl"] = 	 true,
	["models/props_c17/fence03a.mdl"] = 	 true,
	["models/props_c17/fence04a.mdl"] = 	 true,
	["models/props_c17/furniturestove001a.mdl"] =  true,
	["models/props_c17/concrete_barrier001a.mdl"] = true,
	["models/props_wasteland/medbridge_post01.mdl"] =  true,
	["models/props_c17/furniturecouch001a.mdl"] = true,
	["models/props_c17/furniturecouch002a.mdl"] = true,
	["models/props_combine/breendesk.mdl"] = true,
	["models/props_interiors/sinkkitchen01a.mdl"] = true,
	["models/props_lab/kennel_physics.mdl"] = true,
	["models/props_lab/filecabinet02.mdl"] = true,
	["models/props_trainstation/trainstation_clock001.mdl"] = true,
	["models/props_wasteland/barricade001a.mdl"] =  true,
	["models/props_wasteland/barricade002a.mdl"] =  true,
};
Props.Hooks = {};
Props.Nets = {};

function Props:GetSpawnPos( client, ent )
	Props.Config.Rotate = false;
	ent.corner = nil;
	local entMin = ent:OBBMins();
	local entMax = ent:OBBMaxs();
	local trace = client:GetEyeTrace();
	local ang = Angle( 0, client:GetAngles().y + 180, 0 );
	local pos = trace.HitPos - Vector( 0, 0, entMin.z );
	if( client:KeyDown( IN_SPEED ) ) then
		ang.y = math.Round( ang.y / 90 ) * 90;
	end;
	local max = math.max( math.abs( entMin.x ), math.abs( entMin.y ) );
	local propTab = ents.FindInSphere( pos, max );
	
	for _,prop in pairs( propTab ) do
		if( prop:GetClass() == "prop_physics" ) then
			local min = prop:OBBMins();
			local max = prop:OBBMaxs();
			local dist = prop:GetPos():Distance( Vector( min.x, min.y, 0 ) );
			local propPos = prop:GetPos() + Vector( 0, 0, min.z - entMin.z );
			local propAng = prop:GetAngles();
			local localPos = prop:WorldToLocal( pos );
			local yawDiff = ( propAng - ang ).y;
			if( localPos.y > 0 ) then
				if( ang.y % 90 ~= 0 ) then
					ang = propAng;
				end;
				pos = propPos + ang:Right() * entMin.y + prop:GetRight() * min.y;
			elseif( localPos.y < 0 ) then
				if( ang.y % 90 ~= 0 ) then
					ang = propAng;
				end;
				pos = propPos - ang:Right() * entMin.y - prop:GetRight() * min.y;
			else
				--pos = propPos;
			end;
			if( yawDiff == -90 ) then
				pos = propPos + prop:GetRight() * min.y;
				if( client:KeyDown( IN_ATTACK ) ) then
					pos = pos - ang:Right() * entMin.y;
				elseif( client:KeyDown( IN_ATTACK2 ) ) then
					pos = pos + ang:Right() * entMin.y;
				else
					pos = pos - ang:Right() * entMin.y;
				end;
				Props.Config.Rotate = true;
			elseif( yawDiff == -270 ) then
				pos = propPos - prop:GetRight() * min.y;
				if( client:KeyDown( IN_ATTACK ) ) then
					pos = pos - ang:Right() * entMin.y;
				elseif( client:KeyDown( IN_ATTACK2 ) ) then
					pos = pos + ang:Right() * entMin.y;
				else
					pos = pos - ang:Right() * entMin.y;
				end;
				Props.Config.Rotate = true;
			elseif( yawDiff == 90 ) then
				pos = propPos - prop:GetRight() * min.y;
				if( client:KeyDown( IN_ATTACK ) ) then
					pos = pos - ang:Right() * entMin.y;
				elseif( client:KeyDown( IN_ATTACK2 ) ) then
					pos = pos + ang:Right() * entMin.y;
				else
					pos = pos - ang:Right() * entMin.y;
				end;
				Props.Config.Rotate = true;
			end;
			ent.corner = prop;
			break;
		end;
	end;
	return {
		["pos"] = pos,
		["ang"] = ang
	};
end;

if( SERVER ) then
	util.AddNetworkString( "Props_NetMsg" );
	
	function Props.Nets:Spawn()
		local client = net.ReadEntity();
		local model = net.ReadString();
		if( Props.Config.Models[model] ) then
			local ent = ents.Create( "prop_physics" );
			ent:SetModel( model );
			local tab = Props:GetSpawnPos( client, ent );
			ent:SetAngles( tab.ang );
			ent:SetPos( tab.pos );
			ent:Spawn();
			local phys = ent:GetPhysicsObject();
			if( phys:IsValid() ) then
				phys:EnableMotion( false );
				ent:SetNWInt( "Health", phys:GetMass() );
			end;
		end;
	end;

	function Props.Hooks.EntityTakeDamage( ent, dmgInfo )
		local attacker = dmgInfo:GetAttacker();
		local damage = dmgInfo:GetDamage();
		local health = ent:GetNWInt( "Health" );
		if( health > 0 ) then
			health = health - damage;
			if( health - damage <= 0 ) then
				ent:Remove();
			else
				ent:SetNWInt( "Health", health );
			end;
		end;
	end;
	hook.Add( "EntityTakeDamage", "Props.EntityTakeDamage", Props.Hooks.EntityTakeDamage );
	
	function Props.Nets:NetReceive()
		local func = net.ReadString();
		if( Props.Nets[func] ) then
			Props.Nets[func]();
		end;
	end;
	net.Receive( "Props_NetMsg", Props.Nets.NetReceive );
else
	function Props:Spawn( model )
		self.Nets:Spawn( model );
		surface.PlaySound( "buttons/button14.wav" );
	end;
	
	function Props:Ghost( model )
		if( Props.GhostEnt ) then
			if( Props.GhostEnt:IsValid() ) then
				Props.GhostEnt:SetModel( model );
				Props.GhostEnt:SetRenderMode( 1 );
				Props.GhostEnt:SetColor( Color( 255, 255, 255, 150 ) );
			else
				Props.GhostEnt = ClientsideModel( model, RENDERGROUP_TRANSLUCENT );
				Props:Ghost( model );
			end;
		else
			Props.GhostEnt = ClientsideModel( model, RENDERGROUP_TRANSLUCENT );
			Props.GhostEnt:SetModel( model );
			Props.GhostEnt:SetRenderMode( 1 );
			Props.GhostEnt:SetColor( Color( 255, 255, 255, 150 ) );Props.GhostEnt:SetModel( model );
			Props.GhostEnt:SetRenderMode( 1 );
			Props.GhostEnt:SetColor( Color( 255, 255, 255, 150 ) );
		end;
	end;
	
	function Props.Hooks.KeyPress( client, key )
		if( client == LocalPlayer() ) then
			if( key == IN_USE ) then
				if( Props.GhostEnt ) then
					Props:Spawn( Props.GhostEnt:GetModel() );
					--Props.GhostEnt:Remove();
					--Props.GhostEnt = nil	
				end;
			elseif( key == IN_RELOAD ) then
				if( Props.GhostEnt ) then
					Props.GhostEnt:Remove();
					Props.GhostEnt = nil	
				end;
			end;
		end;
	end;
	hook.Add( "KeyPress", "Props.KeyPress", Props.Hooks.KeyPress );
	
	function Props.Hooks:Think()
		if( Props.GhostEnt ) then
			if( Props.GhostEnt:IsValid() ) then
				--local trace = LocalPlayer():GetEyeTrace();
				--local ang = Angle( 0, LocalPlayer():GetAngles().y + 180, 0 ); 
				--local ghostMin = Props.GhostEnt:OBBMins();
				--local ghostMax = Props.GhostEnt:OBBMaxs();
				local tab = Props:GetSpawnPos( LocalPlayer(), Props.GhostEnt );
				Props.GhostEnt:SetPos( tab.pos );
				Props.GhostEnt:SetAngles( tab.ang );
			end;
		end;
	end;
	hook.Add( "Think", "Props.Think", Props.Hooks.Think );

	function Props.Hooks:HUDPaint()
		if( Props.Config.Rotate ) then
			if( Props.GhostEnt ) then
				if( Props.GhostEnt:IsValid() ) then
					local ent = Props.GhostEnt;
					local pos = ent:GetPos();
					local scr = pos:ToScreen();
					local size = 100;
					local mouseSize = {
						w = 50,
						h = 100
					};
					local padding = 2;
					if( ent.corner ) then
						if( ent.corner:IsValid() ) then
							pos = ent.corner:GetPos();
							scr = pos:ToScreen();
							scr.x = scr.x - size / 2;
							scr.y = scr.y - size / 2;
						end;
					end;
					--( pos - Vector( 0, ent:OBBMins().y, 0 ) ):ToScreen();
					--surface.SetDrawColor( Color( 0, 0, 0, 200 ) );
					--surface.DrawRect( scr.x, scr.y, size, size );
					draw.RoundedBox( 8, scr.x, scr.y, mouseSize.w, mouseSize.h, Color( 0, 0, 0 ) );
					draw.RoundedBox( 8, scr.x + padding, scr.y + padding, mouseSize.w - padding * 2, mouseSize.h - padding * 2, Color( 255, 255, 255 ) );
					draw.RoundedBox( 4, scr.x + padding, scr.y + padding, mouseSize.w - padding * 2, mouseSize.h / 3 - padding * 2, Color( 0, 0, 0 ) );
					if( !LocalPlayer():KeyDown( IN_ATTACK2 ) ) then
						draw.RoundedBox( 4, scr.x + mouseSize.w / 2 + padding, scr.y + padding * 2, mouseSize.w / 2 - padding * 2, mouseSize.h / 3 - padding * 4, Color( 255, 0, 0 ) );
						draw.RoundedBox( 4, scr.x + padding * 2, scr.y + padding * 2, mouseSize.w / 2 - padding * 2, mouseSize.h / 3 - padding * 4, Color( 255, 255, 255 ) );
					else
						draw.RoundedBox( 4, scr.x + mouseSize.w / 2 + padding, scr.y + padding * 2, mouseSize.w / 2 - padding * 2, mouseSize.h / 3 - padding * 4, Color( 255, 255, 255 ) );
						draw.RoundedBox( 4, scr.x + padding * 2, scr.y + padding * 2, mouseSize.w / 2 - padding * 2, mouseSize.h / 3 - padding * 4, Color( 255, 0, 0 ) );
					end;
					--draw.SimpleText( "Right Mouse: Corner Right", "ChatFont", scr.x, scr.y, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
				end;
			end;
		end;
		local trace = LocalPlayer():GetEyeTrace();
		local ent = trace.Entity;
		if( ent ) then
			if( ent:IsValid() ) then
				if( ent:GetClass() == "prop_physics" ) then
					local health = ent:GetNWInt( "Health" );
					local pos = ent:GetPos() + ent:OBBCenter();
					local scrPos = pos:ToScreen();
					local physObj = ent:GetPhysicsObject();
					local max = 100;
					local width = 150;
					if( physObj:IsValid() ) then
						max = physObj:GetMass();
					end;
					surface.SetDrawColor( Color( 255, 150, 150 ) );
					surface.DrawRect( scrPos.x - width * ( health / max ) / 2, scrPos.y + 10, width * ( health / max ), 20 );
					draw.SimpleText( health, "ChatFont", scrPos.x, scrPos.y, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
				end;
			end;
		end;
	end;
	hook.Add( "HUDPaint", "Props.HUDPaint", Props.Hooks.HUDPaint );

	function Props.Hooks:OnContextMenuOpen()
		if( Props.Menu ) then
			Props.Menu:Remove();
		end;
		Props.Menu = vgui.Create( "Spawn_Menu" );
	end;
	hook.Add( "OnContextMenuOpen", "Props.OnContextMenuOpen", Props.Hooks.OnContextMenuOpen );
	
	function Props.Hooks:OnContextMenuClose()
		if( Props.Menu ) then
			Props.Menu:Remove();
			Props.Menu = nil;
		end;
	end;
	hook.Add( "OnContextMenuClose", "Props.OnContextMenuClose", Props.Hooks.OnContextMenuClose );
	
	function Props.Nets:Spawn( model )
		net.Start( "Props_NetMsg" );
			net.WriteString( "Spawn" );
			net.WriteEntity( LocalPlayer() );
			net.WriteString( model );
		net.SendToServer();	
	end;
end;