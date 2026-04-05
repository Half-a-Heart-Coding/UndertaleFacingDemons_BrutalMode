phase=3
spawntime=0
Arena.ResizeImmediate(120,120)
Player.MoveTo(0,0,true)
Player.sprite.color={1,1,0}
Player.sprite.rotation=180
boxs={}
timer={}
spears={}
spears2={}
spears3={}
fspears={}
gspears={}
hspears={}
timery={}
pews={}
pewtime=0
forces={}
knifes={}
sdir=0
limit=60
require "Libraries/Playermove"
require "Libraries/hurt"
HeartChange({0,1,0})
shield=CreateProjectile("green/shield",0,0)
if Encounter.GetVar("diff")~= 30 and Encounter.GetVar("diff")~= 28 and Encounter.GetVar("diff")~= 27 then
	Encounter.SetVar("SavedProg",64)
end
MySpears={}
--DoGhost("Undyne_Sprite",1,600)
chargeTime=0
charged=false
function Update()
spawntime=spawntime+1
HurtUpd(4600)
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
	if Input.Confirm>0 and charged ~= true then 
		chargeTime=chargeTime+1
		if Player.sprite.rotation>=30 and Player.sprite.rotation<=60 then
			sdir=0
		end
		if Player.sprite.rotation>=120 and Player.sprite.rotation<=150 then
			sdir=0
		end
		if Player.sprite.rotation>=210 and Player.sprite.rotation<=240 then
			sdir=0
		end
		if Player.sprite.rotation>=300 and Player.sprite.rotation<=330 then
			sdir=0
		end
		if Player.sprite.rotation>330 or Player.sprite.rotation<30 then
			sdir=2
		end
		if Player.sprite.rotation>150 and Player.sprite.rotation<210 then
			sdir=4
		end
		if Player.sprite.rotation>240 and Player.sprite.rotation<300 then
			sdir=1
		end
		if Player.sprite.rotation>60 and Player.sprite.rotation<120 then
			sdir=3
		end
		if Input.Up>0 then
		if Player.sprite.rotation>=350 or Player.sprite.rotation<=10 then
			Player.sprite.rotation=0
			--fPlayer.sprite.rotation=0
			sdir=2
		elseif Player.sprite.rotation>0 and Player.sprite.rotation<=180 then
			Player.sprite.rotation=Player.sprite.rotation-10
			--fPlayer.sprite.rotation=--fPlayer.sprite.rotation+10
		else
			Player.sprite.rotation=Player.sprite.rotation+10
			--fPlayer.sprite.rotation=--fPlayer.sprite.rotation-10
		end
		elseif Input.Down>0 then
		if Player.sprite.rotation>=170 and Player.sprite.rotation<=190 then
			Player.sprite.rotation=180
			--fPlayer.sprite.rotation=180
			sdir=4
		elseif Player.sprite.rotation<180 and Player.sprite.rotation>=0 then
			Player.sprite.rotation=Player.sprite.rotation+10
			--fPlayer.sprite.rotation=--fPlayer.sprite.rotation+10
		else
			Player.sprite.rotation=Player.sprite.rotation-10
			--fPlayer.sprite.rotation=--fPlayer.sprite.rotation-10
		end
		elseif Input.Right>0 then
		if Player.sprite.rotation>=260 and Player.sprite.rotation<=280 then
			Player.sprite.rotation=270
			--fPlayer.sprite.rotation=270
			sdir=1
		elseif Player.sprite.rotation<270 and Player.sprite.rotation>=90 then
			Player.sprite.rotation=Player.sprite.rotation+10
			--fPlayer.sprite.rotation=--fPlayer.sprite.rotation+10
		else
			Player.sprite.rotation=Player.sprite.rotation-10
			--fPlayer.sprite.rotation=--fPlayer.sprite.rotation-10
		end
		elseif Input.Left>0 then
		if Player.sprite.rotation>=80 and Player.sprite.rotation<=100 then
			Player.sprite.rotation=90
			--fPlayer.sprite.rotation=90
			sdir=3
		elseif Player.sprite.rotation<90 or Player.sprite.rotation>=270 then
			Player.sprite.rotation=Player.sprite.rotation+10
			--fPlayer.sprite.rotation=--fPlayer.sprite.rotation+10
		else
			Player.sprite.rotation=Player.sprite.rotation-10
			--fPlayer.sprite.rotation=--fPlayer.sprite.rotation-10
		end
		end
		--if Player.sprite.rotation>360 then
		--	Player.sprite.rotation=0
		--end
		--if Player.sprite.rotation<0 then
		--	Player.sprite.rotation=360
		--end
	else
		--chargeTime=0
		if chargeTime<0 then
			chargeTime=chargeTime+1
		else
			chargeTime=0
			charged=false
		end
		if Input.Up==1 then
		Player.sprite.rotation=0
		--fPlayer.sprite.rotation=0
		sdir=2
		elseif Input.Down==1 then
		Player.sprite.rotation=180
		--fPlayer.sprite.rotation=180
		sdir=4
		elseif Input.Right==1 then
		Player.sprite.rotation=270
		--fPlayer.sprite.rotation=270
		sdir=1
		elseif Input.Left==1 then
		Player.sprite.rotation=90
		--fPlayer.sprite.rotation=90
		sdir=3
	end
	end
	Player.MoveTo(0,0)
	shield.sprite.rotation=Player.sprite.rotation
	else Moving()
