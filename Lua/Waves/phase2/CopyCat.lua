Arena.ResizeImmediate(220,220)
Player.MoveTo(0,0,true)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
kv={}
kh={}

function SendKnifes(side,n)
	if side=="vert" then
		if n==1 then
			local knife=CreateProjectile("KnifeDown",Player.x,202)
			knife.SetVar("time",0)
			knife.SetVar("speed",{0,-4})
			knife.sprite.alpha=0
			knife.SetVar("side",-1)
			table.insert(kv,knife)
			else
			local knife=CreateProjectile("KnifeUp",Player.x,-202)
			knife.SetVar("time",0)
			knife.SetVar("speed",{0,4})
			knife.sprite.alpha=0
			knife.SetVar("side",1)
			table.insert(kv,knife)
		end
		else
		if n==1 then
			local knife=CreateProjectile("KnifeLeft",202,Player.y)
			knife.SetVar("time",0)
			knife.SetVar("speed",{-4,0})
			knife.sprite.alpha=0
			knife.SetVar("side",-1)
			table.insert(kh,knife)
			else
			local knife=CreateProjectile("KnifeRight",-202,Player.y)
			knife.SetVar("time",0)
			knife.SetVar("speed",{4,0})
			knife.sprite.alpha=0
			knife.SetVar("side",1)
			table.insert(kh,knife)
		end
	end
end

function Update()
HurtUpd(540)
Moving()
spawntime=spawntime+1
for i=1,#kv do
	local k=kv[i]
	if k.isactive then
		local sp=k.GetVar("speed")
		local side=k.GetVar("side")
		if math.abs(side)==2 then
			k.MoveTo(k.GetVar("x")*Arena.width/220,Arena.height/side-64/side)
			elseif k.y==side*(Arena.height/2-32) then
			k.SetVar("side",side*2)
			k.SetVar("x",k.x)
			else
			k.Move(sp[1],sp[2])
		end
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time<31 then	
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
	end
end
for i=1,#kh do
	local k=kh[i]
	if k.isactive then
		local sp=k.GetVar("speed")
		local side=k.GetVar("side")
		if math.abs(side)==2 then
			k.MoveTo(Arena.width/side-64/side,k.GetVar("y")*Arena.width/220)
			elseif k.x==side*(Arena.width/2-32) then
			k.SetVar("side",side*2)
			k.SetVar("y",k.y)
			else
			k.Move(sp[1],sp[2])
		end
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time<31 then	
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
	end
end

if spawntime<200 and spawntime%30==0 then
	SendKnifes("vert",(spawntime/30)%2)
	elseif spawntime<390 and spawntime%30==0 then
	SendKnifes("hor",(spawntime/30)%2)
end
if spawntime>450 and spawntime<510 then
	local cos=90+130*math.cos((spawntime-450)*math.pi/120)
	Arena.MoveToAndResize(320,200-cos/2,cos,cos,false,true)
end
end

function OnHit()
KnifeHurt(1)
Effects("curse",1)
end