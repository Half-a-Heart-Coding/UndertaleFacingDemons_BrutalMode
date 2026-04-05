random1=200
random2=200
Arena.ResizeImmediate(200,200)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifesup={}
knifesright={}
knifesleft={}
posIndexVal=0
function Update()
HurtUpd(900)
--this attack is now becoming semi-random
Moving()
spawntime=spawntime+1
if spawntime%45==0 then
	rand1=Arena.width/30
	rand1=(math.random(rand1)*30-Arena.width/2-5)
	rand1=posIndexVal*30 -Arena.width/2-5--not random
	local name=""
	if GetGlobal("DifficultyPoints") >= 621 then
		name="Fatal"
	end
	local knife = CreateProjectile("KnifeDown"..name,rand1,350)
	knife.SetVar("time",-1)
	knife.SetVar("color","knife")
        table.insert(knifesup,knife)
end
if spawntime%45==10 and math.random(3) ~= 1 then
	rand1=Arena.width/30
	rand1=(math.random(rand1)*30-Arena.width/2-5)
	rand1=posIndexVal*30 -Arena.width/2-5--not random
	local name=""
	if GetGlobal("DifficultyPoints") >= 621 then
		name="Fatal"
	end
	local knife = CreateProjectile("KnifeDownblue"..name,rand1,350)
	knife.SetVar("time",-1)
	knife.SetVar("color","blue")
        table.insert(knifesup,knife)
end
if spawntime%90==5 and math.random(3) ~= 1 then
	rand1=Arena.width/30
	rand1=(math.random(rand1)*30-Arena.width/2-5)
	rand1=posIndexVal*30 -Arena.width/2-5--not random
	local name=""
	if GetGlobal("DifficultyPoints") >= 621 then
		name="Fatal"
	end
	local knife = CreateProjectile("KnifeDownOrange"..name,rand1,350)
	knife.SetVar("time",-1)
	knife.SetVar("color","orange")
        table.insert(knifesup,knife)
end
posIndexVal = math.ceil(((spawntime%37 -2) /37) * 5)
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
if spawntime%46==20 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	rand2=posIndexVal*30 -Arena.height/2-5--not random
	local name=""
	if GetGlobal("DifficultyPoints") >= 621 then
		name="Fatal"
	end
	local knife = CreateProjectile("KnifeRight"..name,-350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","knife")
        table.insert(knifesleft,knife)
end
if spawntime%46==40 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	rand2=posIndexVal*30 -Arena.height/2-5--not random
	local name=""
	if GetGlobal("DifficultyPoints") >= 621 then
		name="Fatal"
	end
	local knife = CreateProjectile("KnifeLeft"..name,350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","knife")
        table.insert(knifesright,knife)
end
if spawntime%61==45 and math.random(3) ~= 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	rand2=posIndexVal*30 -Arena.height/2-5--not random
	local name=""
	if GetGlobal("DifficultyPoints") >= 621 then
		name="Fatal"
	end
	local knife = CreateProjectile("KnifeLeftBlue"..name,350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","blue")
        table.insert(knifesright,knife)
end
if spawntime%91==35 and math.random(3) ~= 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	rand2=posIndexVal*30 -Arena.height/2-5--not random
	local name=""
	if GetGlobal("DifficultyPoints") >= 621 then
		name="Fatal"
	end
	local knife = CreateProjectile("KnifeLeftOrange"..name,350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","orange")
        table.insert(knifesright,knife)
end
if spawntime%66==15 and math.random(3) ~= 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	rand2=posIndexVal*30 -Arena.height/2-5--not random
	local name=""
	if GetGlobal("DifficultyPoints") >= 621 then
		name="Fatal"
	end
	local knife = CreateProjectile("KnifeRightBlue"..name,-350,rand2)
	knife.SetVar("time",-1)
	knife.SetVar("color","blue")
        table.insert(knifesright,knife)
end
if spawntime%96==10 and math.random(3) ~= 1 then
	rand2=Arena.height/15
	rand2=(math.random(rand2)*15)-Arena.height/2
	rand2=posIndexVal*30 -Arena.height/2-5--not random
	local name=""
	if GetGlobal("DifficultyPoints") >= 621 then
		name="Fatal"
	end
	local knife = CreateProjectile("KnifeRightOrange"..name,-350,rand2)
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