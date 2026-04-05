random1=200
random2=200
Arena.ResizeImmediate(200,200)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifesup={}
knifesright={}
knifesleft={}
function Update()
HurtUpd(900)
Moving()
spawntime=spawntime+1
if spawntime%60==0 and math.random(4) ~= 1 then
	rand1=Arena.width/15
	rand1=(math.random(rand1)*15-Arena.width/2-5)
	local knife = CreateProjectile("KnifeDown",rand1,350)
	knife.SetVar("time",-1)
	knife.SetVar("color","knife")
        table.insert(knifesup,knife)
end
if spawntime%90==10 and math.random(3) == 1 then
	rand1=Arena.width/15
	rand1=(math.random(rand1)*15-Arena.width/2-5)
	local knife = CreateProjectile("KnifeDownblue",rand1,350)
	knife.SetVar("time",-1)
	knife.SetVar("color","blue")
        table.insert(knifesup,knife)
end
if spawntime%150==5 and math.random(3) == 1 then
	rand1=Arena.width/15
	rand1=(math.random(rand1)*15-Arena.width/2-5)
	local knife = CreateProjectile("KnifeDownOrange",rand1,350)
	knife.SetVar("time",-1)
	knife.SetVar("color","orange")
        table.insert(knifesup,knife)
end
for i=1,#knifesup do
	local knife = knifesup[i]
	if knife.isactive then
		knife.Move(0,-5)
		local time=knife.GetVar("time")+1
		if knife.y<-Arena.width/2-32 and time==0 then
			knife.SetVar("time",0)
		end
		if time>0 then
			knife.SetVar("time",time)
			if time<10 then
				knife.sprite.alpha=math.cos(time*math.pi/20)
				else
				knife.Remove()
			end
		end
	end
end
for i=1,#knifesleft do
	local knife = knifesleft[i]
	if knife.isactive then
		knife.Move(5,0)
		local time=knife.GetVar("time")+1
		if knife.x>Arena.width/2+32 and time==0 then
			knife.SetVar("time",0)
		end
		if time>0 then
			knife.SetVar("time",time)
			if time<10 then
				knife.sprite.alpha=math.cos(time*math.pi/20)
				else
				knife.Remove()
			end
		end
	end
end
for i=1,#knifesright do
	local knife = knifesright[i]
	if knife.isactive then
		knife.Move(-5,0)
		local time=knife.GetVar("time")+1
		if knife.x<-Arena.width/2-32 and time==0 then
			knife.SetVar("time",0)
		end
		if time>0 then
			knife.SetVar("time",time)
			if time<10 then
				knife.sprite.alpha=math.cos(time*math.pi/20)
				else
				knife.Remove()
			end
		end
	end
end
if spawntime%60==20 and math.random(4) ~= 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeRight",-350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","knife")
        table.insert(knifesleft,knife)
end
if spawntime%60==40 and math.random(4) ~= 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeLeft",350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","knife")
        table.insert(knifesright,knife)
end
if spawntime%90==45 and math.random(3) == 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeLeftBlue",350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","blue")
        table.insert(knifesright,knife)
end
if spawntime%150==35 and math.random(3) == 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeLeftOrange",350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","orange")
        table.insert(knifesright,knife)
end
if spawntime%90==15 and math.random(3) == 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeRightBlue",-350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","blue")
        table.insert(knifesright,knife)
end
if spawntime%150==10 and math.random(3) == 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeRightOrange",-350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","orange")
        table.insert(knifesright,knife)
end

if spawntime>50 and spawntime<200 then
	Arena.Resize(150+50*math.cos((spawntime-50)*math.pi/150),200)
	elseif spawntime>350 and spawntime<500 then
	Arena.MoveToAndResize(320,190-(150+50*math.cos((spawntime-350)*math.pi/150))/2,100,150+50*math.cos((spawntime-350)*math.pi/150),true,true)
end
end
function OnHit(attack)
if attack.isactive and not death then
	local color = attack.GetVar("color")
	if color == "knife" then
		KnifeHurt(1)
	elseif color == "orange" and not isMoving() then
		KnifeHurt(1)
	elseif color == "blue" and isMoving() then
		KnifeHurt(1)
	end
end
end