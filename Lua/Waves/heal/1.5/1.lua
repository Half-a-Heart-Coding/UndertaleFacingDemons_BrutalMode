spawntime=0
rand=math.random(2)*2-3
rain={}
knifes={}
sidings={}
require "Libraries/Playermove"
require "Libraries/hurt"
Arena.Resize(300,128)
Player.MoveTo(0,0,false)

if Encounter.GetVar("diff")==34 or Encounter.GetVar("diff")==35 or Encounter.GetVar("diff")==36 then
	Encounter.SetVar("SavedProg", Encounter.GetVar("SavedProg")+1)
end

function SendKnife(name,pos,speed)
	local k=CreateProjectile(name,pos[1],pos[2])
	k.SetVar("speed",speed)
	table.insert(knifes,k)
	k.SetVar("time",0)
end

function Update()
spawntime=spawntime+1
HurtUpd(480)
Moving()
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
if spawntime==355-rand*15 then
	Audio.PlaySound("knife")
	for i=1,8 do
		local k=CreateProjectile("KnifeDown",-180+40*i,300)
		k.sprite.alpha=0
		k.SetVar("time",0)
		table.insert(rain,k)
	end
end
if spawntime==355+rand*15 then
	Audio.PlaySound("knife")
	for i=1,7 do
		local k=CreateProjectile("KnifeDown",-160+40*i,300)
		k.sprite.alpha=0
		k.SetVar("time",0)
		table.insert(rain,k)
	end
end
if (spawntime%60==30 and spawntime<211) then
	rand=math.random(2)*2-3
	local dist=128/6
	for i=0,2 do
		SendKnife("KnifeLeft",{300,(64-dist/2-2*dist*i)*rand},{-4,0})
	end
	rand=-rand
	local dist=128/6
	for i=0,2 do
		SendKnife("KnifeRight",{-300,(64-dist/2-2*dist*i)*rand},{4,0})
	end
end
for i=1,#rain do
	local k=rain[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time<16 then
			k.sprite.alpha=math.sin(time*math.pi/30)
		end
		k.Move(0,-4)
		if k.y<-300 then
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