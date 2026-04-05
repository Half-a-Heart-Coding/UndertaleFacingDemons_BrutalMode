Arena.Resize(128,128)
Arena.Move(0,60,true,true)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}

function SendKnife(pos,speed,name,time)
	local knife=CreateProjectile(name,pos[1],pos[2])
	knife.SetVar("time",0)
	knife.SetVar("top",time)
	knife.SetVar("speed",speed)
	knife.sprite.alpha=0
	table.insert(knifes,knife)
end

function Update()
if spawntime%45==0 then
	local rand1=math.random(2)
	local rand2=math.random(2)*2-3
	local r=180
	if rand1==1 then
		SendKnife({r*rand2,32},{-2*rand2,0},"KnifeDown",r)
		SendKnife({-r*rand2,-32},{2*rand2,0},"KnifeUp",r)
		else
		SendKnife({32,r*rand2},{0,-2*rand2},"KnifeLeft",r)
		SendKnife({-32,-r*rand2},{0,2*rand2},"KnifeRight",r)
	end
end
HurtUpd(600)
Moving()
spawntime=spawntime+1
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
		if k.x>600 or k.x<-600 or k.y>400 or k.y<-400 then
			k.Remove()
		end
	end
end



end

function OnHit()
KnifeHurt(1)
end