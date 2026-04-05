require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
rand=math.random(5)
knifes={}
Arena.ResizeImmediate(125,125)
function SendKnife(pos,speed,name)
	local knife=CreateProjectile(name,pos[1],pos[2])
	knife.SetVar("time",0)
	knife.SetVar("speed",speed)	
	knife.SetVar("sudden",false)
	--knife.sprite.rotation=math.random(360)
	knife.sprite.alpha=0
	table.insert(knifes,knife)
end

function QuickKnife(pos,speed,name)
	local knife=CreateProjectile(name,pos[1],pos[2])
	knife.SetVar("time",0)
	knife.SetVar("extra",60)
	knife.SetVar("speed",speed)	
	--knife.sprite.rotation=math.random(360)
	knife.sprite.alpha=1
	knife.SetVar("sudden",true)
	table.insert(knifes,knife)
end
function Update()
HurtUpd(600)
Moving()
if spawntime%10==1 and spawntime<40 then
	local i=spawntime+9
	i=i/10
	local y=75-25*i
	QuickKnife({200,y},{-5,0},"KnifeLeft")
	QuickKnife({-200,y},{5,0},"KnifeRight")
end
if spawntime%45==20 then
	if rand==5 then
		rand=4
		elseif rand==1 then
		rand=2
		else
		rand=rand+(math.random(2)*2-3)
	end
	for i=1,5 do
		local x=-75+25*i
		local y=-225
		if i==rand then
			SendKnife({x,y},{0,5},"KnifeUp")
			else
			SendKnife({x,300},{0,-5},"KnifeDown")
		end
	end
end
spawntime=spawntime+1
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local sp=k.GetVar("speed")
		if time<31 then	
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
		if time>30 and time<60 and k.GetVar("sudden")==false then
			local sin=math.sin((time-30)*math.pi/60)
			k.Move(sp[1]*sin,sp[2]*sin)
			elseif (time>20 and k.GetVar("sudden")==true) or time>30 then
			k.Move(sp[1],sp[2])
		end
		if k.x>600 or k.x<-600 or k.y>600 or k.y<-600 then
			k.Remove()
		end
	end
end



end

function OnHit()
	KnifeHurt(1)
	Effects("curse",1)
end