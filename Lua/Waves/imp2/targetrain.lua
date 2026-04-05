Arena.resize(180,180)
collision = require "Libraries/rotational_collision"
attack={}
require "Libraries/Playermove"
require "Libraries/hurt"
spears={}
angle={}
timer={}
paps = CreateSprite("smile")
paps.SendToBottom()
paps.x = 315
paps.y = 375
paps.Scale(1.3, 1.3)
paps.alpha = 0.0
kniferainleft={}
kniferainright={}
spawntime=0
loop=80
life={}
right={}
up={}
pose=0
rand=0
away=180
rew={}
limit=100
speed1=10
speed2=15
speed3=9
speedup1={}
speedup2={}
knives={}
targetattack={}
function Update()
HurtUpd(600)
Moving()
paps.alpha=math.sin(spawntime*math.pi/580)
spawntime=spawntime+1
if spawntime%40==0 then
  pose=math.random(12)
  local knife = CreateProjectile("KnifeRight",-400,-90+15*pose)
  table.insert( kniferainleft , knife)
end
if spawntime%40==20 then
  pose=math.random(12)
  local knife = CreateProjectile("KnifeLeft",400,-90+15*pose)
  table.insert( kniferainright , knife)
end    
for g=1,#kniferainright do
  local bullet = kniferainright[g]
  if bullet.x<115 then
    speedup1[g]=speed1
    else speedup1[g]=speed1/2
  end
  if Player.x+36>bullet.x and Player.x-36<bullet.x and Player.y+14>bullet.y and Player.y-14<bullet.y then
	KnifeHurt(1)
	Effects("curse",1)
  end
  bullet.MoveTo(bullet.x-speedup1[g],bullet.y)
end    
for n=1,#kniferainleft do
  local bullet = kniferainleft[n]
  if bullet.x>-115 then
    speedup2[n]=speed1
    else speedup2[n]=speed1/2
  end
  bullet.MoveTo(bullet.x+speedup2[n],bullet.y)
end
if spawntime % 30==0 then
   rand=math.random(31)
   local spear=CreateProjectile("KnifeDown",-160+10*rand,140)
   spear.SetVar("color","toriel")

   table.insert(spears,spear)
   spear.sprite.alpha=0
end
for i=1,#spears do
   local spear = spears[i]
   local dist = math.sqrt((Player.x-spear.x)*(Player.x-spear.x)+(Player.y-spear.y)*(Player.y-spear.y))
   if spear.isactive then
	if Player.x+34>spear.x and Player.x-34<spear.x and Player.y+32>spear.y and Player.y-32<spear.y then
		if collision.CheckCollision(Player,spear) and spear.sprite.alpha and not death then
			KnifeHurt(1)
	 		Effects("curse",1)
		end
	end
	end
   if not timer[i] then
      spear.sprite.alpha=1
      timer[i]=80
      elseif timer[i]>70 then
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
      spear.Move(speed3*math.cos(angle[i]*math.pi/180),speed3*math.sin(angle[i]*math.pi/180))
      timer[i]=timer[i]-1
      elseif spear.isactive then
	spear.Remove()
   end
end
end

function OnHit(attacks)

end