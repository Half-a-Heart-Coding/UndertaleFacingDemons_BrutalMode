spawntime=0
rain={}
knifes={}
sidings={}
require "Libraries/Playermove"
require "Libraries/hurt"
rand=math.random(2)-1
Arena.Resize(300,128)
Player.MoveTo(0,0,false)

function SendKnife(name,pos,speed)
	local k=CreateProjectile(name,pos[1],pos[2])
	k.SetVar("speed",speed)
	table.insert(knifes,k)
	k.SetVar("time",0)
end

function Update()
spawntime=spawntime+1
HurtUpd(600)
Moving()
if spawntime==1 then
	SendKnife("KnifeRight",{0,180},{0,-5})
	SendKnife("KnifeLeft",{0,-180},{0,5})
	SendKnife("KnifeDown",{180,0},{-5,0})
	SendKnife("KnifeUp",{-180,0},{5,0})
end
if spawntime==45 then
	local k=CreateProjectile("KnifeUp",160,-32)
	k.sprite.alpha=0
	k.SetVar("side",{1,-1})
	k.SetVar("time",0)
	table.insert(sidings,k)
	k=CreateProjectile("KnifeDown",-160,32)
	k.sprite.alpha=0
	k.SetVar("side",{-1,1})
	k.SetVar("time",0)
	table.insert(sidings,k)
end
if spawntime>299 and spawntime<326 and spawntime%5==0 then
	local i=(spawntime-300)/5
	i=140-20*i
	local k=CreateProjectile("KnifeDown",i,200)
	k.sprite.alpha=0
	k.SetVar("time",0)
	table.insert(rain,k)
	k=CreateProjectile("KnifeDown",-i,200)
	k.sprite.alpha=0
	k.SetVar("time",0)
	table.insert(rain,k)
end
if spawntime==360 then
	Audio.PlaySound("knife")
	for i=1,8 do
		local k=CreateProjectile("KnifeDown",-180+40*i,200+100*rand)
		k.sprite.alpha=0
		k.SetVar("time",0)
		table.insert(rain,k)
	end
	for i=1,7 do
		local k=CreateProjectile("KnifeDown",-160+40*i,300-100*rand)
		k.sprite.alpha=0
		k.SetVar("time",0)
		table.insert(rain,k)
	end
end
if spawntime==420 then
	rand=math.random(2)-1
	local dist=128/6
	for i=0,2 do
		SendKnife("KnifeLeft",{300,-64+dist/2+2*dist*i},{-5,0})
		SendKnife("KnifeRight",{-300,64-dist/2-2*dist*i},{5,0})
	end
end		
if spawntime>459 and spawntime<486 and spawntime%5==0 then
	local i=(spawntime-460)/5
	i=10+20*i
	SendKnife("KnifeDown",{i,200},{0,-6})
	SendKnife("KnifeDown",{-i,200},{0,-6})
end
for i=1,#rain do
	local k=rain[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time<16 then
			k.sprite.alpha=math.sin(time*math.pi/30)
		end
		k.Move(0,-5)
		if k.y<-300 then
			k.Remove()
		end
	end
end
for i=1,#sidings do
	local k=sidings[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local side=k.GetVar("side")
		if time<61 then
			k.sprite.alpha=math.sin(time*math.pi/120)
			elseif time<136 then
			k.MoveTo(160*side[1]*math.cos((time-60)*math.pi/25),32*side[2])
			elseif time<181 then
			k.MoveTo(-160*side[1],32*side[2]*math.cos((time-135)*math.pi/45))
			elseif time<256 then
			k.MoveTo(-160*side[1]*math.cos((time-180)*math.pi/25),-32*side[2])
			elseif time<286 then
			k.sprite.alpha=1-math.sin((time-255)*math.pi/60)
			else
			k.Remove()
		end
	end
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time<16 then
			k.sprite.alpha=math.sin(time*math.pi/30)
		end
		local speed=k.GetVar("speed")
		k.Move(speed[1],speed[2])
		if k.x>600 or k.x<-600 or k.y>400 or k.y<-400 then
			k.Remove()
		end
	end
end






	
end

function OnHit()
KnifeHurt(1)
end