Arena.Resize(150,150)
collision = require "Libraries/rotational_collision"
knifes={}
require "Libraries/Playermove"
require "Libraries/hurt"
sides={}
phase={}
timer={}
ugol={}
zamer={}
times={}
spawntime=0
function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
if spawntime%60==0 then
	local knife1=CreateProjectile("KnifeLeft",200,Player.y)
	knife1.sprite.rotation=0
	table.insert(sides,knife1)
	local knife2=CreateProjectile("KnifeLeft",-200,Player.y)
	knife2.sprite.rotation=180
	table.insert(sides,knife2)
end
for i=1,#sides do
	if not times[i] then
		times[i]=0
		else times[i]=times[i]+1
	end
	local knife = sides[i]
	if knife.isactive then
		knife.MoveTo(knife.x-7*(90-knife.sprite.rotation)/90,knife.y)
		if Player.x+32>knife.x and Player.x-32<knife.x and Player.y+10>knife.y and Player.y-10<knife.y then
			KnifeHurt(1)
			Effects("curse",1)
		end
	end
	if times[i]==40 then
		knife.Remove()
	end
end
if spawntime%60==1  then
	rand2=math.random(5)-1
	rand1=math.random(5)-3
	for i=-2,2 do
		local knife=CreateProjectile("KnifeDown",rand1*15,250+rand2*15)
		knife.sprite.rotation=22.5*i
		knife.SetVar("angle",22.5*i)
		table.insert(knifes,knife)
	end
end
for i=1,#knifes do
	local knife=knifes[i]
	if knife.isactive and not phase[i] then
		if Player.x+34>knife.x and Player.x-34<knife.x and Player.y+34>knife.y and Player.y-34<knife.y then
			if collision.CheckCollision(Player, attack) and attack.sprite.alpha then
				KnifeHurt(1)
				Effects("curse",1)
			end
		end
		if not timer[i] then
			timer[i]=0
			else timer[i]=timer[i]+1
		end
		local angle=knife.GetVar("angle")
		knife.MoveTo(knife.x+7.5*math.sin(angle*math.pi/180),knife.y-7.5)
		if timer[i]== 15 then
			phase[i]=1
			timer[i]=0
		end
		elseif knife.isactive and phase[i]==1 then
		knife.sprite.rotation=knife.sprite.rotation+7.5
		if knife.sprite.rotation==180 or knife.sprite.rotation-2.5==180 then
			phase[i]=2
		end
		elseif knife.isactive and phase[i]==2 then
		timer[i]=timer[i]+1
		ugol[i] = (math.asin ((Player.x-knife.x)/(math.sqrt((Player.x-knife.x)*(Player.x-knife.x)+(Player.y-knife.y)*(Player.y-knife.y))))*180/math.pi)
		if not zamer[i] then
			zamer[i]=(ugol[i]+180)%360/20
		end
		knife.sprite.rotation=knife.sprite.rotation+zamer[i]
		if timer[i]==20 then
			phase[i]=3
			knife.SetVar("ugol",ugol[i])
		end
		elseif knife.isactive and phase[i]==3 then
		local ugol = knife.GetVar("ugol")
		knife.MoveTo(knife.x+8*math.sin(ugol*math.pi/180),knife.y-8*math.cos(ugol*math.pi/180))
		knife.sprite.rotation=ugol
	end
	if knife.y<-100 then
		knife.Remove()
	end
end
end
function OnHit(attack)
end

