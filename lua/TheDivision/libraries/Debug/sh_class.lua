/*
	TheDivision Debug
	  Shared Library
	   sh_init.lua

TheDivision = TheDivision or {};
TheDivision.Debug = TheDivision.Debug or {};

local totalTime = 0;
local totalRuns = 10;

print( "=====Testing Start=====" );
local time = SysTime();

for i = 1, totalRuns do
	local proper = string.Proper( tostring( i ) );
end;
print( "     Testing Done    ");
local finTime = SysTime();
local runTime = finTime - time;
totalTime = totalTime + runTime;
print( "=====Test Results=====")
print( "Time: " .. string.sub( tostring( finTime - time ), 1, 8 ) );
*/
