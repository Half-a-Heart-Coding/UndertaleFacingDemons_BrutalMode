Arena.ResizeImmediate(150,150)
Arena.Move(0,100,true,true)
Player.MoveTo(0,0,true)
shottime=20
spawntime=0
require "Libraries/Playermove"
require "Libraries/control"
bolt_anim={"bolt_left","bolt_right"}
spawn=false
spears={}
fires={}
local range=210
oldrot=false


function DoSpear()
	local rot=math.random(0,360)
	local side=math.random(2)*2-3
	local dist=0
	if oldrot!=false then
		dist=oldrot-rot
		if dist<0 then
			dist=dist+360
		end
		if dist>180 then
			dist=360-dist
		end
	end
	while dist>90 do
		rot=math.random(0,360)
		dist=oldrot-rot
		if dist<0 then
			dist=dist+360
		end
		if dist>180 then
			dist=360-dist
		end
	end
	local x=range*math.cos(rot*math.pi/180)
	local y=range*math.sin(rot*math.pi/180)
	local amm=9
	local spear=CreateProjectile("ToriSpear1",x,y)
	spear.sprite.rotation=180+rot
	spear.sprite.color={1,1,0}
	spear.SetVar("side",side)
	spear.SetVar("time",0)
	spear.SetVar("amm",amm)
	spear.SetVar("rot",rot)
	spear.sprite.alpha=0
	table.insert(spears,spear)
	oldrot=rot+side*amm*10
	if oldrot<0 then
		oldrot=360+oldrot
		elseif oldrot>360 then
		oldrot=-360+oldrot
	end
	--DEBUG(oldrot) 
end

function Fire(point,speed)
	local fire=CreateProjectile("bullet",point[1],point[2])
	fire.SetVar("speed",speed)
	fire.SetVar("time",0)
	fire.sprite.color={1,1,0}
	table.insert(fires,fire)
end
function Update()
Moving()
TimeUpd(600)
spawntime=spawntime+1
if spawntime%90==1 then
	DoSpear()
end
for i=1,#spears do
	local s=spears[i]
	if s.isactive then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		local rot=s.GetVar("rot")
		local side=s.GetVar("side")
		if time<61 then
			s.sprite.alpha=math.sin(time*math.pi/120)
			elseif time<120 then
			local newrot=rot+side*(time-60)*90/60
			s.sprite.rotation=180+newrot
			if (time-30)%6==1 then
				local r=newrot-180
				local point={s.x+s.sprite.width/2*math.cos(r*math.pi/180)+s.sprite.height/2*math.sin(r*math.pi/180),s.y+s.sprite.width/2*math.sin(r*math.pi/180)+s.sprite.height/2*math.cos(r*math.pi/180)}
				local speed={-4*math.cos(newrot*math.pi/180),-4*math.sin(newrot*math.pi/180)}
				Fire(point,speed)
			end
			newpos={range*math.cos(newrot*math.pi/180),range*math.sin(newrot*math.pi/180)}
			s.MoveTo(newpos[1],newpos[2])
			elseif time<150 then
			s.sprite.alpha=math.sin((time-90)*math.pi/60)
			else
			s.Remove()
		end
	end
end
for i=1,#fires do
	local f=fires[i]
	if f.isactive then
		local time=f.GetVar("time")+1
		local speed=f.GetVar("speed")
		f.SetVar("time",time)
		f.Move(speed[1],speed[2])
		--f.sprite.alpha=math.cos(time*math.pi/100)
		if time==30 then
			f.Remove()
		end
	end
end
end
function OnHit(b)
	Flower(5)
	b.Remove()
end