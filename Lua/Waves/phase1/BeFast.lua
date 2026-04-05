Arena.Resize(128,128)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}

function SendKnife(pos,speed,name,time)
	local knife=CreateProjectile(name,pos[1],pos[2])
	knife.SetVar("time",0)
	knife.SetVar("speed",speed)
	knife.sprite.alpha=0
	knife.SetVar("top",time)
	table.insert(knifes,knife)
end

function Update()
HurtUpd(900)
Moving()
spawntime=spawntime+1
if spawntime%80==0 then
	SendKnife({32,120},{0,-1},"KnifeLeft",240)
	SendKnife({-32,-120},{0,1},"KnifeRight",240)
end
if spawntime%160==0 then
	local rand=math.random(4)
	Audio.PlaySound("blip")
	if rand==1 then
		SendKnife({-160,32},{2,0},"KnifeDown",160)
		elseif rand==2 then
		SendKnife({160,-32},{-2,0},"KnifeUp",160)
		elseif rand==3 then
		SendKnife({32,-160},{0,2},"KnifeLeft",160)
		else
		SendKnife({-32,160},{0,-2},"KnifeRight",160)
	end
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local speed=k.GetVar("speed")
		k.Move(speed[1],speed[2])
		local top=k.GetVar("top")
		if time<31 then	
			k.sprite.alpha=math.sin(time*math.pi/60)
			elseif time>top-30 and time<top then
			k.sprite.alpha=math.sin((time-top+60)*math.pi/60)
			elseif time==top then
			k.Remove()
		end
	end
end



end

function OnHit()
KnifeHurt(1)
end