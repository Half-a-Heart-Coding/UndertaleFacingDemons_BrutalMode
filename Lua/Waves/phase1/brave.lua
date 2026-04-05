Arena.ResizeImmediate(160,16)
spawntime=0
require "Libraries/Playermove"
require "Libraries/hurt"
dir=0
rain={}
timer={}
colorknife={}
function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
if spawntime%20==0 then
   rand2=math.random(8)
   local knife = CreateProjectile("KnifeDown",-90+20*rand2,400)
   knife.SetVar("color","white")
   table.insert(rain,knife)
end
for i=1,#rain do
   local knife = rain[i]
   if knife.isactive and not timer[i] then
      knife.Move(0,-6)
   end
   if knife.y<24 and not timer[i] then
      timer[i]=0
   end
   if not timer[i] then
      elseif timer[i]<20 then
      timer[i]=timer[i]+1
      knife.sprite.alpha=1-0.05*timer[i]
      if timer[i]> 12 then
         knife.SetVar("color","none")
      end
      if timer[i]==20 then
         knife.Remove()
      end
   end
end
if spawntime%40==0 then
   rand1=math.random(2)
   if dir==0 then
      local knife = CreateProjectile("spear",230,0)
      knife.SetVar("x",-4)
      table.insert(colorknife,knife)
	knife.sprite.alpha=0
      if rand1==1 then
         knife.SetVar("color","blue")
         knife.sprite.color={0/255, 168/255, 242/255}
         else knife.SetVar("color","orange")
         knife.sprite.color={1,0.4,0}
      end
      knife.sprite.Scale(-1,1)
      dir=1
      else
      local knife = CreateProjectile("spear",-230,0)
      knife.SetVar("x",4)
      table.insert(colorknife,knife)
	knife.sprite.alpha=0
      if rand1==1 then
         knife.SetVar("color","blue")
         knife.sprite.color={0/255, 168/255, 242/255}
         else knife.SetVar("color","orange")
         knife.sprite.color={1,0.4,0}
      end
      dir=0
   end
end
for i=1,#colorknife do
   local knife = colorknife[i]
   local dir = knife.GetVar("x")
   if knife.isactive then
      knife.Move(dir,0)
   end
   local dist=math.abs(knife.x)
   if dist<200 then
	if dist>80 then
		local t=dist-80
		knife.sprite.alpha=math.cos(t*math.pi/240)
	end
	elseif dist>240 then
	knife.Remove()
   end
end
end
function OnHit(attack)
if ((attack.GetVar("color")=="orange" and not isMoving()) or (attack.GetVar("color")=="blue" and isMoving()) or attack.GetVar("color")=="white") and attack.isactive then
	KnifeHurt(1)
end
end