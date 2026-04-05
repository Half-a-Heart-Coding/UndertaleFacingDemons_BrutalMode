phase=1
spawntime=0
Arena.ResizeImmediate(120,120)
Player.MoveTo(0,0,true)
Player.sprite.color={1,1,0}
Player.sprite.rotation=180
boxs={}
timer={}
spears={}
fspears={}
timery={}
pews={}
pewtime=0
knifes={}
sdir=0
limit=60
require "Libraries/Playermove"
require "Libraries/hurt"
HeartChange({1,1,0})
MySpears={}
DoGhost("Undyne_Sprite",1,600)


function Update()
spawntime=spawntime+1
HurtUpd(12000)
for i=1,#MySpears do
	local s=MySpears[i]
	if s.isactive then
		local sp=s.GetVar("speed")
		s.Move(sp[1],sp[2])
		if s.x>500 or s.x<-500 then
			s.Remove()
		end
		if s.isactive then
			if Player.x<(s.x+16) and Player.x>(s.x-16) and Player.y<(s.y+10) and Player.y>(s.y-10) then
				KnifeHurt(5,true)
				s.Remove()
			end
		end
	end
end
if phase==3 then
	Moving()
	if Input.Up==1 then
		Player.sprite.rotation=0
		fPlayer.sprite.rotation=0
		sdir=2
		elseif Input.Down==1 then
		Player.sprite.rotation=180
		fPlayer.sprite.rotation=180
		sdir=4
		elseif Input.Right==1 then
		Player.sprite.rotation=270
		fPlayer.sprite.rotation=270
		sdir=1
		elseif Input.Left==1 then
		Player.sprite.rotation=90
		fPlayer.sprite.rotation=90
		sdir=3
	end
	Player.MoveTo(0,0)
	shield.sprite.rotation=Player.sprite.rotation
	else Moving()
end
if phase<4 then
	if pewtime>0 then
		pewtime=pewtime-1
	end
	if Input.Confirm==1 and pewtime==0 then
		pewtime=15
		Audio.PlaySound("pew")
		local pew=CreateProjectile("shot",Player.x+4*math.sin(math.pi*Player.sprite.rotation/180),Player.y-4*math.cos(math.pi*Player.sprite.rotation/180))
		pew.sprite.rotation=Player.sprite.rotation
		local n=Player.sprite.rotation
		if n%360==0 then
			pew.SetVar("px",0)
			pew.SetVar("py",-8)
			elseif n%360==90 then
			pew.SetVar("px",8)
			pew.SetVar("py",0)
			elseif n%360==180 then
			pew.SetVar("px",0)
			pew.SetVar("py",8)
			elseif n%360==270 then
			pew.SetVar("px",-8)
			pew.SetVar("py",0)
		end
		table.insert(pews,pew)
	end
end
if phase==1 then
	Arena.Move(0,0.5,false,false)	
	if spawntime%60==10 then
		local s=CreateProjectile("green/arrow",Player.x+300,Player.y)
		s.SetVar("speed",{-5,0})
		s.sprite.rotation=-90
		table.insert(MySpears,s)
		local s=CreateProjectile("green/arrow",Player.x-300,Player.y)
		s.SetVar("speed",{5,0})
		s.sprite.rotation=90
		table.insert(MySpears,s)
		if spawntime<200 then
			for i=-2,2 do
					local box=CreateProjectile("box/box",i*25,500)
					box.SetVar("speedx",0)
					box.SetVar("speedy",-4)
					table.insert(boxs,box)
			end
		end
	end
	if spawntime%30==10 then
	end
	if Arena.y==240 then
		phase=2
		spawntime=0
	end
	elseif phase==2 and spawntime==30 then
	Arena.MoveToAndResize(320,240,50,50,false,true)
	Player.MoveTo(0,0,true)
	phase=3
	spawntime=59
	fPlayer=CreateProjectile("green",0,0)
	fPlayer.sprite.rotation=Player.sprite.rotation
	HeartChange({1,0,1},"green")
	shield=CreateProjectile("green/shield",0,0)
	shield.sprite.rotation=Player.sprite.rotation
	sdir=4
	elseif phase==3 then
	if spawntime==limit then
		limit=limit+4
		spawntime=0
		if limit==84 then
			spawntime=-40
		end
		if limit==88 then
			phase=4
			spawntime=0
			shield.Remove()
			shield=nil
			fPlayer.Remove()
			Player.sprite.rotation=0
			HeartChange({1,0,1})
			else
			DoTrip(math.random(4))
		end
	end
	elseif phase==4 then
	if spawntime==1 then
		knife1=CreateProjectile("KnifeDownDeadly",0,352)
		knife2=CreateProjectile("KnifeUpDeadly",0,-352)
		knife3=CreateProjectile("KnifeRightDeadly",-352,0)
		knife4=CreateProjectile("KnifeLeftDeadly",352,0)
		table.insert(knifes,knife1)
		table.insert(knifes,knife2)
		table.insert(knifes,knife3)
		table.insert(knifes,knife4)
	end
	if spawntime==120 then
		EndWave()
	end
