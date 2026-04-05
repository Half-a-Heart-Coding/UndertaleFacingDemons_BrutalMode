spawntime=25
require "Libraries/hurt"
slashs={}
deadtime=0
deads=false
beams={}
knifes={}
timer5=0
timer6=0
phase=1
b_sp={}
dir=1
speed_x=1
speed_y=1
notlast=true
reload=35
timer2={}
timer1={}
timer3={}
current=0
lastbeam={}
slashspawn=0
rot=0
--name5="Fatal"
--if Encounter.GetVar("diff")==30 then
	name5="Mutant"
--end
collision = require "Libraries/rotational_collision"
--Arena.ResizeImmediate(16,160)
--Player.MoveTo(0,92,false)
function setspeed(attack,x,y,color,timers)
	attack.SetVar("x",x)
	attack.SetVar("y",y)
	attack.SetVar("color",color)
	attack.SetVar("end",timers)
end
function DoFire(ugol)
	local x=172*math.cos(ugol*math.pi/180)
	local y=172*math.sin(ugol*math.pi/180)
	local fire=CreateProjectile("KnifeRight"..name5,x,y)
	fire.SetVar("ugol",ugol)
	fire.SetVar("x",x/-60)
	fire.SetVar("y",y/-60)
	fire.SetVar("end",180)
	fire.sprite.rotation=ugol
	--local x=p*math.cos(ugol*math.pi/180)
	--local y=p*math.sin(ugol*math.pi/180)
	fire.SetVar("time",0)
	fire.SetVar("color","mutant")
	table.insert(knifes,fire)
end
function Update()
HurtUpd(9999999999)
if current==0 then
	if not GetGlobal("nextwave") then
		elseif GetGlobal("nextwave")==true then
		current=1
		SetGlobal("nextwave",false)
	end
end
if phase==5 then
	if Input.Left>0 and Input.Right==0 then
		Player.MoveTo(Player.x-0.5,Player.y,false)
	end
	if Input.Up>0 and Input.Down==0 then
		Player.MoveTo(Player.x,Player.y+0.5,false)
	end
	if Input.Left==0 and Input.Right>0 then
		Player.MoveTo(Player.x+0.5,Player.y,false)
	end
	if Input.Up==0 and Input.Down>0 then
		Player.MoveTo(Player.x,Player.y-0.5,false)
	end
end
if phase==6 then
	if Input.Left>0 and Input.Right==0 then
		Player.MoveTo(Player.x-2,Player.y,false)
	end
	if Input.Up>0 and Input.Down==0 then
		Player.MoveTo(Player.x,Player.y+2,false)
	end
	if Input.Left==0 and Input.Right>0 then
		Player.MoveTo(Player.x+2,Player.y,false)
	end
	if Input.Up==0 and Input.Down>0 then
		Player.MoveTo(Player.x,Player.y-2,false)
	end
end
if hitted==true and phase<5 then
	Player.SetControlOverride(true)
	Player.MoveTo(Player.x,Player.y+5,false)
	Player.sprite.rotation=180
	if Player.y==102 then
		hitted=false
		phase=5
		slashspawn=-10
		Audio.PlaySound("slam")
	end
end
if not death then
	spawntime=spawntime+current
	slashspawn=slashspawn+current
	else spawntime=1
	slashspawn=1
end
if spawntime==180 and phase==3 then
	spawntime=0
	slashspawn=0
	phase=4
end
if spawntime==1 and phase==4 then
	local bone=CreateProjectile("Boneh",0,-500)
	table.insert(knifes,bone)
	bone.sprite.alpha=0
	setspeed(bone,0,15,"bone",180)
end
if spawntime==36 and phase==1 then
	local knife = CreateProjectile("KnifeDown"..name5,0,132)--67
	setspeed(knife,0,-2,"mutant",300)
	table.insert(knifes,knife)
end
if spawntime==110 and phase==1 then
	Arena.Resize(70,160)
end
if spawntime==135 and phase==1  then
	local slash1=CreateProjectile("att0",-25,0)
	local slash2=CreateProjectile("att0",25,0)
	slash1.SetVar("color","none")
	slash2.SetVar("color","none")
	table.insert(slashs,slash1)
	table.insert(slashs,slash2)
	Audio.PlaySound("slice2")
end
if timer6%90==0 and phase==6 and timer6<300 and timer6>=180 then
	local slash1=CreateProjectile("att0",Player.x,Player.y)
	--local slash2=CreateProjectile("att0",25,0)
	slash1.SetVar("color","none")
	--slash2.SetVar("color","none")
	table.insert(slashs,slash1)
	--table.insert(slashs,slash2)
	Audio.PlaySound("slice2")
