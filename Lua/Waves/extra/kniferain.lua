Arena.resize(180,180)
collision = require "Libraries/rotational_collision"
require "Libraries/Playermove"
require "Libraries/hurt"
attack={}
paps = CreateSprite("smile")
paps.SendToBottom()
paps.x = 315
paps.y = 375
paps.Scale(1.3, 1.3)
paps.alpha = 0.0
battlesprites={}
table.insert(battlesprites,paps)
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
timer=0
limit=100
speed1=10
speed2=15
speedup1={}
speedup2={}
knives={}
targetattack={}
function Update()
HurtUpd(600)
Moving()
paps.alpha=math.sin(spawntime*math.pi/580)
spawntime=spawntime+1
timer=timer+1
if spawntime%50==0 then
  pose=math.random(12)
  local knife = CreateProjectile("KnifeRight",-400,-90+15*pose)
  table.insert( kniferainleft , knife)
end
if spawntime%50==25 then
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
	if (Player.x+38>bullet.x and Player.x-38<bullet.x) and (Player.y+16>bullet.y and Player.y-16<bullet.y) then
		KnifeHurt(1)
	end
  bullet.MoveTo(bullet.x-speedup1[g],bullet.y)
end    
for n=1,#kniferainleft do
  local bullet = kniferainleft[n]
  if bullet.x>-115 then
    speedup2[n]=speed1
    else speedup2[n]=speed1/2
  end
	if (Player.x+38>bullet.x and Player.x-38<bullet.x) and (Player.y+16>bullet.y and Player.y-16<bullet.y) then
		KnifeHurt(1)
	end

  bullet.MoveTo(bullet.x+speedup2[n],bullet.y)
end
  if timer==limit then
    timer=timer-limit
    if timer>30 then
      timer=timer-3
    end
    rand= math.random(2)
    if rand==1 then
      local knive1 = CreateProjectile("KnifeDown",Player.x,Player.y+away)
      local knive2 = CreateProjectile("KnifeUp",Player.x,Player.y-away)
      local knive3 = CreateProjectile("KnifeLeft",Player.x+away,Player.y)
      local knive4 = CreateProjectile("KnifeRight",Player.x-away,Player.y)
      table.insert(targetattack,knive1)
      table.insert(targetattack,knive2)
      table.insert(targetattack,knive3)
      table.insert(targetattack,knive4)
      else 
      local knive1 = CreateProjectile("KnifeDown",Player.x+away,Player.y+away)
      local knive2 = CreateProjectile("KnifeDown",Player.x+away,Player.y-away)
      local knive3 = CreateProjectile("KnifeDown",Player.x-away,Player.y+away)
      local knive4 = CreateProjectile("KnifeDown",Player.x-away,Player.y-away)
      table.insert(targetattack,knive1)
      table.insert(targetattack,knive2)
      table.insert(targetattack,knive3)
      table.insert(targetattack,knive4)
      knive1.sprite.rotation=-45
      knive2.sprite.rotation=-135
      knive3.sprite.rotation=45
      knive4.sprite.rotation=135
    end
  end
for i=1,#targetattack do
  local bullet = targetattack[i]
  if not rew[i]  then
    if (Player.x-bullet.x)>175 and (Player.x-bullet.x)<185 then
      right[i]=1
      elseif (Player.x-bullet.x)>-185 and (Player.x-bullet.x)<-175 then
      right[i]=-1 
      else right[i]=0
    end
    if (Player.y-bullet.y)>175 and (Player.y-bullet.y)<185 then
      up[i]=1
      elseif (Player.y-bullet.y)>-185 and (Player.y-bullet.y)<-175 then
      up[i]=-1 
      else up[i]=0
    end
    rew[i]=42
    elseif rew[i]>12 then
      rew[i]=rew[i]-1
    elseif rew[i]>0 and rew[i]<13 then
    rew[i]=rew[i]-1
    bullet.MoveTo(bullet.x+speed2*right[i],bullet.y+speed2*up[i])
  end
	if (Player.x+40>bullet.x and Player.x-40<bullet.x) and (Player.y+40>bullet.y and Player.y-40<bullet.y) then
		if collision.CheckCollision(Player, bullet) then
			KnifeHurt(1)
		end
	end
end
end

function OnHit(attacks)
end