end
if knife1==nil then
	else
	if spawntime<51 then
		knife1.MoveTo(0,352*(1-math.sin(math.pi*spawntime/100)))
		knife2.MoveTo(0,-352*(1-math.sin(math.pi*spawntime/100)))
		knife3.MoveTo(-352*(1-math.sin(math.pi*spawntime/100)),0)
		knife4.MoveTo(352*(1-math.sin(math.pi*spawntime/100)),0)
	end
	for i=1,4 do
		local knife=knifes[i]
		local kx=knife.sprite.width/2+4
		local ky=knife.sprite.height/2+4
		if Player.x>knife.x-kx and Player.x<knife.x+kx and Player.y>knife.y-ky and Player.y<knife.y+ky then
			KnifeHurt(2)
		end
	end
end	
for i=1,#pews do
	if pews[i].isactive then
		pews[i].Move(pews[i].GetVar("px"),pews[i].GetVar("py"))
	end
end
if shield==nil then
	else
	shield.sprite.Set("green/shield")
end
for i=1,#boxs do
	local box=boxs[i]
	if not timer[i] then
		timer[i]=-1
	end
	if box.isactive then
		if timer[i]==-1 then
			box.Move(box.GetVar("speedx"),box.GetVar("speedy"))
			for j=1,#pews do
				local pew=pews[j]
				if box.x>pew.x-10 and box.x<pew.x+10 and box.y>pew.y-10 and box.y<pew.y+10 and pew.isactive then
					pew.Remove()
					timer[i]=0
					box.sprite.Set("box/1")
					Audio.PlaySound("hit")
				end
			end
			if Player.x<(box.x+13) and Player.x>(box.x-13) and Player.y<(box.y+13) and Player.y>(box.y-13) and timer[i]==-1 then
				KnifeHurt(5,true)
				box.Remove()
			end
			elseif timer[i]<9 then
			timer[i]=timer[i]+1
			box.sprite.alpha=(8-timer[i])/8
			if timer[i]%2==0 then
				box.sprite.Set("box/"..((timer[i]/2)+1))
			end
			if timer[i]==9 then
				box.Remove()
			end
		end
	end
end
for i=1,#spears do
	local spear=spears[i]
	local dir=spear.GetVar("dir")
	if spear.isactive then
		local dx=0
		local dy=0
		if dir%2==0 then
			spear.Move(0,4*(dir-3))
			dx=17
			dy=28
			elseif dir<5 then
			dx=28
			dy=17
			spear.Move(4*(dir-2),0)
			else
			spear.Move(0,-4)
			dx=17
			dy=28
		end
		if spear.x<(38+dx/2) and spear.x>(-38-dx/2) and spear.y<(38+dy/2) and spear.y>(-38-dy/2) then
			if shield==nil then
				elseif dir==sdir then
				spear.Remove()
				Audio.PlaySound("reflect")
				shield.sprite.Set("green/shield_hit")
			end
		end
		if spear.isactive then
			if Player.x<(spear.x+dx) and Player.x>(spear.x-dx) and Player.y<(spear.y+dy) and Player.y>(spear.y-dy) then
				KnifeHurt(5,true)
				spear.Remove()
			end
		end
	end
end

