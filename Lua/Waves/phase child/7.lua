 Arena.ResizeImmediate(150,200)
Player.MoveTo(0,0,true)
shottime=20
spawntime=0
require "Libraries/control"
require "Libraries/Playermove"
Player.SetControlOverride(true)

shieldtime=0
pewtime=0
lists={}
pews={}
bolt_anim={"bolt_left","bolt_right"}
spawn=false
donuts={}
local range=210
oldrot=false
tri=CreateProjectile("trid",-380,0)
tri.sprite.rotation=0
Wind=0


function SendList(side)
	local x=math.random(90)+90
	x=x*side
	local sid=math.random(2)*2-3
	local list=CreateProjectile("leaf_r",x,140)
	list.sprite.color={1,1,0}
	list.SetVar("time",0)
	list.SetVar("urg",0)
	list.SetVar("sid",sid)
	list.SetVar("color","good")
	list.sprite.scale(sid,1)
	list.SetVar("urgtime",0)
	table.insert(lists,list)
end


function Update()
if spawntime%20==1 then
	SendList(1)
	elseif spawntime%20==11 then
	SendList(-1)
end
if true then
	local s=spawntime%240
	if s==1 then
		tri.MoveTo(-360,0)
		tri.sprite.rotation=0
		elseif s==121 then
		tri.MoveTo(360,0)
		tri.sprite.rotation=0
		elseif s>60 and s<90 then
		if s<66 then
			tri.sprite.rotation=-90+90*math.cos((s-60)*math.pi/30)
			elseif s==66 then
			Audio.PlaySound("appear")
			Wind=1
			tri.sprite.rotation=90
			tri.sprite.Set("trid0")
			tri.sprite.Scale(2,2)
			elseif s==72 then
			tri.sprite.Set("trid1")
			elseif s==78 then
			tri.sprite.Set("trid1")
			elseif s>83 then
			Wind=0
			tri.sprite.rotation=-90+90*math.cos((s-60)*math.pi/30)
			tri.sprite.Set("trid")
			tri.sprite.Scale(1,1)
		end
		elseif s>180 and s<210 then
		if s<186 then
			tri.sprite.rotation=90-90*math.cos((s-180)*math.pi/30)
			elseif s==186 then
			Audio.PlaySound("appear")
			Wind=-1
			tri.sprite.rotation=-90
			tri.sprite.Set("trid2")
			tri.sprite.Scale(2,2)
			elseif s==192 then
			tri.sprite.Set("trid1")
			elseif s==198 then
			tri.sprite.Set("trid0")
			elseif s>203 then
			Wind=0
			tri.sprite.rotation=90-90*math.cos((s-180)*math.pi/30)
			tri.sprite.Set("trid")
			tri.sprite.Scale(1,1)
		end
	end
end
for i=1,#lists do
	local l=lists[i]
	if l.isactive then
		local t=l.GetVar("time")+1
		l.SetVar("time",t)
		local sid=l.GetVar("sid")
		if Wind!=0 and math.abs(l.x)>50 and (Wind*l.x)<0 and Wind!=l.GetVar("urg") then
			l.SetVar("urg",Wind)
			t=Wind*30*sid
			l.SetVar("urgtime",31)
		end
		if l.GetVar("urgtime")>0 then
			l.SetVar("urgtime",l.GetVar("urgtime")-1)
		end
		local urgtime=l.GetVar("urgtime")
		local sin=math.sin(t*sid*math.pi/90)
		local cos=math.cos(t*math.pi/90)
		local y=-cos*cos-math.abs(l.GetVar("urg")*(1+math.sin(urgtime*math.pi/60)))
		local x=sin+(1+math.sin(urgtime*math.pi/60))*l.GetVar("urg")
		l.sprite.rotation=(20+20*sin)*sid+20*l.GetVar("urg")
		l.Move(x,y)
	end
end
TimeUpd(600)
Moving()
spawntime=spawntime+1






end
function OnHit(b)
	if b.GetVar("color")=="good" then
		Flower(12)
		b.Remove()
	end
end