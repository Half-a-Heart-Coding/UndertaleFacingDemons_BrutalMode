spawntime=0
knifes={}
timer3={}
require "Libraries/Playermove"
require "Libraries/hurt"
Arena.ResizeImmediate(100,100)
Player.MoveTo(0,0,false)

function SendKnife(point)
	local x=6
	local k=CreateProjectile("KnifeDown",point[1],300)
	k.SetVar("speed",{0,-x})
	k.SetVar("time",0)
	k.sprite.alpha=0
	table.insert(knifes,k)
	k=CreateProjectile("KnifeUp",point[1],-300)
	k.SetVar("speed",{0,x})
	k.SetVar("time",0)
	k.sprite.alpha=0
	table.insert(knifes,k)
	k=CreateProjectile("KnifeRight",-300,point[2])
	k.SetVar("speed",{x,0})
	k.SetVar("time",0)
	k.sprite.alpha=0
	table.insert(knifes,k)
	k=CreateProjectile("KnifeLeft",300,point[2])
	k.SetVar("speed",{-x,0})
	k.SetVar("time",0)
	k.sprite.alpha=0
	table.insert(knifes,k)
end

function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
if spawntime%90==45 then
	SendKnife({37.5,37.5})
	SendKnife({-37.5,-37.5})
	elseif spawntime%90==0 then
	SendKnife({-12.5,-12.5})
	SendKnife({12.5,12.5})
end
for i=1,#knifes do
	local knife=knifes[i]
	if knife.isactive then
		local s=knife.GetVar("speed")
		knife.Move(s[1],s[2])
		local time=knife.GetVar("time")+1
		knife.SetVar("time",time)
		if time<31 then
			knife.sprite.alpha=math.sin(time*math.pi/60)
		end
		if knife.x>600 or knife.x<-600 or knife.y>600 or knife.y<-600 then
			knife.Remove()
		end
	end
end
end
function OnHit()
	KnifeHurt(1)
end