for i=1,#fspears do
	local fspear=fspears[i]
	local dir=fspear.GetVar("dir")
	if not timery[i] then
		timery[i]=-1
	end
	if fspear.isactive then
		if timery[i]==-1 then
			local dx=0
			local dy=0
			if dir%2==0 then
				fspear.Move(0,4*(dir-3))
				dx=17
				dy=28
				elseif dir<5 then
				dx=28
				dy=17
				fspear.Move(4*(dir-2),0)
			end
			if fspear.x==-92 or fspear.x==92 or fspear.y==-92 or fspear.y==92 then
				timery[i]=0
			end
			else
			timery[i]=timery[i]+1
			if timery[i]<31 then
				if dir==1 then
					fspear.MoveTo(92*math.cos(math.pi/30*timery[i]),92*math.sin(math.pi/30*timery[i]))
					elseif dir==2 then
					fspear.MoveTo(92*math.cos(math.pi/30*(timery[i]+15)),92*math.sin(math.pi/30*(timery[i]+15)))
					elseif dir==3 then
					fspear.MoveTo(92*math.cos(math.pi/30*(timery[i]+30)),92*math.sin(math.pi/30*(timery[i]+30)))
					elseif dir==4 then
					fspear.MoveTo(92*math.cos(math.pi/30*(timery[i]+45)),92*math.sin(math.pi/30*(timery[i]+45)))
				end
				else
				local dx=0
				local dy=0
				if dir%2==0 then
					fspear.Move(0,-4*(dir-3))
					dx=17
					dy=28
					elseif dir<5 then
					dx=28
					dy=17
					fspear.Move(-4*(dir-2),0)
				end
				if fspear.x<(38+dx/2) and fspear.x>(-38-dx/2) and fspear.y<(38+dy/2) and fspear.y>(-38-dy/2) then
					if shield==nil then
						elseif (sdir==1 and dir==3) or (sdir==2 and dir==4) or (sdir==3 and dir==1) or (sdir==4 and dir==2) then
						fspear.Remove()
						Audio.PlaySound("reflect")
						shield.sprite.Set("green/shield_hit")
					end
				end
				if fspear.isactive then
					if Player.x<(fspear.x+dx) and Player.x>(fspear.x-dx) and Player.y<(fspear.y+dy) and Player.y>(fspear.y-dy) then
						KnifeHurt(5,true)
						fspear.Remove()
					end
				end
			end
		end
	end
end			
end

function DoTrip(ingo)
	local fspear=CreateProjectile("green/arrow",360*math.sin(math.pi/2*ingo),-360*math.cos(math.pi/2*ingo))
	table.insert(fspears,fspear)
	fspear.sprite.rotation=ingo*90
	fspear.sprite.color={1,1,0}
	fspear.SetVar("dir",ingo)
	local dx=0
	local dy=0
	if ingo%2==0 then
		dx=17
		dy=28
		elseif ingo<5 then
		dx=28
		dy=17
	end
	fspear.SetVar("dx",dx)
	fspear.SetVar("dy",dy)
	local spear=CreateProjectile("green/arrow",420*math.sin(math.pi/2*ingo),-420*math.cos(math.pi/2*ingo))
	table.insert(spears,spear)
	spear.sprite.rotation=ingo*90-180
	spear.SetVar("dir",ingo)
	spear.SetVar("dx",dx)
	spear.SetVar("dy",dy)
	local box=CreateProjectile("box/box",480*math.sin(math.pi/2*ingo),-480*math.cos(math.pi/2*ingo))
	table.insert(boxs,box)
	box.sprite.rotation=ingo*90
	local spear1=CreateProjectile("green/arrow",-360*math.sin(math.pi/2*ingo),360*math.cos(math.pi/2*ingo))
	table.insert(spears,spear1)
	spear1.sprite.rotation=ingo*90
	if ingo==1 then
		box.SetVar("speedx",-4)
		box.SetVar("speedy",0)
		spear1.SetVar("dir",3)
		elseif ingo==3 then
		box.SetVar("speedx",4)
		box.SetVar("speedy",0)
		spear1.SetVar("dir",1)
		elseif ingo==2 then
		box.SetVar("speedx",0)
		box.SetVar("speedy",-4)
		spear1.SetVar("dir",4)
		elseif ingo==4 then
		spear1.SetVar("dir",2)
		box.SetVar("speedx",0)
		box.SetVar("speedy",4)
	end
	spear1.SetVar("dx",dx)
	spear1.SetVar("dy",dy)
end

function OnHit()
end