end
if shield==nil then
	else
	shield.sprite.Set("green/shield")
end
if chargeTime>120 then
	chargeTime=-60
	charged=true
	local force = CreateProjectile("green/force",0,0)
	force.SetVar("scalex",1)
	force.SetVar("scaley",1)
	table.insert(forces,force)
end

if spawntime%90==0 and not(spawntime%600>575 or spawntime%600<240) and spawntime<1200 then
	DoTrip(math.random(4))
end

if spawntime%60==0 and not (spawntime%600>575 or spawntime%600<240) and spawntime>1200 and spawntime<2400 then
	DoTrip(math.random(4))
end

if spawntime%45==0 and not (spawntime%600>575 or spawntime%600<240) and spawntime>2400 and spawntime<3000 then
	DoTrip(math.random(4))
end

if spawntime%30==0 and not (spawntime%600>575 or spawntime%600<240) and spawntime>3000 and spawntime<3600 then
	DoTrip(math.random(4))
end

if spawntime%25==0 and not (spawntime%600>575 or spawntime%600<240) and spawntime>3600 and spawntime<4200 then
	DoTrip(math.random(4))
end

if spawntime%20==0 and not (spawntime%600>575 or spawntime%600<240) and spawntime>4200 then
	DoTrip(math.random(4))
end

if spawntime%600>=575 then
	DoTrip2(math.random(4))
end