end
if timer6%90==45 and phase==6 and timer6<300 and timer6>=180 then
	--local slash1=CreateProjectile("att0",Player.x,0)
	local slash2=CreateProjectile("att0",Player.x,Player.y)
	--slash1.SetVar("color","none")
	slash2.sprite.rotation=90
	slash2.SetVar("color","none")
	--table.insert(slashs,slash1)
	table.insert(slashs,slash2)
	Audio.PlaySound("slice2")
end
if spawntime%120==60 and phase==6 and spawntime>300 and spawntime<600 then
	local slash1=CreateProjectile("att0",Player.x,Player.y)
	local slash2=CreateProjectile("att0",Player.x,Player.y)
	slash1.SetVar("color","none")
	slash1.sprite.rotation=0
	slash2.sprite.rotation=90
	slash2.SetVar("color","none")
	table.insert(slashs,slash1)
	table.insert(slashs,slash2)
	Audio.PlaySound("slice2")
end
if spawntime%120==0 and phase==6 and spawntime>300 and spawntime<600 then
	local slash1=CreateProjectile("att0",Player.x,Player.y)
	local slash2=CreateProjectile("att0",Player.x,Player.y)
	slash1.SetVar("color","none")
	slash1.sprite.rotation=45
	slash2.sprite.rotation=135
	slash2.SetVar("color","none")
	table.insert(slashs,slash1)
	table.insert(slashs,slash2)
	Audio.PlaySound("slice2")
end
if timer6%10==0 and phase==6 and timer6<120 then
	--napr=math.random(2)*2-3
	--if spawntime<124 then
		--random=math.random(Arena.height-24)+10-Arena.height/2
		--else random=math.random(79)+10-Arena.height/2
	--end
	local knife=CreateProjectile("KnifeLeft"..name5,300,-Arena.height+(timer6))
	setspeed(knife,-7,0,"mutant",300)
	knife.sprite.rotation=0
	table.insert(knifes,knife)
	local knife2=CreateProjectile("KnifeRight"..name5,-300,-Arena.height+(timer6))
	setspeed(knife2,7,0,"mutant",-300)
	knife2.sprite.rotation=0
	table.insert(knifes,knife2)
end
if phase==6 and spawntime>600 then
	DoFire(rot)
	DoFire(rot+180)
	--DoFire(rot+90)
	--DoFire(rot+270)
	rot=rot+2
end
if phase==6 and spawntime>1200 then
	EndWave()
	--Encounter.Call("Gotcha")
end
if spawntime==165 and phase==1 then
	local slash1=CreateProjectile("att0",0,0)
	slash1.SetVar("color","none")
	table.insert(slashs,slash1)
	Audio.PlaySound("slice2")
end
if spawntime%3==0 and phase==3 then
	napr=math.random(2)*2-3
	if spawntime<124 then
		random=math.random(Arena.height-24)+10-Arena.height/2
		else random=math.random(79)+10-Arena.height/2
	end
	local knife=CreateProjectile("KnifeLeft"..name5,300*napr,random)
	setspeed(knife,napr*-6,0,"mutant",300)
	knife.sprite.rotation=90-napr*90
	table.insert(knifes,knife)
end
if phase==3 and spawntime>20 then
	Arena.Resize(70,75+(spawntime-20)/4)
end
if phase==2 then
	Player.MoveTo(Player.x,Player.y-10,false)
	if Player.y==-72 then
		phase=3
		Audio.PlaySound("slam")
		Player.SetControlOverride(false)
		spawntime=1
		slashtime=1
		Arena.ResizeImmediate(70,75)
	end
end
if spawntime==215 and phase==1 then
	phase=2
	spawntime=1
	slashspawn=1
	Arena.Resize(70,160)
	Player.sprite.rotation=0
	Player.SetControlOverride(true)
end
for i=1,#knifes do
	local knife=knifes[i]
	if knife.isactive then
		knife.Move(knife.GetVar("x"),knife.GetVar("y"))
		if not timer3[i] then
			timer3[i]=0
			else timer3[i]=timer3[i]+1
		end
		if timer3[i]==knife.GetVar("end") then
			knife.Remove()
		end
		if collision.CheckCollision(Player, knife) and phase==6 then
			if GetGlobal("KnifeProtection") == true then
				if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
					LongHurt(25,60)
				elseif Player.hp > 33 then
					LongHurt(33,60)
				else
					deads = true
					Encounter.Call("SetMusic","none")
				end
			else
				deads = true
				Encounter.Call("SetMusic","none")
			end
		end
	end
