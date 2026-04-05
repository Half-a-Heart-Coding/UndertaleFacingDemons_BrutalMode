spawntime=0
fires={}
knifesleft={}
knifesright={}
away=false
require "Libraries/Playermove"
require "Libraries/hurt"
Arena.Resize(320,160)
paps = CreateSprite("Asgore_Sprite")
paps.SendToBottom()
paps.x = 380
paps.y = 376
paps.Scale(2, 2)
paps.alpha = 0.0
battlesprites={}
table.insert(battlesprites,paps)
function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
paps.alpha = 0.5*math.sin(spawntime*math.pi/580)
if spawntime<300 or spawntime==300  then
   paps.x = 330+90*math.sin(spawntime*math.pi/580)
   elseif spawntime==380 then
   else paps.x = 510-90*math.sin(spawntime*math.pi/580)
end
if spawntime==585 then
	EndWave()
end
if spawntime%60==1 then
	random1=math.random(20)*16-8-160
	local fire1=CreateProjectile("bullet",random1,280)
	fire1.SetVar("color","fire")
	fire1.sprite.color={1,0,0}
	table.insert(fires,fire1)
end
away=100000
for i=1,#fires do
	local fire = fires[i]
	local dist=(fire.x-Player.x)*(fire.x-Player.x)+(fire.y-Player.y)*(fire.y-Player.y)
	if away>dist and fire.isactive then
		away=dist
	end
end
if spawntime>45 then
	Player.sprite.alpha=1-0.00015*away
	else Player.sprite.alpha=1-1/45*spawntime
end
for i=1,#fires do
	local fire = fires[i]
	if fire.isactive then
		fire.Move(0,-2)
	end
	if fire.y<-130 then
		fire.Remove()
	end
end
for i=1,#knifesleft do
	local knife = knifesleft[i]
	if knife.isactive then
		knife.Move(5,0)
	end
	if knife.x>205 then
		knife.Remove()
	end
end
for i=1,#knifesright do
	local knife = knifesright[i]
	if knife.isactive then
		knife.Move(-5,0)
	end
	if knife.x<-205 then
		knife.Remove()
	end
end
if spawntime%30==0 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeRight",-300,rand2)
	knife.SetVar("color","white")
        table.insert(knifesleft,knife)
end
if spawntime%30==15 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeLeft",300,rand2)
	knife.SetVar("color","white")
        table.insert(knifesright,knife)
end
end
function OnHit(attack)
	if attack.GetVar("color")=="fire" then
		LongHurt(5,4)
		elseif attack.GetVar("color")=="white" then
		Effects("curse",1)
		KnifeHurt(1)
	end
end