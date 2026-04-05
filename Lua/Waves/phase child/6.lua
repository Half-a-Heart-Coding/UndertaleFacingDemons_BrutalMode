Arena.ResizeImmediate(50,50)
Arena.MoveTo(320,240-25-5,true,true)
Player.MoveTo(0,0,true)
shottime=20
spawntime=0
require "Libraries/control"
Player.SetControlOverride(true)

shieldtime=0
pewtime=0
boxs={}
spears={}
pews={}
bolt_anim={"bolt_left","bolt_right"}
spawn=false
donuts={}
local range=210
oldrot=false
frees={true,true,true,true}
frees1={true,true,true,true}



function SendBox(pos,howfar)
	if pos>0 then
		local point={}
		local circletime=0
		local t=howfar
		frees[pos]=false
		local topos=pos
		local sid=math.random(2)*2-3
		if topos==1 then
			point={-200,0}
			speed={0,sid*5}
			elseif topos==2 then
			point={0,-200}
			speed={sid*5,0}
			elseif topos==3 then
			point={200,0}
			speed={0,sid*5}
			else
			point={0,200}
			speed={sid*5,0}
		end
		point={point[1]-speed[1]*t,point[2]-speed[2]*t}
		local box=CreateProjectile("box/box",point[1],point[2])
		box.sprite.Scale(2,2)
		box.SetVar("pos",pos)
		box.SetVar("speed",speed)
		box.SetVar("time",0)
		box.SetVar("timer",t)
		box.SetVar("ctime",0)
		table.insert(boxs,box)
	end
end

HeartChange({1,0,1},"green")
Player.sprite.color={1,1,0}
fPlayer=CreateProjectile("green",0,0)
shield=CreateProjectile("green/shield",0,0)
SendBox(1,60)
SendBox(2,60)
SendBox(3,60)
SendBox(4,60)
function Update()
if Input.Right==1 then
	Player.sprite.rotation=270
	fPlayer.sprite.rotation=270
	shield.sprite.rotation=270
	elseif Input.Down==1 then
	Player.sprite.rotation=180
	fPlayer.sprite.rotation=180
	shield.sprite.rotation=180
	elseif Input.Left==1 then
	Player.sprite.rotation=90
	fPlayer.sprite.rotation=90
	shield.sprite.rotation=90
	elseif Input.Up==1 then
	Player.sprite.rotation=0
	fPlayer.sprite.rotation=0
	shield.sprite.rotation=0
end
if pewtime>0 then
	pewtime=pewtime-1
end
if Input.Confirm==1 and pewtime==0 then
	pewtime=20
	Audio.PlaySound("pew")
	local pew=CreateProjectile("shot",Player.x+4*math.sin(math.pi*Player.sprite.rotation/180),Player.y-4*math.cos(math.pi*Player.sprite.rotation/180))
	pew.sprite.rotation=Player.sprite.rotation
	local n=Player.sprite.rotation
	if n%360==0 then
		pew.SetVar("px",0)
		pew.SetVar("py",-12)
		elseif n%360==90 then
		pew.SetVar("px",12)
		pew.SetVar("py",0)
		elseif n%360==180 then
		pew.SetVar("px",0)
		pew.SetVar("py",12)
		elseif n%360==270 then
		pew.SetVar("px",-12)
		pew.SetVar("py",0)
	end
	table.insert(pews,pew)
end
TimeUpd(600)
if shieldtime>0 then
	shieldtime=shieldtime-1
	else
	shield.sprite.Set("green/shield")
end
for i=1,#spears do
	local s=spears[i]
	if s.isactive then
		local sp=s.GetVar("speed")
		s.Move(sp[1],sp[2])
		if math.abs(s.x)<50 and math.abs(s.y)<50 and s.sprite.rotation%360==shield.sprite.rotation%360 then
			s.Remove()
			Audio.PlaySound("reflect")
			shield.sprite.Set("green/shield_hit")
			shieldtime=2
		end
		if s.isactive and math.abs(s.x)<31 and math.abs(s.y)<31 then
			Flower(15)
			s.Remove()
		end
	end
end

for i=1,#pews do
	if pews[i].isactive then
		pews[i].Move(pews[i].GetVar("px"),pews[i].GetVar("py"))
	end
end

spawntime=spawntime+1

for i=1,#boxs do
	local box=boxs[i]
	if box.isactive then
		local t=box.GetVar("time")
		if t==0 then
			local ti=box.GetVar("timer")-1
			box.SetVar("timer",ti)
			local s=box.GetVar("speed")
			if ti>0 then		
				box.Move(s[1],s[2])
				else
				local c=box.GetVar("ctime")+1
				box.SetVar("ctime",c)
				local cos=math.cos(c*math.pi/60)
				box.Move(s[1]*cos,s[2]*cos)
			end
			for j=1,#pews do
				local pew=pews[j]
				if box.x>pew.x-20 and box.x<pew.x+20 and box.y>pew.y-20 and box.y<pew.y+20 and pew.isactive then
					pew.Remove()
					local pos=box.GetVar("pos")
					SendBox(pos,150)
					local rot=0
					local speed={}
					if box.x>100 then
						box.sprite.rotation=90
						rot=270
						speed={-1,0}
						elseif box.x<-100 then
						box.sprite.rotation=90
						speed={1,0}
						rot=90
						elseif box.y>100 then
						speed={0,-1}
						rot=0
						else
						rot=180
						speed={0,1}
					end
					box.SetVar("time",1)
					for i=1,3 do
						local spear=CreateProjectile("green/arrow",box.x,box.y)
						local sp=speed
						spear.sprite.rotation=rot
						spear.sprite.color={1,1,0}
						sp={sp[1]*i*2+1*sp[1],sp[2]*i*2+1*sp[2]}	
						spear.SetVar("speed",sp)
						table.insert(spears,spear)
					end
					box.sprite.Set("box/1")
					Audio.PlaySound("hit")
				end
			end
			elseif t<9 then
			t=t+1
			box.SetVar("time",t)
			box.sprite.alpha=(8-t)/8
			if t%2==0 then
				box.sprite.Set("box/"..((t/2)+1))
			end
			if t==9 then
				box.Remove()
			end
		end
	end
end






end
function OnHit(b)
end