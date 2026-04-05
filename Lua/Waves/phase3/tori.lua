Arena.ResizeImmediate(200,200)
collision = require "Libraries/rotational_collision"
require "Libraries/colortoys"
require "Libraries/Playermove"
require "Libraries/hurt"
Player.SetControlOverride(true)
spears={}
knifes1={}
knifes2={}
timer={}
timr={}
angle={}
DoGhost("Toriel_Sprite",1,600)
spawntime=0
BR=CreateProjectile("system/BR",209.5,-125)
function Update()
HurtUpd(600)
Moving()
hue=0.90-0.1*math.sin(math.pi*spawntime/30)
BR.sprite.color ={1*hue,0.5*hue,0.15234375*hue}
if not GetGlobal("burn") then
	else 
	Player_speedx=2+2*math.sin(GetGlobal("burn")*math.pi/100)
	Player_speedy=2+2*math.sin(GetGlobal("burn")*math.pi/100)
end
if spawntime % 200<4 then
   local knife1=CreateProjectile("KnifeLeft",200,90-50*spawntime%200)
   local knife2=CreateProjectile("KnifeRight",-200,70-50*spawntime%200)
   table.insert(knifes1,knife1)
   table.insert(knifes2,knife2)
   knife1.SetVar("color","white")
   knife2.SetVar("color","white")
   knife1.SetVar("flight",0)
   knife2.SetVar("flight",0)
end
for i=1,#knifes2 do
   local knife = knifes2[i]
   if spawntime%200==70 then
      knife.SetVar("flight",3)
   end
   local speed = knife.GetVar("flight")
   knife.MoveTo(knife.x+speed,knife.y)
end
for i=1,#knifes1 do
   local knife = knifes1[i]
   if spawntime%200==70 then
      knife.SetVar("flight",3)
   end
   local speed = knife.GetVar("flight")
   knife.MoveTo(knife.x-speed,knife.y)
end
if spawntime % 60==0 then
   rand=math.random(31)
   local spear=CreateProjectile("myspear",-160+10*rand,140)
   spear.SetVar("color","toriel")
   spear.sprite.color = {1*hue,0.5*hue,0.15234375*hue}
   table.insert(spears,spear)
   spear.sprite.alpha=0
end
for i=1,#spears do
   local spear = spears[i]
   spear.sprite.color = {1*hue,0.5*hue,0.15234375*hue}
   local dist = math.sqrt((Player.x-spear.x)*(Player.x-spear.x)+(Player.y-spear.y)*(Player.y-spear.y))
   if not timer[i] then
      spear.sprite.alpha=0
      timer[i]=120
      timr[i]=50
      elseif timer[i]>70 then
      if timr[i]>0 then
         spear.sprite.alpha=1-0.02*timr[i]
         timr[i]=timr[i]-1
      end
      timer[i]=timer[i]-1
      if Player.y<spear.y then
         spear.sprite.rotation = math.asin ((Player.x-spear.x)/(dist))*180/math.pi
         else spear.sprite.rotation =180 -  math.asin ((Player.x-spear.x)/(dist))*180/math.pi
      end
      elseif timer[i]==70 then 
      angle[i]=spear.sprite.rotation-90
      timer[i]=timer[i]-1
      elseif timer[i]>60 then
      timer[i]=timer[i]-1
      elseif timer[i]>0 then
      spear.Move(3*math.cos(angle[i]*math.pi/180),3*math.sin(angle[i]*math.pi/180))
      timer[i]=timer[i]-1
      else timer[i]=120
   end
    
	if (Player.x+37>spear.x and Player.x-37<spear.x) and (Player.y+37>spear.y and Player.y-37<spear.y) then
		if collision.CheckCollision(Player, spear) then
			KnifeHurt(1)
			Effects("burn",1)
		end
	end
end
if spawntime== 590 then
   Player.SetControlOverride(false)
   EndWave()
end
spawntime=spawntime+1
end
function OnHit(attack)
  if attack.GetVar("color")=="white" then
	KnifeHurt(1)
end
end