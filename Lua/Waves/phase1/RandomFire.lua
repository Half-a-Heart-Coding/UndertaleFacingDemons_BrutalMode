Arena.ResizeImmediate(150,150)
Arena.Move(0,50,true,true)
require "Libraries/Playermove"
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"
spawntime=0
fires={}

BR=CreateProjectileAbs("system/BR",550,70)
spear1=CreateProjectile("ToriSpear",0,203,"Top")
spear1.sprite.alpha=0
spear1.SetVar("time",-1000)
spear1.SetVar("color","spear")
spear1.SetVar("firedo",{0,75,12,3.5,3.5})
spear1.SetVar("speed",{0,6})
spear2=CreateProjectile("ToriSpear",0,-203,"Top")
spear2.sprite.rotation=180
spear2.sprite.alpha=0
spear2.SetVar("time",-1000)
spear2.SetVar("color","spear")
spear2.SetVar("speed",{0,-6})
spears={spear1,spear2}
spear2.SetVar("firedo",{0,-75,0,3.5,3.5})
boom={}


function DoFire(ugol)
	local x=172*math.cos(ugol*math.pi/180)
	local y=172*math.sin(ugol*math.pi/180)
	local fire=CreateProjectile("bullet",x,y)
	fire.SetVar("ugol",ugol)
	fire.SetVar("time",0)
	fire.SetVar("color","fire")
	table.insert(fires,fire)
end

function Update()
if spawntime<60 then
	BR.sprite.alpha=math.sin(spawntime*math.pi/120)
end
hue=0.90-0.1*math.sin(math.pi*spawntime/30)
BR.sprite.color ={1*hue,0.5*hue,0.15234375*hue}
HurtUpd(750)
Moving()
if spawntime<31 then
	spear1.sprite.alpha=math.sin(spawntime*math.pi/60)
	spear2.sprite.alpha=spear1.sprite.alpha
	elseif spawntime<91 then
	rot=90+(spawntime-30)*180/60
	local x=203*math.cos(rot*math.pi/180)
	local y=203*math.sin(rot*math.pi/180)
	spear1.MoveTo(x,y)
	spear1.sprite.rotation=rot-90
	spear2.MoveTo(-x,-y)
	spear2.sprite.rotation=90+rot
	if spawntime%2==0 then
		DoFire(rot)
		DoFire(rot+180)
	end
	elseif spawntime<121 then
	--spear1.sprite.alpha=math.sin((spawntime-60)*math.pi/60)
	--spear2.sprite.alpha=spear1.sprite.alpha
end
for i=1,#boom do
	local b=boom[i]
	if b.isactive then
		local time=b.GetVar("time")+1
		b.SetVar("time",time)
		local speed=b.GetVar("speed")
		if time<61 then
			local New=1-math.sin(time*math.pi/120)
			b.Move(New*speed[1],New*speed[2])
			b.sprite.alpha=math.cos(time*math.pi/120)
			if b.sprite.alpha<0.1 then
				b.SetVar("color","none")
			end
			elseif time==61 then
			b.Remove()
		end
	end
end
for i=1,#spears do
	local s=spears[i]
	if s.isactive then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		if collision.CheckCollision(Player, s) then
			LongHurt(20,30)
		end
		if time>0 and time<31 then
			s.sprite.alpha=math.sin(time*math.pi/60)
			elseif time>90 and time<130 then
			local speed=s.GetVar("speed")
			s.Move(speed[1],speed[2])
			elseif time==130 then
			local dofire=s.GetVar("firedo")
			for i=0,12 do
				local fire=CreateProjectile("bullet",dofire[1],dofire[2])
				local t=dofire[3]+i
				fire.sprite.rotation=t*22.5
				local firespeed={dofire[4]*math.cos(t*math.pi/12),dofire[5]*math.sin(t*math.pi/12)}
				fire.sprite.color={1,1,1}
				fire.SetVar("speed",firespeed)
				fire.SetVar("time",0)
				fire.SetVar("color","fire")
				table.insert(boom,fire)
			end
			s.Remove()
		end
	end
end
		
spawntime=spawntime+1
if spawntime==121 then
	local num={}
	for i=1,#fires do
		local fix=0
		local n=0
		while fix<1 do
			fix=2
			n=math.random(30)
			for k=1,#num do
				if num[k]==n then
					fix=fix-1
				end
			end
		end
		table.insert(num,n)
	end
	for i=1,#fires do
		fires[i].SetVar("num",num[i])
	end
end


if spawntime>120 and spawntime<1200 then
	if (spawntime-121)%9==0 then
		for i=1,#fires do
			if fires[i].GetVar("num")==(spawntime-121)/9 then
				fires[i].SetVar("fly",true)
			end
		end
	end
	local count=0
	for i=1,#fires do
		local k=fires[i]
		if k.isactive then
			local fly=k.GetVar("fly")
			if fly==true then
				local time=k.GetVar("time")+1
				k.SetVar("time",time)
				local ugol=k.GetVar("ugol")
				if time==1 then
					k.sprite.color={1,0,0}
					elseif time==3 then
					k.sprite.color={1,1,1}
					elseif time>5 and time<95 then
					local p=(95-time)/90*172
					local x=p*math.cos(ugol*math.pi/180)
					local y=p*math.sin(ugol*math.pi/180)
					k.MoveTo(x,y)
					elseif time==95 then
					k.Remove()
				end
			end
			else
			count=count+1
		end
	end
	if count==#fires then
		spawntime=1200
	end
end
if spawntime==1230 then
	spears[1].SetVar("time",91)
	spears[2].SetVar("time",91)
	local spear3=CreateProjectile("ToriSpear",-203,0,"Top")
	spear3.SetVar("color","spear")
	spear3.SetVar("speed",{6,0})
	spear3.sprite.rotation=90
	spear3.sprite.alpha=0
	spear3.SetVar("time",0)
	spear3.SetVar("firedo",{75,0,6,3.5,3.5})
	local spear4=CreateProjectile("ToriSpear",203,0,"Top")
	spear4.sprite.rotation=-90
	spear4.SetVar("speed",{-6,0})
	spear4.sprite.alpha=0
	spear4.SetVar("time",0)
	spear4.SetVar("firedo",{-75,0,18,3.5,3.5})
	spear4.SetVar("color","spear")
	table.insert(spears,spear3)
	table.insert(spears,spear4)
end


end

function OnHit(g)
if g.GetVar("color")=="fire" then
	LongHurt(1,5)
	Effects("burn",1)
end	
end