for i=1,#forces do
	local force=forces[i]
	if force~=nil and force.isactive then
		force.sprite.Scale(force.GetVar("scalex"), force.GetVar("scaley"))
		force.SetVar("scalex",force.GetVar("scalex")+0.1)
		force.SetVar("scaley",force.GetVar("scaley")+0.1)
		force.sprite.alpha=1-((force.GetVar("scalex")/10)-0.1)
		for i=1,#spears do 
			local spear=spears[i]
			if spear.x<(force.GetVar("scalex")*40) and spear.x>(force.GetVar("scalex")*-40) and spear.y<(force.GetVar("scaley")*40) and spear.y>(force.GetVar("scaley")*-40) then
				--if shield==nil then
					--elseif dir==sdir then
					spear.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
			end
		end

		for i=1,#spears2 do 
			local spear=spears2[i]
			if spear.x<(force.GetVar("scalex")*40) and spear.x>(force.GetVar("scalex")*-40) and spear.y<(force.GetVar("scaley")*40) and spear.y>(force.GetVar("scaley")*-40) then
				--if shield==nil then
					--elseif dir==sdir then
					spear.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
			end
		end

		for i=1,#spears3 do 
			local spear=spears3[i]
			if spear.x<(force.GetVar("scalex")*40) and spear.x>(force.GetVar("scalex")*-40) and spear.y<(force.GetVar("scaley")*40) and spear.y>(force.GetVar("scaley")*-40) then
				--if shield==nil then
					--elseif dir==sdir then
					spear.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
			end
		end

		for i=1,#fspears do 
			local spear=fspears[i]
			if spear.x<(force.GetVar("scalex")*40) and spear.x>(force.GetVar("scalex")*-40) and spear.y<(force.GetVar("scaley")*40) and spear.y>(force.GetVar("scaley")*-40) then
				--if shield==nil then
					--elseif dir==sdir then
					spear.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
			end
		end

		for i=1,#gspears do 
			local spear=gspears[i]
			if spear.x<(force.GetVar("scalex")*40) and spear.x>(force.GetVar("scalex")*-40) and spear.y<(force.GetVar("scaley")*40) and spear.y>(force.GetVar("scaley")*-40) then
				--if shield==nil then
					--elseif dir==sdir then
					spear.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
			end
		end

		for i=1,#hspears do 
			local spear=hspears[i]
			if spear.x<(force.GetVar("scalex")*40) and spear.x>(force.GetVar("scalex")*-40) and spear.y<(force.GetVar("scaley")*40) and spear.y>(force.GetVar("scaley")*-40) then
				--if shield==nil then
					--elseif dir==sdir then
					spear.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
			end
		end

		if force.GetVar("scalex") > 5 then
			force.SetVar("scalex",1)
			force.SetVar("scaley",1)
			--force.isactive=false
			--force.isactive(false)
			force.sprite.alpha=1
			force.Remove()
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
			spear.Move(0,2*(dir-3))
			dx=17
			dy=28
			elseif dir<5 then
			dx=28
			dy=17
			spear.Move(2*(dir-2),0)
			else
			spear.Move(0,-2)
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
				KnifeHurt(10,true)
				spear.Remove()
			end
		end
	end
end

for i=1,#spears2 do
	local spear=spears2[i]
	local dir=spear.GetVar("dir")
	if spear.isactive then
		local dx=0
		local dy=0
		if dir%2==0 then
			spear.Move(0,1*(dir-3))
			dx=17
			dy=28
			elseif dir<5 then
			dx=28
			dy=17
			spear.Move(1*(dir-2),0)
			else
			spear.Move(0,-1)
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
				KnifeHurt(10,true)
				spear.Remove()
			end
		end
	end
end

for i=1,#spears3 do
	local spear=spears3[i]
	local dir=spear.GetVar("dir")
	if spear.isactive then
		local dx=0
		local dy=0
		if dir%2==0 then
			spear.Move(0,3*(dir-3))
			dx=17
			dy=28
			elseif dir<5 then
			dx=28
			dy=17
			spear.Move(3*(dir-2),0)
			else
			spear.Move(0,-3)
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
				KnifeHurt(15,true)
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
				fspear.Move(0,2*(dir-3))
				dx=17
				dy=28
				elseif dir<5 then
				dx=28
				dy=17
				fspear.Move(2*(dir-2),0)
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
					fspear.Move(0,-2*(dir-3))
					dx=17
					dy=28
					elseif dir<5 then
					dx=28
					dy=17
					fspear.Move(-2*(dir-2),0)
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
						KnifeHurt(10,true)
						fspear.Remove()
					end
				end
			end
		end
	end
end			

