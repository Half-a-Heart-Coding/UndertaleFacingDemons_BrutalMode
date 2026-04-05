spawntime=0
collision = require "Libraries/rotational_collision"
require "Libraries/Playermove"
require "Libraries/hurt"
warns={}
timer={}
knifes={}
spawn={}
rep=0
Arena.Resize(150,150)
function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
if spawntime%15==0 then
	rand1=math.random(3)
	rand2=math.random(150/15)*15-75
	rand3=math.random(15)
	if rand3<15 then
		rep=rep+1
		else rep=0
	end
	if rep>10 then
		rep=0
		rand3=15
	end
	if rand1%2==0 then
		local warn=CreateProjectile("warnline",rand2,-300*(rand1-3))
		warn.sprite.rotation=rand1*90
		table.insert(warns,warn)
		if rand3==15 then
			warn.SetVar("danger",true)
			warn.sprite.alpha=1
			else warn.sprite.alpha=0
		end
		if rand3==0 then
			warn.SetVar("lie",true)
		end
		else 
		local warn=CreateProjectile("warnline",-300*(rand1-2),rand2)
		warn.sprite.rotation=rand1*90
		table.insert(warns,warn)
		if rand3==15 then
			warn.SetVar("danger",true)
			warn.sprite.alpha=1
			else warn.sprite.alpha=0
		end
		if rand3==1 then
			warn.SetVar("lie",true)
		end
	end
end
for i=1,#warns do
	local warn = warns[i]
	if not timer[i] then
		timer[i]=0
		else timer[i]=timer[i]+1
	end
	if timer[i]==15 then
		if not warn.GetVar("danger") and not warn.GetVar("lie") then
			local knife=CreateProjectile("KnifeUp",warn.x,warn.y)
			knife.sprite.rotation=warn.sprite.rotation
			knife.SetVar("color","white")
			table.insert(knifes,knife)
			else
			local knife=CreateProjectile("spear",warn.x,warn.y)
			knife.sprite.rotation=warn.sprite.rotation
			table.insert(knifes,knife)
			if warn.GetVar("danger") then
				knife.sprite.color={246/256,0,54/256}
				knife.SetVar("color","curse")
				else knife.sprite.color={14/255,209/255,69/255}
				knife.SetVar("color","lie")
			end
		end
		warn.Remove()
	end
end
for i=1,#knifes do
	local knife = knifes[i]
	if knife.isactive then
		if Player.x+34>knife.x and Player.x-34<knife.x and Player.y+34>knife.y and Player.y-34<knife.y then
			local col=knife.GetVar("color")
			if collision.CheckCollision(Player, knife) then
				if col=="curse" then
					KnifeHurt(1)
					Effects("curse",10)
					elseif col=="lie" then
					KnifeHurt(1)
					if GetGlobal("lie")%2==0 then
						SetGlobal("lie",GetGlobal("lie")+1)
					end
					Effects("curse",1)
					elseif col=="white" then
					KnifeHurt(1)
					Effects("curse",1)
				end
			end
		end
		if knife.GetVar("color")=="lie" then
			knife.Move(3.5*math.cos((knife.sprite.rotation+90)*math.pi/180),3.5*math.sin((knife.sprite.rotation+90)*math.pi/180))
			else
			knife.Move(7*math.cos((knife.sprite.rotation+90)*math.pi/180),7*math.sin((knife.sprite.rotation+90)*math.pi/180))
		end
	end
	if not spawn[i] then
		spawn[i]=0
		else spawn[i]=spawn[i]+1
	end
end
end
function OnHit(attack)
end