shadealpha=0
knifes={}
shades=require "Libraries/NewSoul"
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0

Arena.Resize(145,145)
function Update()
spawntime=spawntime+1
HurtUpd()
Moving()
shadealpha=0
if Player.hp==1 then
	Player.hp=92
end
ShadeSoul(spawntime)
if spawntime%60==1 then
	local k=CreateProjectile("KnifeLeft",300,Player.y)
	table.insert(knifes,k)
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		k.Move(-5,0)
		for t=1,#shades do
			local s=shades[t]
			local w=k.sprite.width/2+6
			local h=k.sprite.height/2+6
			local x=k.x
			local y=k.y
			local sx=s.GetVar("x")
			local sy=s.GetVar("y")
			if x+w>sx and x-w<sx and y+h>sy and y-h<sy then
				shadealpha=shadealpha+s.alpha
			end
		end
		if k.x<-500 then
			k.Remove()
		end
	end
end
if shadealpha>0.5 then
	KnifeHurt(1)
end
end

function OnHit()
KnifeHurt(1)
end