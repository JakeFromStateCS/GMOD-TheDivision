/*
	TheDivision
	Shared
	Commands
*/

TheDivision = TheDivision or {};
TheDivision.Commands = TheDivision.Commands or {};
TheDivision.Commands.Stored = TheDivision.Commands.Stored or {};

function TheDivision.Commands:Init()

end;

function TheDivision.Commands:PostInit()

end;

function TheDivision.Commands:Register( command, func, parentTab )
	if( self.Stored[command] == nil ) then
		local callback = function( client, cmd, args )
			func( parentTab, client, cmd, args );
		end;
		concommand.Add( "TheDivision_" .. parentTab.Index .. "_" .. command, callback );
	end;
end;

function TheDivision.Commands:RegisterCommands( parentIndex, commandTab )
	local parentTab = TheDivision[parentIndex];
	parentTab.Index = parentIndex;
	if( parentTab ) then
		for command,func in pairs( commandTab ) do
			self:Register( command, func, parentTab );
		end;
	end;
end;