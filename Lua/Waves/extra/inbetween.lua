spawntime=0
shadows={}
left={}
rot={}
rand1=math.random(2)*2-3
rand2=math.random(2)*2-3
washitted=false
collision = require "Libraries/rotational_collision"
for i=1,300 do
	left[i]=CreateProjectile("empty",0,0)
	left[i].SetVar("color",none)
	left[i].SetVar("togo","none")
end
num=1
Arena.ResizeImmediate(220,96)
Arena.Move(0,40)
Player.MoveTo(0,0,true)
require "Libraries/Playermove"
require "Libraries/hurt"

function SendRotation(pos,speed,rotation,firstrot,shadow)
	local knife=CreateProjectile("KnifeRight",pos[1],pos[2],"Top")
	knife.SetVar("time",0)
	knife.SetVar("speed",speed)
	knife.SetVar("rot",rotation)
	knife.sprite.rotation=firstrot
	knife.SetVar("shadow",false)
	table.insert(rot,knife)
end
function SendShadow(name, position, speed, istrue, shadowtime)
	local knife=CreateProjectile("Knife"..name,position[1],position[2],"Top")
	knife.SetVar("speed",speed)
	knife.SetVar("name",name)
	knife.SetVar("time",0)
	knife.sprite.alpha=0
	if not shadowtime then
		knife.SetVar("shadowtime",7)
		else
		knife.SetVar("shadowtime",shadowtime)
	end
	knife.SetVar("istrue",istrue)
	knife.SetVar("color","knife")
	table.insert(shadows,knife)
	time=0
end


function Update()
washitted=false
	HurtUpd(540)
	Moving()
	spawntime=spawntime+1
	if spawntime==30 then
		for i=1,6 do
			SendShadow("Down",{-140+40*i,240},{0,-4},true,5)
		end
		for i=1,5 do
			SendShadow("Up",{-120+40*i,-200},{0,4},false,5)
		end
	end
	if spawntime==120 then
		SendRotation({320*rand1,24*rand2},-6*rand1,-4*rand1,-90*rand2,true)
		elseif spawntime==150 then
		SendRotation({-320*rand1,-24*rand2},6*rand1,4*rand1,90*rand2,true)
		elseif spawntime==180 then
		SendRotation({-320*rand1,24*rand2},6*rand1,4*rand1,-90*rand2,true)
		elseif spawntime==210 then
		SendRotation({320*rand1,-24*rand2},-6*rand1,-4*rand1,90*rand2,true)
		elseif spawntime==240 then
		SendRotation({320*rand1,24*rand2},-6*rand1,-4*rand1,-90*rand2,true)
		elseif spawntime==270 then
		SendRotation({-320*rand1,-24*rand2},6*rand1,4*rand1,90*rand2,true)
		elseif spawntime==300 then
		SendRotation({-320*rand1,24*rand2},6*rand1,4*rand1,-90*rand2,true)
		elseif spawntime==330 then
		SendRotation({320*rand1,-24*rand2},-6*rand1,-4*rand1,90*rand2,true)
	end
	if spawntime==360 then
		SendRotation({320,-24},-6,-6,90,false)
		SendRotation({-320,-24},6,6,90,false)
		elseif spawntime==390 then
		SendRotation({320,24},-6,-6,-90,false)
		SendRotation({-320,24},6,6,-90,false)
		elseif spawntime==420 then
		SendRotation({320,-24},-6,-6,90,false)
		SendRotation({-320,-24},6,6,90,false)
	end
	if spawntime==430 then
		for i=1,6 do
			SendShadow("Down",{-140+40*i,200},{0,-4},false,5)
		end
		for i=1,5 do
			SendShadow("Up",{-120+40*i,-240},{0,4},true,5)
		end
	end
	for i=1,#shadows do
		local s=shadows[i]
		if s.isactive then
			local time=s.GetVar("time")+1
			s.SetVar("time",time)
			local speed=s.GetVar("speed")
			s.Move(speed[1],speed[2])
			if time<31 then
				s.sprite.alpha=math.sin(time*math.pi/60)
				elseif (time-31)%s.GetVar("shadowtime")==0 and s.GetVar("istrue")==true then
				left[num].sprite.Set("Knife"..s.GetVar("name"))
				left[num].MoveTo(s.x,s.y)
				left[num].SetVar("time",0)
				left[num].SetVar("color","knife")
				left[num].SetVar("togo","long")
				left[num].sprite.rotation=0
				num=num+1
				if num==301 then
					num=1
				end
			end
			if s.x>400 or s.x<-400 then
				s.Remove()
			end
		end
	end
	for i=1,#left do
		local s=left[i]
		if s.GetVar("togo")=="long" then
			local time=s.GetVar("time")+1
			s.SetVar("time",time)
			if time<41 then
				local sin=0.75*math.cos(time*math.pi/80)
				s.sprite.color={0.625+0.375*math.cos(math.pi*time/10),0,0}
				s.sprite.alpha=sin
				if time==30 then
					s.SetVar("color","none")
				end
				else
				s.SetVar("togo","none")
			end
			elseif s.GetVar("togo")=="fast" then
			local time=s.GetVar("time")+1
			s.SetVar("time",time)
			if time<16 then
				local sin=0.75*math.cos(time*math.pi/30)
				s.sprite.color={0.625+0.375*math.cos(math.pi*time/4),0,0}
				s.sprite.alpha=sin
				if time==10 then
					s.SetVar("color","none")
				end
				else
				s.SetVar("togo","none")
			end
		end
	end
	for i=1,#rot do
		local k=rot[i]
		if k.isactive then
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<31 then
				k.sprite.alpha=math.sin(time*math.pi/60)
				elseif k.GetVar("shadow")==true then
				left[num].sprite.Set("KnifeRight")
				left[num].MoveTo(k.x,k.y)
				left[num].SetVar("time",0)
				left[num].SetVar("color","shadow")
				left[num].SetVar("togo","fast")
				left[num].sprite.rotation=k.sprite.rotation
				num=num+1
				if num==301 then
					num=1
				end
			end
			k.Move(k.GetVar("speed"),0)
			k.sprite.rotation=k.sprite.rotation+k.GetVar("rot")
			if k.x>600 or k.x<-600 then
				k.Remove()
			end
			if washitted==false then
				if (Player.x+34>k.x and Player.x-34<k.x) and (Player.y+34>k.y and Player.y-34<k.y) then
					if collision.CheckCollision(Player,k) then
						KnifeHurt(1)
						washitted=true
					end
				end
			end
		end
	end
end

function OnHit(ingo)
--Effects("curse",1)
--KnifeHurt(1)
local c=ingo.GetVar("color")
if c=="knife" then
	local x=ingo.x
	local y=ingo.y
	local w=ingo.sprite.width/2+4
	local h=ingo.sprite.height/2+4
	local px=Player.x
	local py=Player.y
	if px+w>x and px-w<x and py+h>y and py-h<y then
		KnifeHurt(1)
	end
end
end