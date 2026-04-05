Arena.ResizeImmediate(120,120)
Arena.Move(0,85,true,true)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}
local point=200/8
local startrot=math.random(2)
oldx=-3
oldy=-3

name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
name3="Deadly"
if GetGlobal("DifficultyPoints") >= 621 then
	name3="Fatal"
end
name4="Lethal"
if GetGlobal("DifficultyPoints") >= 621 then
	name4="Fatal"
end
name5="Fatal"
if GetGlobal("DifficultyPoints") >= 621 then
	name5="Mutant"
end

function DoKnifes()
	local rot=math.random(4)
	local rand=math.random(5)-3
	if startrot==2 then
		while rot%2==1 do
			rot=math.random(4)
		end
		while oldx==rand or oldx-rand>2 or oldx-rand<-2 do
			rand=math.random(5)-3
		end
		oldx=rand
		startrot=1
		else
		while rot%2==0 do
			rot=math.random(4)
		end
		while oldy==rand or oldy-rand>2 or oldy-rand<-2 do
			rand=math.random(5)-3
		end
		oldy=rand
		startrot=2
	end
	for i=-2,2 do
		local x=24*i
		if i==rand then
			SendKnife2(x,rot)
			else
			SendKnife(x,rot)
		end
	end
end

function SendKnife(x,side)
	local spr="KnifeDownLethal"
	if side%2==1 then
		spr="KnifeLeftLethal"
	end
	if spawntime>=900 or name4=="Fatal" then
		spr="KnifeDownFatal"
		if side%2==1 then
			spr="KnifeLeftFatal"
		end
	end
	if spawntime>=900 and name4=="Fatal" then
		spr="KnifeDownMutant"
		if side%2==1 then
			spr="KnifeLeftMutant"
		end
	end
	local knife=0
	if side%2==0 then
		knife=CreateProjectile(spr,x,200-200*(side-2))
		else
		knife=CreateProjectile(spr,200-200*(side-1),x)
	end
	if side>2 then
		knife.sprite.rotation=180
	end	
	knife.SetVar("i",i)
	knife.SetVar("time",0)
	knife.SetVar("side",side)	
	knife.SetVar("speed",speed)
	if spawntime>=900 then
		knife.SetVar("color","fatal")
	else
		knife.SetVar("color","red")
	end
	knife.sprite.alpha=0
	table.insert(knifes,knife)
end

function SendKnife2(x,side)
	local spr="KnifeDownFake"
	if side%2==1 then
		spr="KnifeLeftFake"
	end
	local knife=0
	if side%2==0 then
		knife=CreateProjectile(spr,x,200-200*(side-2))
		else
		knife=CreateProjectile(spr,200-200*(side-1),x)
	end
	if side>2 then
		knife.sprite.rotation=180
	end	
	knife.SetVar("i",i)
	knife.SetVar("time",0)
	knife.SetVar("side",side)	
	knife.SetVar("color","warn")
	knife.SetVar("speed",speed)
	knife.sprite.alpha=0
	table.insert(knifes,knife)
end

function SendKnife3(x,side)
	local spr="KnifeDownOrange"..name3
	if side%2==1 then
		spr="KnifeLeftOrange"..name3
	end
	local knife=0
	if side%2==0 then
		knife=CreateProjectile(spr,x,200-200*(side-2))
		else
		knife=CreateProjectile(spr,200-200*(side-1),x)
	end
	if side>2 then
		knife.sprite.rotation=180
	else
		--knife.sprite.rotation=270
	end	
	knife.SetVar("i",i)
	knife.SetVar("time",100)
	knife.SetVar("side",side)	
	knife.SetVar("color","orange")
	knife.SetVar("speed",speed)
	knife.sprite.alpha=1
	table.insert(knifes,knife)
end

vzmahi = {}
deadtime=0
blasts = {}

endgame = false
lastsecond = 0
sdvig = 1

function Update()
if spawntime%90==0 then
	DoKnifes()
end
HurtUpd(900)
Moving()
if endgame==false then
	spawntime=spawntime+1
end
if endgame==true then
  deadtime=deadtime+1
  Encounter.Call("SetMusic","none")
  Player.SetControlOverride(true)
  if  deadtime<60 then
     deadscreen = CreateProjectile("999999", 0,145-Arena.height/2)
     deadtime=60
     else
     deadscreen.MoveTo(5*math.sin(deadtime*math.pi/5),145-Arena.height/2)
  end
  if deadtime==120 then
	FakeDeath()
  end
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local side=k.GetVar("side")
		if time>60 and time<106 then
			if side%2==1 then
				local x=(200-336*math.sin((time-60)*math.pi/100))*(2-side)
				k.MoveTo(x,k.y)
				else
				local y=(200-336*math.sin((time-60)*math.pi/100))*(3-side)
				k.MoveTo(k.x,y)
			end
		end
		if time>120 then
			if side%2==1 then
				local x=(200-336*math.sin((time-80)*math.pi/100))*(2-side)
				k.MoveTo(x,k.y)
				else
				local y=(200-336*math.sin((time-80)*math.pi/100))*(3-side)
				k.MoveTo(k.x,y)
			end
		end
		if time==100 and k.GetVar("color") == "warn" then
			if side%2==1 then
				SendKnife3(k.y,side)
			else
				SendKnife3(k.x,side)
			end
			k.Remove()
		end
		if time<31 then
			k.sprite.alpha=math.sin(time*math.pi/60)
			elseif time>160 and time<190 then
			k.sprite.alpha=math.sin((time-150)*math.pi/60)
			elseif time==190 then
			k.Remove()
		end
	end
end



end

function GameOver()
	Audio.Stop()
	Player.SetControlOverride(true)
	playerspeed_x = 0
	playerspeed_y = 0
	Player.sprite.rotation = 0
	endgame = true
	incontrol = false
	endwave=true
end

function OnHit(k)
	if k.GetVar("color") == "red" then
		KnifeHurt(3)
		Effects("curse",2)
	elseif k.GetVar("color") == "fatal" then
		if GetGlobal("KnifeProtection") == true then
			if Player.hp > 5 then
				Effects("curse",2)
				KnifeHurt(5)
			else
				GameOver()
			end
		else
			GameOver()
		end
	elseif k.GetVar("color") == "gold" then
		KnifeHurt(2)
		Effects("curse",1)
	elseif k.GetVar("color") == "blue" and isMoving() then
		KnifeHurt(2)
		Effects("curse",1)
	elseif k.GetVar("color") == "orange" and not isMoving() then
		KnifeHurt(2)
		Effects("curse",1)
	elseif k.GetVar("color") == "white" then
		KnifeHurt(1)
		Effects("curse",1)
	end
end