for i=1,#gspears do
	local fspear=gspears[i]
	local dir=fspear.GetVar("dir")
	if not timery[i] then
		timery[i]=-1
	end
	if fspear.isactive then
		if timery[i]==-1 then
			local dx=0
			local dy=0
			if dir==1 then
				fspear.Move(-2,0)
			elseif dir==2 then
				fspear.Move(0,2)
			elseif dir==3 then
				fspear.Move(2,0)
			else
				fspear.Move(-2,0)
			end
			if fspear.x==-92 or fspear.x==92 or fspear.y==-92 or fspear.y==92 then
				timery[i]=0
			end
			else
			timery[i]=timery[i]+1
			if timery[i]<31 then
				if dir==1 then
					fspear.MoveTo(46*math.cos(math.pi/30*timery[i]),46*math.sin(math.pi/30*timery[i]))
					elseif dir==2 then
					fspear.MoveTo(46*math.cos(math.pi/30*(timery[i]+15)),46*math.sin(math.pi/30*(timery[i]+15)))
					elseif dir==3 then
					fspear.MoveTo(46*math.cos(math.pi/30*(timery[i]+30)),46*math.sin(math.pi/30*(timery[i]+30)))
					elseif dir==4 then
					fspear.MoveTo(46*math.cos(math.pi/30*(timery[i]+45)),46*math.sin(math.pi/30*(timery[i]+45)))
				end
				else
				local dx=0
				local dy=0
				if dir%2==1 then
					fspear.Move(2*(dir-3),0)
					dx=17
					dy=28
					elseif dir<5 then
					dx=28
					dy=17
					fspear.Move(0,2*(dir-2))
				end
				if fspear.x<(38+dx/2) and fspear.x>(-38-dx/2) and fspear.y<(38+dy/2) and fspear.y>(-38-dy/2) then
					if shield==nil then
						elseif (sdir==1 and dir==2) or (sdir==2 and dir==3) or (sdir==3 and dir==4) or (sdir==4 and dir==1) then
						fspear.Remove()
						Audio.PlaySound("reflect")
						shield.sprite.Set("green/shield_hit")
					end
				end
				if fspear.isactive then
					if Player.x<(fspear.x+dx) and Player.x>(fspear.x-dx) and Player.y<(fspear.y+dy) and Player.y>(fspear.y-dy) then
						KnifeHurt(10,true)
						fspear.Remove()
					end
				end
			end
		end
	end
end			

for i=1,#hspears do
	local fspear=hspears[i]
	local dir=fspear.GetVar("dir")
	if not timery[i] then
		timery[i]=-1
	end
	if fspear.isactive then
		if timery[i]==-1 then
			local dx=0
			local dy=0
			if dir==1 then
				fspear.Move(-2,0)
			elseif dir==2 then
				fspear.Move(0,2)
			elseif dir==3 then
				fspear.Move(2,0)
			else
				fspear.Move(-2,0)
			end
			if fspear.x==-92 or fspear.x==92 or fspear.y==-92 or fspear.y==92 then
				timery[i]=0
			end
			else
			timery[i]=timery[i]+1
			if timery[i]<31 then
				if dir==1 then
					fspear.MoveTo(138*math.cos(math.pi/30*timery[i]),46*math.sin(math.pi/30*timery[i]))
					elseif dir==2 then
					fspear.MoveTo(138*math.cos(math.pi/30*(timery[i]+15)),46*math.sin(math.pi/30*(timery[i]+15)))
					elseif dir==3 then
					fspear.MoveTo(138*math.cos(math.pi/30*(timery[i]+30)),46*math.sin(math.pi/30*(timery[i]+30)))
					elseif dir==4 then
					fspear.MoveTo(138*math.cos(math.pi/30*(timery[i]+45)),46*math.sin(math.pi/30*(timery[i]+45)))
				end
				else
				local dx=0
				local dy=0
				if dir%2==1 then
					fspear.Move(-2*(dir-3),0)
					dx=17
					dy=28
					elseif dir<5 then
					dx=28
					dy=17
					fspear.Move(0,-2*(dir-2))
				end
				if fspear.x<(38+dx/2) and fspear.x>(-38-dx/2) and fspear.y<(38+dy/2) and fspear.y>(-38-dy/2) then
					if shield==nil then
						elseif (sdir==1 and dir==4) or (sdir==2 and dir==1) or (sdir==3 and dir==2) or (sdir==4 and dir==3) then
						fspear.Remove()
						Audio.PlaySound("reflect")
						shield.sprite.Set("green/shield_hit")
					end
				end
				if fspear.isactive then
					if Player.x<(fspear.x+dx) and Player.x>(fspear.x-dx) and Player.y<(fspear.y+dy) and Player.y>(fspear.y-dy) then
						KnifeHurt(10,true)
						fspear.Remove()
					end
				end
			end
		end
	end
