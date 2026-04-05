Arena.ResizeImmediate(140,140)
Arena.Move(0,75,true,true)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
circle={}
knifes={}
collision = require "Libraries/rotational_collision"
local rad=70
local ang=math.random(360)
local num=1
point={0,0}
speedy={0,0}
speed={0,0}
speedysave={0,0}
speedtime=21

function DoCircle(ingo)
	local knife=CreateProjectile("KnifeLeft",-100,-100)
	knife.SetVar("time",0)
	knife.SetVar("flytime",0)
	knife.sprite.alpha=0
	table.insert(circle,knife)
	knife=CreateProjectile("KnifeLeft",-100,-100)
	knife.SetVar("time",0)
	knife.SetVar("flytime",0)
	knife.sprite.alpha=0
	table.insert(circle,knife)
end

	
function DoDirection()
	local dir=math.random(360)
	speed={1.5*math.cos(dir*math.pi/180),1.5*math.sin(dir*math.pi/180)}
	speedysave=speedy
	speedtime=0
end

function Update()
HurtUpd(660)
Moving()
if speedtime<21 then
	speedtime=speedtime+1
	local new=math.sin(speedtime*math.pi/40)
	local old=1-new
	speedy={speedysave[1]*old+speed[1]*new,speedysave[2]*old+speed[2]*new}
end
		
point={point[1]+speedy[1],point[2]+speedy[2]}
if point[1]>60 then
	point[1]=60
	elseif point[1]<-60 then
	point[1]=-60
end
if point[2]>60 then
	point[2]=60
	elseif point[2]<-60 then
	point[2]=-60
end
if spawntime==120 or spawntime==160 or spawntime==200 then
	DoDirection()
	elseif spawntime==240 then
	speedy={0,0}
	speed={0,0}
end
if spawntime>240 and (point[1]<0 or point[1]>0 or point[2]<0 or point[2]>0) then
	if point[1]>0 then
		if point[1]<1 then
			point[1]=0
			else
			point[1]=point[1]-1
		end
		elseif point[1]<0 then
		if point[1]>-1 then
			point[1]=0
			else
			point[1]=point[1]+1
		end
	end
	if point[2]>0 then
		if point[2]<1 then
			point[2]=0
			else
			point[2]=point[2]-1
		end
		elseif point[2]<0 then
		if point[2]>-1 then
			point[2]=0
			else
			point[2]=point[2]+1
		end
	end
end
if spawntime>20 and spawntime<92 and spawntime%3==0 then
	DoCircle()
end
if spawntime<300 then
	ang=ang+2
	elseif spawntime<360 then
	ang=ang+2-1.5*math.sin((spawntime-300)*math.pi/120)
	else
	ang=ang+0.5
end

if spawntime>240 and spawntime<271 then
	rad=70+spawntime-240
end
if spawntime>300 and spawntime<445 and (spawntime-300)%9==0 then
	local num=(spawntime-300)/9
	circle[num].SetVar("flytime",1)
	circle[num+16].SetVar("flytime",1)
	circle[num+32].SetVar("flytime",1)
end
spawntime=spawntime+1
for i=1,#circle do
	local k=circle[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		local flytime=k.GetVar("flytime")
		k.SetVar("time",time)
		local sin=k.GetVar("sin")
		local cos=k.GetVar("cos")
		if (Player.x+34>k.x and Player.x-34<k.x) and (Player.y+34>k.y and Player.y-34<k.y) then
			if collision.CheckCollision(Player,k) then
				KnifeHurt(1)
				Effects("curse",1)
			end
		end
		if time<31 then
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
		local rot=1
		if spawntime<300 then
			if i%2==1 then
				rot=ang+180/48*(i-1)
				else
				rot=ang+180/48*(i-2)+180
			end
			else
			rot=ang+360/48*(i-1)
		end
		k.sprite.rotation=rot
		local sin=math.sin(rot*math.pi/180)
		local cos=math.cos(rot*math.pi/180)
		if time<61 then
			local d=rad+240*(1-math.sin(time*math.pi/120))
			k.MoveTo(point[1]+d*cos,point[2]+d*sin)
			else
			if flytime==0 then
				k.MoveTo(point[1]+rad*cos,point[2]+rad*sin)
				elseif flytime<90 then
				local d=rad+150*math.sin(flytime*math.pi/180)
				k.MoveTo(d*cos,d*sin)
				elseif flytime<120 then
				local d=rad+150*math.sin((flytime-60)*math.pi/60)
				k.MoveTo(d*cos,d*sin)
				elseif flytime<500 then
				local d=rad-(flytime-120)*8
				k.MoveTo(d*cos,d*sin)
				else
				k.Remove()
			end
		end


		if flytime>0 then
			flytime=flytime+1
			k.SetVar("flytime",flytime)
		end
	end
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local sp=k.GetVar("speed")
		if time<30 then
			elseif time<60 then
			k.Move(sp[1]*math.sin((time-30)*math.pi/60),sp[2]*math.sin((time-30)*math.pi/60))
			else
			k.Move(sp[1],sp[2])
		end
		if time<31 then	
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
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