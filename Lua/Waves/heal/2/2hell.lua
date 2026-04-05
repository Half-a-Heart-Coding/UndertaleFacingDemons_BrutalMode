Arena.ResizeImmediate(100,100)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
speed=0
WasRed=false
knifes={}
collision = require "Libraries/rotational_collision"

if Encounter.GetVar("diff")==34 or Encounter.GetVar("diff")==35 or Encounter.GetVar("diff")==36 then
	Encounter.SetVar("SavedProg", Encounter.GetVar("SavedProg")+1)
end

function RedKnifes()
	local k=CreateProjectile("KnifeDownDeadly",Player.x,Player.y+100)
	k.sprite.alpha=0
	k.SetVar("time",0)
	k.SetVar("speed",{0,-7})
	k.SetVar("color","gold")
	table.insert(knifes,k)
	k=CreateProjectile("KnifeRightDeadly",Player.x-100,Player.y)
	k.sprite.alpha=0
	k.SetVar("time",0)
	k.SetVar("speed",{7,0})
	k.SetVar("color","gold")
	table.insert(knifes,k)
	k=CreateProjectile("KnifeUpDeadly",Player.x,Player.y-100)
	k.sprite.alpha=0
	k.SetVar("time",0)
	k.SetVar("speed",{0,7})
	k.SetVar("color","gold")
	table.insert(knifes,k)
	k=CreateProjectile("KnifeLeftDeadly",Player.x+100,Player.y)
	k.sprite.alpha=0
	k.SetVar("time",0)
	k.SetVar("speed",{-7,0})
	k.SetVar("color","gold")
	table.insert(knifes,k)
end

function BlueKnifes()
	local randomKnifeLethalCompany = math.random(2) + 99
	local randomIsThisOrange = math.random(3) + 99
	local s=7*math.sin(1*math.pi/4)
	local k = 0
	if randomKnifeLethalCompany == 1 then
		k=CreateProjectile("KnifeLeftLethal",Player.x+70,Player.y+70)
		k.sprite.color={1,1,1}
		k.SetVar("color","lethal")
	else
		k=CreateProjectile("spearleft",Player.x+70,Player.y+70)
		k.SetVar("color","blue")
		k.sprite.color={0/255, 168/255, 242/255}
	end
	k.sprite.alpha=0
	k.sprite.rotation=-45
	k.SetVar("time",0)
	if randomIsThisOrange == 1 then
		k.sprite.color={1,0.4,0}
		k.SetVar("color","orange")
	end
	k.SetVar("speed",{-s,-s})
	table.insert(knifes,k)
	if randomKnifeLethalCompany == 2 then
		k=CreateProjectile("KnifeLeftLethal",Player.x+70,Player.y-70)
		k.SetVar("color","lethal")
		k.sprite.color={1,1,1}
	else
		k=CreateProjectile("spearleft",Player.x+70,Player.y-70)
		k.SetVar("color","blue")
		k.sprite.color={0/255, 168/255, 242/255}
	end
	
	k.sprite.alpha=0
	k.sprite.rotation=-135
	k.SetVar("time",0)
	k.SetVar("speed",{-s,s})
	if randomIsThisOrange == 1 then
		k.sprite.color={1,0.4,0}
		k.SetVar("color","orange")
	end
	table.insert(knifes,k)
	if randomKnifeLethalCompany == 1 then
		k=CreateProjectile("KnifeLeftLethal",Player.x-70,Player.y-70)
		k.SetVar("color","lethal")
		k.sprite.color={1,1,1}
	else
		k=CreateProjectile("spearleft",Player.x-70,Player.y-70)
		k.SetVar("color","blue")
		k.sprite.color={0/255, 168/255, 242/255}
	end
	
	k.sprite.alpha=0
	k.sprite.rotation=135
	k.SetVar("time",0)
	if randomIsThisOrange == 1 then
		k.sprite.color={1,0.4,0}
		k.SetVar("color","orange")
	end
	k.SetVar("speed",{s,s})
	table.insert(knifes,k)
	if randomKnifeLethalCompany == 2 then
		k=CreateProjectile("KnifeLeftLethal",Player.x-70,Player.y+70)
		k.SetVar("color","lethal")
		k.sprite.color={1,1,1}
	else
		k=CreateProjectile("spearleft",Player.x-70,Player.y+70)
		k.SetVar("color","blue")
		k.sprite.color={0/255, 168/255, 242/255}
	end
	
	k.sprite.alpha=0
	k.sprite.rotation=45
	k.SetVar("time",0)
	if randomIsThisOrange == 1 then
		k.sprite.color={1,0.4,0}
		k.SetVar("color","orange")
	end
	k.SetVar("speed",{s,-s})
	table.insert(knifes,k)
end

function Update()
HurtUpd(600)
Moving()
if spawntime>15 and WasRed==false then
	speed=speed+1
	WasRed=true
	if speed==15 then
		speed=14
	end
	RedKnifes()
	elseif spawntime>25 and WasRed==true then
	BlueKnifes()
	WasRed=false
	spawntime=spawntime-60
end
spawntime=spawntime+1+0.5*(1-math.cos(speed*math.pi/24))
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1+2*math.sin(speed*math.pi/24)
		k.SetVar("time",time)
		local sp=k.GetVar("speed")
		if time<30 then
			elseif time<60 then		
			local sin=math.sin((time-30)*math.pi/60)
			k.Move(sp[1]*sin,sp[2]*sin)
			else		
			k.Move(sp[1],sp[2])
		end
		if time<31 then	
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
		if (Player.x+34>k.x and Player.x-34<k.x) and (Player.y+34>k.y and Player.y-34<k.y) then
			if k.GetVar("color")=="knife" or (k.GetVar("color")=="blue" and isMoving() ) or (k.GetVar("color")=="orange" and not isMoving() ) then
				if collision.CheckCollision(Player,k) then
					KnifeHurt(1)
					Effects("curse",1)
				end
			end
			if k.GetVar("color")=="lethal" then
				if collision.CheckCollision(Player,k) then
					KnifeHurt(3)
					Effects("curse",2)
				end
			end
			if k.GetVar("color")=="gold" then
				if collision.CheckCollision(Player,k) then
					KnifeHurt(2)
					Effects("curse",1)
				end
			end
		end
		if k.x>600 or k.x<-600 or k.y>400 or k.y<-400 then
			k.Remove()
		end
	end
end



end

function OnHit()
end