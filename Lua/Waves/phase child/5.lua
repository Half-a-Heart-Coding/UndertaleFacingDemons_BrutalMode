Arena.ResizeImmediate(200,150)
Arena.Move(0,100,true,true)
Player.MoveTo(0,0,true)
shottime=20
spawntime=0
require "Libraries/control"
Player.SetControlOverride(true)

line=0
local l=CreateProjectile("purplepoint",0,37.5)
l.sprite.Scale(200,2)
l=CreateProjectile("purplepoint",0,0)
l.sprite.Scale(200,2)
l=CreateProjectile("purplepoint",0,-37.5)
l.sprite.Scale(200,2)

bolt_anim={"bolt_left","bolt_right"}
spawn=false
donuts={}
local range=210
oldrot=false
spid=CreateProjectile("spiderdonut0",0,-130,"BelowBullet")
spid.sprite.alpha=0
spid.SetVar("time",0)


function SendWave()
	for i=1,5 do
		local x=-51+math.random(101)
		local side=math.random(2)*2-3
		local d=CreateProjectile("donut",x,-130,"BelowPlayer")
		d.sprite.color={1,1,0}
		local ugol=44+math.random(91)
		local xs=3*math.cos(ugol*math.pi/180)
		local ys=3*math.sin(ugol*math.pi/180)
		d.SetVar("speed",{xs,ys})
		d.SetVar("color","donut")
		table.insert(donuts,d)
	end
end


function Update()
if Input.Up==1 and line<1 then
	line=line+1
	Player.MoveTo(Player.x,line*37.5,false)
	elseif Input.Down==1 and line>-1 then
	line=line-1
	Player.MoveTo(Player.x,line*37.5,false)
end
if Input.Left>0 and Input.Right==0 then
	Player.MoveTo(Player.x-2,Player.y,false)
	elseif Input.Left==0 and Input.Right>0 then
	Player.MoveTo(Player.x+2,Player.y,false)
end
TimeUpd(600)
spawntime=spawntime+1

for i=1,#donuts do
	local d=donuts[i]
	if d.isactive then
		local s=d.GetVar("speed")
		d.Move(s[1],s[2])
		local w=d.sprite.width/2
		local h=d.sprite.height/2
		if (d.x+w>100 and s[1]>0) or (d.x-w<-100 and s[1]<0) then
			s[1]=-s[1]
		end
		if (d.y+h>75 and s[2]>0) or (d.y-h<-75 and s[2]<0) then
			s[2]=-s[2]
		end
	end
end

if true then
	local s=spid
	local t=s.GetVar("time")+1
	s.SetVar("time",t)
	if t<31 then
		s.sprite.alpha=math.sin(t*math.pi/60)
		else
		t=t-31
		if t%30==0 then
			s.sprite.Set("spiderdonut"..(t/30)%4)
			if t%120==60 then
				SendWave()
			end
		end
	end
end


end
function OnHit(b)
	if b.GetVar("color")=="donut" then
		Flower(12)
		b.Remove()
	end
end