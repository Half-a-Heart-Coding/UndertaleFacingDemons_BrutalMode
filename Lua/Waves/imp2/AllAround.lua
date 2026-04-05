Arena.ResizeImmediate(120,120)
Arena.Move(0,85,true,true)
require "Libraries/Playermove"
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"

local side=math.random(2)*2-3
local delta=0
local rot=0
local rad=60
local ugol=math.random(360)
direction=1

spawntime=0
knifes={}
timesSwitched=0

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

function DoAllKnifes()
	for t=1,6 do
		for i=1,3 do
			local r=ugol+t*20*side+i*120
			local x=120*math.cos(r*math.pi/180)
			local y=120*math.sin(r*math.pi/180)
			local spr = "KnifeLeft"
			if timesSwitched==1 and name4~="Fatal" then
				spr = "KnifeLeftDeadly"
			elseif timesSwitched==2 and name4~="Fatal" then
				spr = "KnifeLeftLethal"
			elseif (timesSwitched==3 and name4~="Fatal") or (timesSwitched<3 and name4=="Fatal") then
				spr = "KnifeLeftFatal"
			elseif name4=="Fatal" then
				spr = "KnifeLeftMutant"
			end
			local k=CreateProjectile(spr,x,y)
			k.sprite.rotation=r
			k.SetVar("sprtime",0)
			k.SetVar("time",-40-120/6*t)
			k.SetVar("rot",r)
			if timesSwitched==1 then
				k.SetVar("color","gold")
			elseif timesSwitched==2 then
				k.SetVar("color","red")
			elseif timesSwitched==3 then
				k.SetVar("color","fatal")
			else
				k.SetVar("color","white")
			end
			table.insert(knifes,k)
		end
	end
end
	
function SendKnife(pos,speed,name)
	local knife=CreateProjectile(name,pos[1],pos[2])
	knife.SetVar("time",0)
	knife.SetVar("speed",speed)
	knife.sprite.alpha=0
	table.insert(knifes,knife)
end

vzmahi = {}
deadtime=0
blasts = {}

endgame = false
lastsecond = 0
sdvig = 1

function Update()
HurtUpd(1200)
Moving()
if spawntime==1 then
	DoAllKnifes()
end
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
if spawntime%300==222 then
	side=-side
	timesSwitched=timesSwitched+1
	DoAllKnifes()
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local sprtime=k.GetVar("sprtime")+1
		k.SetVar("sprtime",sprtime)
		if sprtime<31 then	
			k.sprite.alpha=math.sin(sprtime*math.pi/60)
		end
		local ra=120
		if time>0 then
			--if direction==1 then
				ra=30+(45+45*math.cos(time*math.pi/60))
			--else
			--	ra=30+(45+45*(time*math.pi/60))
			--end
		end
		local ro=k.GetVar("rot")
		local x=ra*math.cos(ro*math.pi/180)
		local y=ra*math.sin(ro*math.pi/180)
		if direction==-1 then
			--x=x*(1-((ro*math.pi/360)/math.pi))
			--y=y*(1-((ro*math.pi/360)/math.pi))
		end
		--if direction==1 then
			k.MoveTo(x,y)
		--else
		--	k.MoveTo(-x,-y)
		--end
		if (Player.x+34>k.x and Player.x-34<k.x) and (Player.y+34>k.y and Player.y-34<k.y) then
			if collision.CheckCollision(Player,k) then
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
		end
		if k.x>600 or k.x<-600 or k.y>400 or k.y<-400 or spawntime%300==0 and time>60 then
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

function OnHit()
end