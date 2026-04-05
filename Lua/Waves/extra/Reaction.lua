Arena.ResizeImmediate(90,90)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}
amm=1
sides={}
knifesold={}
rands={}

function SendKnife(side,rand)
	local x=13*rand
	local name=side+rand-1
	if name<1 then
		name=name+4
		elseif name>4 then
		name=name-4
	end
	local y=55
	local px=x*math.cos(side*math.pi/2)+y*math.sin(side*math.pi/2)
	local py=x*math.sin(side*math.pi/2)+y*math.cos(side*math.pi/2)
	if name==3 then
		name="KnifeUp"
		elseif name==4 then
		name="KnifeLeft"
		elseif name==1 then
		name="KnifeDown"
		elseif name==2 then
		name="KnifeRight"
	end
	local knife=CreateProjectile(name,px,py)
	knife.SetVar("time",-15)
	knife.SetVar("fly",false)
	knife.SetVar("side",side)
	knife.SetVar("rand",rand)
	knife.SetVar("speed",speed)
	knife.sprite.alpha=0
	table.insert(knifes,knife)
end

function Update()
HurtUpd(740)
Moving()
if spawntime>-1 then
	spawntime=spawntime+1
	else
	spawntime=spawntime-1
end
if spawntime%30==0 then
	if spawntime>0 then
		if spawntime/30==amm then
			spawntime=-1
		end
		if spawntime==30 then
			knifesold=knifes
			knifes={}
		end
		local side=1
		local fix=false
		while fix==false do
			fix=true
			side=math.random(4)
			for i=1,#sides do
				if side==sides[i] then	
					fix=false
				end
			end
		end
		local rand=math.random(2)*2-3
		local r=side+rand
		if r<1 then
			r=r+4
			elseif r>4 then
			r=r-4
		end
		for i=1,#rands do
			if rands[i]==r then
				rand=-rand
				r=side+rand
				if r<1 then
					r=r+4
					elseif r>4 then
					r=r-4
				end
			end
		end
		table.insert(rands,r)
		SendKnife(side,rand)
		table.insert(sides,side)
		else
		local i=-spawntime/30
		if i>amm then
			spawntime=1
			amm=amm+1
			sides={}
			rands={}
			else
			knifes[i].SetVar("fly",true)
		end
	end
end
		
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local fly=k.GetVar("fly")
		if fly==true then
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<31 then
				local x=k.GetVar("rand")*13
				local y=55*math.cos(time*math.pi/30)
				local side=k.GetVar("side")
				local px=x*math.cos(side*math.pi/2)+y*math.sin(side*math.pi/2)
				local py=x*math.sin(side*math.pi/2)+y*math.cos(side*math.pi/2)
				k.MoveTo(px,py)
				elseif time<61 then
				k.sprite.alpha=math.cos((time-30)*math.pi/60)
				else
				k.Remove()
			end
		end
		local time=k.GetVar("time")
		if time<0 then
			time=time+1
			k.SetVar("time",time)
			k.sprite.alpha=math.cos(time*math.pi/30)
		end
	end
end

for i=1,#knifesold do
	local k=knifesold[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time<31 then
			local x=k.GetVar("rand")*13
			local y=55*math.cos(time*math.pi/30)
			local side=k.GetVar("side")
			local px=x*math.cos(side*math.pi/2)+y*math.sin(side*math.pi/2)
			local py=x*math.sin(side*math.pi/2)+y*math.cos(side*math.pi/2)
			k.MoveTo(px,py)
			elseif time<61 then
			k.sprite.alpha=math.cos((time-30)*math.pi/60)
			else
			k.Remove()
		end
	end
end


end

function OnHit()
KnifeHurt(1)
end