Arena.ResizeImmediate(160,80)
Player.MoveTo(0,-20)
spawntime=0
safe=0
rain={}
local damage=1
require "Libraries/Playermove"
require "Libraries/hurt"
function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
if spawntime%150==0 then
   if safe==0 then
      for i=1,4 do
         local knife = CreateProjectile("KnifeDown",-110+40*i,360)
         knife.SetVar("color","white")
         table.insert(rain,knife)
      end
      safe=1
      else
      for i=1,4 do
         local knife = CreateProjectile("KnifeDown",-90+40*i,360)
         knife.SetVar("color","white")
         table.insert(rain,knife)
      end
      safe=0
   end
end
for i=1,#rain do
   local knife = rain[i]
   if knife.isactive then
      knife.Move(0,-3)
   end
   if knife.y<-284 then
      knife.Remove()
   end
end
end
function OnHit(attack)
if attack.GetVar("color")=="white" then
	KnifeHurt(1)
end
end