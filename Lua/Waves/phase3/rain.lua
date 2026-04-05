Arena.ResizeImmediate(160,80)
Player.MoveTo(0,-20)
spawntime=0
safe=0
rain={}
rain2={}
local damage=1
require "Libraries/Playermove"
require "Libraries/hurt"
local j = 1
local jGoingUp = 1
spawnTimerDelay = 45
function Update()
HurtUpd(900)
Moving()
spawntime=spawntime+1
if spawntime%35==0 then
   if safe==0 then
      for i=1,4 do
         local knife = CreateProjectile("KnifeDown",-110+40*i,300)
         knife.SetVar("color","white")
         table.insert(rain,knife)
	 knife.sprite.alpha=0
	 knife.SetVar("time",0)
      end
      safe=1
      else
      for i=1,4 do
         local knife = CreateProjectile("KnifeDown",-90+40*i,300)
         knife.SetVar("color","white")
         table.insert(rain,knife)
	 knife.sprite.alpha=0
	 knife.SetVar("time",0)
      end
      safe=0
   end
   j = j + jGoingUp
   if j > 7 then
    jGoingUp = -1
   end
   if j < 2 then
    jGoingUp = 1
   end
    local knife = CreateProjectile("KnifeUp",-90+20*j,-100)
         knife.SetVar("color","white")
         table.insert(rain2,knife)
	 knife.sprite.alpha=0
	 knife.SetVar("time",0)
end
for i=1,#rain do
   local knife = rain[i]
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
   if knife.isactive then
      knife.Move(0,-6)
   end
   if knife.y<-300 then
      knife.Remove()
   end
end
for i=1,#rain2 do
   local knife = rain2[i]
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
   if knife.isactive then
      knife.Move(0,4)
   end
   if knife.y>200 then
      knife.Remove()
   end
end
end
function OnHit(attack)
if attack.GetVar("color")=="white" then
	KnifeHurt(1)
end
end