end
if slashspawn>reload and notlast==true and phase==5 then
	local slash=CreateProjectile("att0",0,Arena.height/2-10)
	slash.SetVar("color","none")
	slash.sprite.rotation=90*dir
	dir=-dir
	if Arena.height==20 then
		notlast=false
	end
	slashspawn=slashspawn-reload
	if Arena.height==40 then
		reload=60
		elseif Arena.height<160 then
		--reload=reload-2
		else reload=40
	end
	table.insert(slashs,slash)
	Audio.PlaySound("slice2")
end
if deads then
  deadtime=deadtime+1
  for i=1,#slashs do
	slashs[i].Remove()
  end
  Player.SetControlOverride(true)
  if  deadtime<60 then
     deadscreen = CreateProjectile("999999", 0,145-Arena.height/2)
     deadtime=60
     else
     deadscreen.MoveTo(5*math.sin(deadtime*math.pi/5),145-Arena.height/2)
  end
  if deadtime==120 then
	Encounter.SetVar("SavedProg",68)
	FakeDeath()
  end
end
for i=1,#slashs do
	local slash=slashs[i]
	if not timer1[i] then
		timer1[i]=0
		elseif slash.isactive then
		if Arena.height==20 then
			timer1[i]=timer1[i]+0.5
			else
			timer1[i]=timer1[i]+1
		end
	end
	if timer1[i]%4==1 then
		slash.sprite.Set("att"..(timer1[i]-1)/4)
		if (timer1[i]-1)/4==6 then
			if phase==5 then
				b_sp[i]="laserend"
				else
				b_sp[i]="laser0/laserv0"
			end
			local beam=CreateProjectile(b_sp[i],slash.x,slash.y)
			if phase==6 then
				beam.sprite.rotation=slash.sprite.rotation
			end
			if Arena.height==20 then
				beam.SetVar("color","almost")
				table.insert(lastbeam,beam)
				else
				beam.SetVar("color","death")
				Audio.PlaySound("bolt")
				if collision.CheckCollision(Player, beam) and phase==6 then
					if GetGlobal("KnifeProtection") == true then
						if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
							LongHurt(25,60)
						elseif Player.hp > 33 then
							LongHurt(33,60)
						else
							deads = true
							Encounter.Call("SetMusic","none")
						end
					else
						deads = true
						Encounter.Call("SetMusic","none")
					end
				end
				table.insert(beams,beam)
			end
			slash.Remove()
			timer1[i]=0
		end
	end
end
for i=1,#lastbeam do
	local beam=lastbeam[i]
	if not timer5 then
		timer5=1
		else timer5=timer5+1
	end
	beam.sprite.alpha=1-0.01*timer5
end
for i=1,#beams do
	local beam=beams[i]
	if not timer2[i] then
		timer2[i]=1
		else timer2[i]=timer2[i]+1
	end
	beam.sprite.alpha=1-0.05*timer2[i]
	if timer2[i]==8 then
		beam.SetVar("color","none")
		if phase==5 then
			Arena.ResizeImmediate(200,Arena.height-20)
		end
	end
end
if timing==true or phase==6 then
	timer6=timer6+1
end
if timer6==60 then
	--Encounter.Call("Gotcha")
	EndWave()
	phase=6
	spawntime=0
	--timer6=timer6+1
	Player.sprite.rotation=0
	Arena.Resize(100,100)
end
end
function OnHit(attack)
	if attack.GetVar("color")=="death" and (phase~=6 or timer6<180 or timer6>1350) then
		if GetGlobal("KnifeProtection") == true then
			if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
				LongHurt(25,60)
			elseif Player.hp > 33 then
				LongHurt(33,60)
			else
				deads = true
				Encounter.Call("SetMusic","none")
			end
		else
			deads = true
			Encounter.Call("SetMusic","none")
		end
	elseif attack.GetVar("color")=="almost" then
		attack.SetVar("color","none")
		--KnifeHurt(Player.hp-1,true)
		Audio.PlaySound("reflect")
		timing=true
	elseif attack.GetVar("color")=="white" then
		KnifeHurt(5)
	elseif attack.GetVar("color")=="bone" then
		attack.SetVar("y",-10)
		hitted=true
		Arena.ResizeImmediate(200,220)
		Audio.PlaySound("slam")
	elseif attack.GetVar("color")=="mutant" then
		deads = true
		Encounter.Call("SetMusic","none")
	end
end