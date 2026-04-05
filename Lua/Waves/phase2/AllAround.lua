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

spawntime=0
knifes={}

function DoAllKnifes()
	for t=1,6 do
		for i=1,3 do
			local r=ugol+t*20*side+i*120
			local x=120*math.cos(r*math.pi/180)
			local y=120*math.sin(r*math.pi/180)
			local k=CreateProjectile("KnifeLeft",x,y)
			k.sprite.rotation=r
			k.SetVar("sprtime",0)
			k.SetVar("time",-40-120/6*t)
			k.SetVar("rot",r)
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

function Update()
HurtUpd(600)
Moving()
if spawntime==1 then
	DoAllKnifes()
end
spawntime=spawntime+1
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
			ra=30+(45+45*math.cos(time*math.pi/60))
		end
		local ro=k.GetVar("rot")
		local x=ra*math.cos(ro*math.pi/180)
		local y=ra*math.sin(ro*math.pi/180)
		k.MoveTo(x,y)
		if (Player.x+34>k.x and Player.x-34<k.x) and (Player.y+34>k.y and Player.y-34<k.y) then
			if collision.CheckCollision(Player,k) then
				KnifeHurt(1)
				Effects("curse",1)
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