end			

end

function DoTrip(ingo)
	local randNum = math.random(2)

	if spawntime>1800 then 
		randNum=math.random(3)
	end

	if randNum==3 and spawntime>=3000 then
		local spear=CreateProjectile("green/arrow",420*math.sin(math.pi/2*ingo),-420*math.cos(math.pi/2*ingo))
		table.insert(spears3,spear)
		spear.sprite.color={1,0,0}
		spear.sprite.rotation=ingo*90-180
		spear.SetVar("dir",ingo)
		spear.SetVar("dx",dx)
		spear.SetVar("dy",dy)
	else
		local spear=CreateProjectile("green/arrow",420*math.sin(math.pi/2*ingo),-420*math.cos(math.pi/2*ingo))
		table.insert(spears,spear)
		spear.sprite.rotation=ingo*90-180
		spear.SetVar("dir",ingo)
		spear.SetVar("dx",dx)
		spear.SetVar("dy",dy)
		--local spear2=CreateProjectile("green/arrow",300*math.sin(math.pi/2*ingo),-300*math.cos(math.pi/2*ingo))
		--table.insert(spears,spear2)
		--spear2.sprite.rotation=ingo*90-180
		--spear2.SetVar("dir",ingo)
		--spear2.SetVar("dx",dx)
		--spear2.SetVar("dy",dy)
		--if spawntime>1800 and ((math.random(2)==1 and spawntime<=3000) or (math.random(3)~=1 and spawntime>3000)) and randNum~=1 then
			--if math.random(2)==1 then
			--	local gspear=CreateProjectile("green/arrow",320*math.sin(math.pi/2*ingo),-320*math.cos(math.pi/2*ingo))
			--	table.insert(gspears,gspear)
			--	gspear.sprite.rotation=ingo*90-90
			--	gspear.sprite.color={1,0,1}
			--	gspear.SetVar("dir",ingo)
			--else
			--	local hspear=CreateProjectile("green/arrow",320*math.sin(math.pi/2*ingo),-320*math.cos(math.pi/2*ingo))
			---	table.insert(hspears,hspear)
			--	hspear.sprite.rotation=ingo*90+90
			--	hspear.sprite.color={0,1,0}
			--	hspear.SetVar("dir",ingo)
			--end
		
		if spawntime>600 and randNum~=1 then
			local fspear=CreateProjectile("green/arrow",320*math.sin(math.pi/2*ingo),-320*math.cos(math.pi/2*ingo))
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
		end
		if spawntime<=600 or randNum==1 then
			local spear1=CreateProjectile("green/arrow",-360*math.sin(math.pi/2*ingo),360*math.cos(math.pi/2*ingo))
			table.insert(spears,spear1)
			spear1.sprite.rotation=ingo*90
			if ingo==1 then
				--box.SetVar("speedx",-4)
				--box.SetVar("speedy",0)
				spear1.SetVar("dir",3)
				elseif ingo==3 then
				--box.SetVar("speedx",4)
				--box.SetVar("speedy",0)
				spear1.SetVar("dir",1)
				elseif ingo==2 then
				--box.SetVar("speedx",0)
				--box.SetVar("speedy",-4)
				spear1.SetVar("dir",4)
				elseif ingo==4 then
				spear1.SetVar("dir",2)
				--box.SetVar("speedx",0)
				--box.SetVar("speedy",4)
			end
			spear1.SetVar("dx",dx)
			spear1.SetVar("dy",dy)
		end
	end
end

function DoTrip2(ingo)
	local spear=CreateProjectile("green/arrow",420*math.sin(math.pi/2*ingo),-420*math.cos(math.pi/2*ingo))
	table.insert(spears2,spear)
	spear.sprite.rotation=ingo*90-180
	spear.SetVar("dir",ingo)
	spear.SetVar("dx",dx)
	spear.SetVar("dy",dy)
end

function OnHit()
end
