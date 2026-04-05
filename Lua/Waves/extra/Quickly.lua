Arena.ResizeImmediate(64,80)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=-10
knifes={}
knife1=false
knife2=false
function SendKnife(pos,speed,name,give)
	local knife=CreateProjectile(name,pos[1],pos[2])
	knife.SetVar("time",0)
	knife.SetVar("color","knife")
	knife.SetVar("speed",speed)
	knife.sprite.alpha=0
	if not give then
		table.insert(knifes,knife)
		else
		return knife
	end

end

function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
--[[if spawntime==-9 then
	SendKnife({-150,30},{3,0},"KnifeRight")
	SendKnife({150,30},{-3,0},"KnifeLeft")
	elseif spawntime==0 then
	SendKnife({-150,10},{3,0},"KnifeRight")
	SendKnife({150,10},{-3,0},"KnifeLeft")
	elseif spawntime==10 then
	SendKnife({-150,-10},{3,0},"KnifeRight")
	SendKnife({150,-10},{-3,0},"KnifeLeft")
	elseif spawntime==60 then
	SendKnife({0,210},{0,-4},"KnifeDown")
	SendKnife({-22,-250},{0,4},"KnifeUp")
	SendKnife({22,-250},{0,4},"KnifeUp")
	elseif spawntime==100 then
	SendKnife({-150,30},{4,0},"KnifeRight")
	SendKnife({150,30},{-4,0},"KnifeLeft")
	elseif spawntime==110 then
	SendKnife({-150,10},{4,0},"KnifeRight")
	SendKnife({150,10},{-4,0},"KnifeLeft")
	elseif spawntime==135 then
	SendKnife({-150,-30},{4,0},"KnifeRight")
	SendKnife({150,-30},{-4,0},"KnifeLeft")
	elseif spawntime==145 then
	SendKnife({-150,-10},{4,0},"KnifeRight")
	SendKnife({150,-10},{-4,0},"KnifeLeft")
	elseif spawntime==166 then
	SendKnife({-24-210,-32},{4,0},"KnifeUp")
	SendKnife({-24+210,32},{-4,0},"KnifeDown")
	elseif spawntime==200 then
	SendKnife({24-210,32},{4,0},"KnifeDown")
	SendKnife({24+210,-32},{-4,0},"KnifeUp")
	elseif spawntime==270 then
	knife1=SendKnife({32,50},{0,0},"KnifeLeft",true)
	elseif spawntime==285 then
	knife2=SendKnife({-32,-50},{0,0},"KnifeRight",true)
end]]

if spawntime==-9 then
	SendKnife({-210,30},{3,0},"KnifeRight")
	SendKnife({210,30},{-3,0},"KnifeLeft")
	elseif spawntime==0 then
	SendKnife({-210,10},{3,0},"KnifeRight")
	SendKnife({210,10},{-3,0},"KnifeLeft")
	elseif spawntime==10 then
	SendKnife({-210,-10},{3,0},"KnifeRight")
	SendKnife({210,-10},{-3,0},"KnifeLeft")
	elseif spawntime==80 then
	SendKnife({0,210},{0,-4},"KnifeDown")
	SendKnife({-22,-250},{0,4},"KnifeUp")
	SendKnife({22,-250},{0,4},"KnifeUp")
	elseif spawntime==140 then
	SendKnife({-24-210,-32},{3,0},"KnifeUp")
	SendKnife({-24+210,32},{-3,0},"KnifeDown")
	elseif spawntime==200 then
	SendKnife({24-210,32},{4,0},"KnifeDown")
	SendKnife({24+210,-32},{-4,0},"KnifeUp")
	elseif spawntime==260 then
	knife1=SendKnife({32,50},{0,0},"KnifeLeft",true)
	elseif spawntime==261 then
	knife2=SendKnife({-32,-50},{0,0},"KnifeRight",true)
end

if knife1==false then
	else
	local k=knife1
	local time=knife1.GetVar("time")+1
	k.SetVar("time",time)
	if time<31 then
		k.sprite.alpha=math.sin(time*math.pi/60)
		elseif time<91 then
		local up=50*math.cos((time-30)*math.pi/60)
		k.MoveTo(32,up)
		elseif time<101 then
		local x=32*(100-time)/10
		k.MoveTo(x,-50)
		elseif time<146 then
		local up=14-64*math.cos((time-100)*math.pi/90)
		k.MoveTo(0,up)
		elseif time>175 and time<206 then
		k.sprite.alpha=math.cos((time-175)*math.pi/60)
		if k.sprite.alpha<0.5 then
			k.SetVar("color","none")
		end
		elseif time==206 then
		k.Remove()
		knife1=false
	end
end
if knife2==false then
	else
	local k=knife2
	local time=k.GetVar("time")+1
	k.SetVar("time",time)
	if time<31 then
		k.sprite.alpha=math.sin(time*math.pi/60)
		elseif time<91 then
		local up=-50*math.cos((time-30)*math.pi/60)
		k.MoveTo(-32,up)
		elseif time<190 then
		elseif time<201 then
		local x=-32*(200-time)/10
		k.MoveTo(x,50)
		elseif time<246 then
		local up=-14+64*math.cos((time-200)*math.pi/90)
		k.MoveTo(0,up)
		elseif time>275 and time<306 then
		k.sprite.alpha=math.cos((time-275)*math.pi/60)
		if k.sprite.alpha<0.5 then
			k.SetVar("color","none")
		end
		elseif time==306 then
		k.Remove()
		knife1=false
	end
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time<31 then	
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
		local speed=k.GetVar("speed")
		k.Move(speed[1],speed[2])
		if k.x>600 or k.x<-600 or k.y>400 or k.y<-400 then
			k.Remove()
		end
	end
end



end

function OnHit(k)
if k.GetVar("color")=="knife" then
	KnifeHurt(1)
end
end