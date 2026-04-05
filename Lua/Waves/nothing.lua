spawntime=0
require "Libraries/Playermove"
function Update()
spawntime=spawntime+1
Arena.ResizeImmediate(565,130)
--Encounter.SetVar("Arena",Arena)
EndWave()
end