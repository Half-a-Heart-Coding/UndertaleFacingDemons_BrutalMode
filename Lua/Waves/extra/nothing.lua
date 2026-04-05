spawntime=0
require "Libraries/Playermove"
function Update()
spawntime=spawntime+1
Moving()
if spawntime>150 then
	Arena.ResizeImmediate(565,130)
	Encounter.SetVar("Arena",Arena)
	EndWave()
end
end