Arena.ResizeImmediate(210,210)
Arena.Move(0,100,true,true)
Player.MoveTo(0,0,true)
shottime=20
spawntime=0
require "Libraries/Playermove"
require "Libraries/control"
bolt_anim={"bolt_left","bolt_right"}
spawn=false
seeds={}
local range=120
oldpoint=false


function DoCircle()
	local rand=math.random(12)
	local point={-101+math.random(201),-101+math.random(201)}
	if oldpoint!=false then
		local xfar=point[1]-oldpoint[1]
		local yfar=point[2]-oldpoint[2]
		local afar=math.sqrt(xfar*xfar+yfar*yfar)
		while afar>90 do
			point={-101+math.random(201),-101+math.random(201)}
			xfar=point[1]-oldpoint[1]
			yfar=point[2]-oldpoint[2]
			afar=math.sqrt(xfar*xfar+yfar*yfar)
		end
	end
	for i=1,30 do
		local rot=i*12+rand
		local x=point[1]+range*math.cos(rot*math.pi/180)
		local y=point[2]+range*math.sin(rot*math.pi/180)
		local seed=CreateProjectile("pellet",x,y)
		seed.sprite.color={1,1,0}
		seed.SetVar("point",point)
		seed.SetVar("rot",rot)
		seed.SetVar("time",0)
		seed.sprite.rotation=math.random(2)*90
		table.insert(seeds,seed)
	end
	oldpoint=point
end
function Update()
TimeUpd(600)
Moving()
spawntime=spawntime+1
if spawntime%60==1 then
	DoCircle()
end
for i=1,#seeds do
	local s=seeds[i]
	if s.isactive then
		local point=s.GetVar("point")
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		if time<30 then
			s.sprite.alpha=math.sin(time*math.pi/60)
		end
		local r=range
		if time>30 then
			r=range*(0.5+0.5*math.cos((time-30)*math.pi/60))
		end
		local rot=s.GetVar("rot")+2
		s.SetVar("rot",rot)
		local x=point[1]+r*math.cos(rot*math.pi/180)
		local y=point[2]+r*math.sin(rot*math.pi/180)
		if time%15==0 then
			s.sprite.rotation=s.sprite.rotation+90
		end
		s.MoveTo(x,y)
		if time==91 then
			s.Remove()
		end
	end
end
end
function OnHit(b)
	Flower(2)
	b.Remove()
end