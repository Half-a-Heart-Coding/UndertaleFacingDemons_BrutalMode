num_knives = 0
spawntimer = 0
knives = {}
shadows = {}
Arena.Resize(300, 300)
Arena.MoveTo(320,140,true,true)
collision = require "Libraries/rotational_collision"
lock=CreateProjectile("empty",0,0)
lock.SetVar("empty",true)
target=CreateProjectile("empty",0,0)
target.SetVar("empty",true)
 
require "Libraries/Playermove"
require "Libraries/hurt"
Player.SetControlOverride(true)
Encounter.Call("SetMusic", "last")
Player.sprite.color={1,0,0}
DoGhost("smile",0,600)
TrueKnifes={}
Player.hp=135
purple=false
function SpawnKnife()
	pointed=false
	local rotate=math.random(360)
	local dist=math.random(90)
	dist=140*(1-math.cos(dist*math.pi/180))
	local randx=dist*math.cos(rotate*math.pi/180)
	local randy=dist*math.sin(rotate*math.pi/180)
	if randx>Arena.width/2 or randx<-Arena.width/2 or randy>Arena.height/2 or randy<-Arena.width/2 then
		local bool=true
		while bool==true do
			bool=false
			rotate=math.random(360)
			dist=math.random(90)
			dist=130*(1-math.cos(dist*math.pi/180))
			randx=dist*math.cos(rotate*math.pi/180)
			randy=dist*math.sin(rotate*math.pi/180)
			randx=math.random(Arena.width/2+20)*(math.random(2)*2-3)
			randy=math.random(Arena.height/2+20)*(math.random(2)*2-3)
			if randx>Arena.width/2 or randx<-Arena.width/2 or randy>Arena.height/2 or randy<-Arena.width/2 then
				bool=true
			end
		end
	end
    target.MoveTo(randx,randy)
    spawnx = math.random(-40, 680)
    spawny = math.random(-40, 520)
		while pointed==false do
			if (spawnx>-35 and spawnx<675 and spawny>-35 and spawny<515) then
  				spawnx = math.random(-40, 680)
  				spawny = math.random(-40, 520)
				else pointed=true
			end
		end
	local pointy=target.absy
	local pointx=target.absx
	local dist=math.sqrt((spawnx-pointx)*(spawnx-pointx)+(spawny-pointy)*(spawny-pointy))
	if pointy<spawny then
		angle = math.asin((pointx-spawnx)/dist)*180/math.pi
		else angle = 180-math.asin((pointx-spawnx)/dist)*180/math.pi
	end
        knife = CreateProjectileAbs('KnifeDownMutant', spawnx, spawny)
        knife.SetVar("posx", spawnx)
        knife.SetVar("posy", spawny)
        knife.SetVar("angle", angle)
		knife.SetVar("color","mutant")
		knife.SetVar("time",0)
        knife.sprite.rotation = angle
        num_knives = num_knives+1
        table.insert(knives, knife)
		--SendShadow("DownLethal",knife.GetVar("posx"),knife.GetVar("posy"),{-6,0},true,knife.GetVar("angle"), 2)
end

function SendShadow(name, positionx, positiony, speed, istrue, angle, time)
	knife=CreateProjectileAbs("KnifeDownFatal",positionx,positiony)
	knife.SetVar("speed",speed)
	knife.SetVar("name",name)
	knife.SetVar("time",0)
	knife.SetVar("posx", positionx)
    knife.SetVar("posy", positiony)
	knife.SetVar("angle",angle)
	knife.sprite.alpha=0.5
	knife.sprite.rotation = angle
	knife.SetVar("istrue",istrue)
	knife.SetVar("color","red")
	num_knives = num_knives+1
	table.insert(knives,knife)
	MoveKnifeShadow(knife,time)
end

function SpawnKnife2()
	pointed=false
	local rotate=math.random(360)
	local dist=math.random(90)
	dist=140*(1-math.cos(dist*math.pi/180))
	local randx=dist*math.cos(rotate*math.pi/180)
	local randy=dist*math.sin(rotate*math.pi/180)
	if randx>Arena.width/2 or randx<-Arena.width/2 or randy>Arena.height/2 or randy<-Arena.width/2 then
		local bool=true
		while bool==true do
			bool=false
			rotate=math.random(360)
			dist=math.random(90)
			dist=130*(1-math.cos(dist*math.pi/180))
			randx=dist*math.cos(rotate*math.pi/180)
			randy=dist*math.sin(rotate*math.pi/180)
			randx=math.random(Arena.width/2+20)*(math.random(2)*2-3)
			randy=math.random(Arena.height/2+20)*(math.random(2)*2-3)
			if randx>Arena.width/2 or randx<-Arena.width/2 or randy>Arena.height/2 or randy<-Arena.width/2 then
				bool=true
			end
		end
	end
    target.MoveTo(randx,randy)
    spawnx = math.random(-40, 680)
    spawny = math.random(-40, 520)
		while pointed==false do
			if (spawnx>-35 and spawnx<675 and spawny>-35 and spawny<515) then
  				spawnx = math.random(-40, 680)
  				spawny = math.random(-40, 520)
				else pointed=true
			end
		end
	local pointy=target.absy
	local pointx=target.absx
	local dist=math.sqrt((spawnx-pointx)*(spawnx-pointx)+(spawny-pointy)*(spawny-pointy))
	if pointy<spawny then
		angle = math.asin((pointx-spawnx)/dist)*180/math.pi
		else angle = 180-math.asin((pointx-spawnx)/dist)*180/math.pi
	end
	local color=math.random(3)
	color=1
		if color==1 then
			knife = CreateProjectileAbs('KnifeDownPurpleDeadly', spawnx, spawny)
			knife.SetVar("posx", spawnx)
			knife.SetVar("posy", spawny)
			knife.SetVar("angle", angle)
			knife.SetVar("color", "purple")
			knife.sprite.rotation = angle
			num_knives = num_knives+1
			table.insert(knives, knife)
		elseif color==2 then
			knife = CreateProjectileAbs('KnifeDownblue'..name3, spawnx, spawny)
			knife.SetVar("posx", spawnx)
			knife.SetVar("posy", spawny)
			knife.SetVar("angle", angle)
			knife.SetVar("color", "blue")
			knife.sprite.rotation = angle
			num_knives = num_knives+1
			table.insert(knives, knife)
		else
			knife = CreateProjectileAbs('KnifeDownOrange'..name3, spawnx, spawny)
			knife.SetVar("posx", spawnx)
			knife.SetVar("posy", spawny)
			knife.SetVar("angle", angle)
			knife.SetVar("color", "orange")
			knife.SetVar("time",0)
			knife.sprite.rotation = angle
			num_knives = num_knives+1
			table.insert(knives, knife)
		end
end

function SpawnKnife3(ingo2)
	for i=1,4 do
		local angle=i*90+ingo2*45
		local x=180*math.cos(angle*math.pi/180)
		local y=180*math.sin(angle*math.pi/180)
		local knife=CreateProjectile("KnifeLeftFatal",Player.x+x+x,Player.y+y+y)
		local speedx=-x/60
		local speedy=-y/60
		knife.SetVar("color","gold")
		knife.sprite.alpha=0
		knife.SetVar("time",0)
		knife.SetVar("x",speedx)
		knife.SetVar("y",speedy)
		knife.SetVar("type",3)
		knife.SetVar("color","fatal")
		knife.sprite.rotation=angle+180
		table.insert(TrueKnifes,knife)
	end
end

 
function MoveKnife(knife)
    local ugol = knife.GetVar("angle")
    local old_x = knife.GetVar("posx")
    local old_y = knife.GetVar("posy")
	local dist=math.sqrt((Player.x-knife.x)*(Player.x-knife.x)+(Player.y-knife.y)*(Player.y-knife.y))
   
    local dx = math.sin(math.pi*ugol/180) -- надо подрегулировать скорость
    local dy = -1*math.cos(math.pi*ugol/180)
	if knife.GetVar("time") ~=nil then
		knife.SetVar("time",knife.GetVar("time")+1)
		--if knife.GetVar("time") < 60 and knife.GetVar("time")%10==0 and knife.GetVar("color")=="fatal" then
		--	SendShadow("DownLethal",knife.GetVar("posx"),knife.GetVar("posy"),{-6,0},true,knife.GetVar("angle"), 1)
		--end
	else
		knife.SetVar("time",1)
	end
	dx=dx*4
	dy=dy*4
	if knife.GetVar("color")=="mutant" then
		dx=dx/3*2
		dy=dy/3*2
	end
    local new_x = knife.x+dx
    local new_y = knife.y+dy
	knife.MoveTo(new_x, new_y)
end

function MoveKnifeShadow(knife,time)
    local ugol = knife.GetVar("angle")
    local old_x = knife.GetVar("posx")
    local old_y = knife.GetVar("posy")
	local dist=math.sqrt((Player.x-knife.x)*(Player.x-knife.x)+(Player.y-knife.y)*(Player.y-knife.y))
   
    local dx = math.sin(math.pi*ugol/180) -- надо подрегулировать скорость
    local dy = -1*math.cos(math.pi*ugol/180)
 
	dx=dx*-7*time
	dy=dy*-7*time
    local new_x = knife.x+dx
    local new_y = knife.y+dy
	knife.MoveTo(new_x, new_y)
end

vzmahi = {}
deadtime=0
blasts = {}

endgame = false
lastsecond = 0
sdvig = 1

function GameOver()
	Audio.Stop()
	Player.SetControlOverride(true)
	playerspeed_x = 0
	playerspeed_y = 0
	Player.sprite.rotation = 0
	endgame = true
	incontrol = false
	endwave=true
end 

swarmTimer=300
 
function Update()
HurtUpd(1200)
Moving()
	if endgame==false then
		spawntimer = spawntimer + 1
	end
    if spawntimer%60 == 1 and spawntimer<900 then
        SpawnKnife()
    end

	if spawntimer%45 == 1 and spawntimer<900 then
        SpawnKnife2()
    end

	if spawntimer==1000 or spawntimer==1100 or spawntimer==900 then
        SpawnKnife()
		SpawnKnife()
		SpawnKnife2()
		SpawnKnife2()
		SpawnKnife2()
		SpawnKnife3(1)
		SpawnKnife3(2)
		swarmTimer=swarmTimer*10+9999999
	elseif spawntimer%90 == 1 and spawntimer<900 then
        SpawnKnife3(math.random(2))
    end

	if purple==true and GetGlobal("purpleSpeedTimer")<1 then
		SetGlobal("purpleSpeed",1)
		SetGlobal("purpleSpeedTimer",1)
	end

	--EndWave()

	for i=1,#TrueKnifes do
		local k=TrueKnifes[i]
		if k.isactive then
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time>10 and time<90 then
				--local much=1-math.cos((time-9)*math.pi/60)
				--local much=math.sin((time-9)*math.pi/60)
				local much=(time-10)/30
				k.Move(much*k.GetVar("x"),much*k.GetVar("y"))
				elseif time>39 then
				k.Move(k.GetVar("x"),k.GetVar("y"))
			end
			k.sprite.rotation=k.sprite.rotation-8
			if time<21 then
				k.sprite.alpha=math.sin(time*math.pi/40)
				elseif time>100 then
				k.sprite.alpha=math.cos((time-50)*math.pi/40)
			end
			if time>=90 then
				k.Remove()
			end
			if (Player.x+36>k.x and Player.x-36<k.x) and (Player.y+36>k.y and Player.y-36<k.y) then
				if collision.CheckCollision(Player, k) and k.sprite.alpha then
					if k.GetVar("color") == "fatal" then
						--if GetGlobal("kProtection") == true then
							if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
								LongHurt(25,60)
							elseif Player.hp > 33 then
								LongHurt(33,60)
							else
								GameOver()
							end
						--else
							--GameOver()
						--end
						--Effects("curse",2)
					elseif k.GetVar("color") == "red" then
						kHurt(5)
						--Effects("curse",2)
					elseif k.GetVar("color") == "blue" and isMoving() then
						kHurt(2)
						--Effects("curse",1)
					elseif k.GetVar("color") == "orange" and not isMoving() then
						kHurt(2)
						--Effects("curse",1)
					elseif k.GetVar("color") == "purple" then
						--kHurt(1)
						SetGlobal("purpleSpeed",9)
						SetGlobal("purpleSpeedTimer",60)
						purple=true
						--Effects("curse",1)
					elseif k.GetVar("color") == "mutant" then
						GameOver()
					end
				end
			end
		end
	end

	if endgame==true then
	  deadtime=deadtime+1
	  Encounter.Call("SetMusic","none")
	  Player.SetControlOverride(true)
	  if  deadtime<60 then
		 deadscreen = CreateProjectile("999999", 0,145-Arena.height/2)
		 deadtime=60
		 else
		 deadscreen.MoveTo(5*math.sin(deadtime*math.pi/5),145-Arena.height/2)
	  end
	  if deadtime==120 then
		FakeDeath()
	  end
	end
 
    for i=1, num_knives do
        local knife = knives[i]
	if knife.isactive then
		if knife.absy>520 or knife.absy<-40 or knife.absx>680 or knife.absx<-40 then
			knife.Remove()
			else
	        	MoveKnife(knife)
			if (Player.x+36>knife.x and Player.x-36<knife.x) and (Player.y+36>knife.y and Player.y-36<knife.y) then
				if collision.CheckCollision(Player, knife) and knife.sprite.alpha then
					if knife.GetVar("color") == "fatal" then
						--if GetGlobal("KnifeProtection") == true then
							if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
								LongHurt(25,60)
							elseif Player.hp > 33 then
								LongHurt(33,60)
							else
								GameOver()
							end
						--else
						--	GameOver()
						--end
						--Effects("curse",2)
					elseif knife.GetVar("color") == "red" then
						KnifeHurt(5)
						--Effects("curse",2)
					elseif knife.GetVar("color") == "blue" and isMoving() then
						KnifeHurt(2)
						--Effects("curse",1)
					elseif knife.GetVar("color") == "orange" and not isMoving() then
						KnifeHurt(2)
						--Effects("curse",1)
					elseif knife.GetVar("color") == "purple" then
						--KnifeHurt(1)
						SetGlobal("purpleSpeed",9)
						purple=true
						SetGlobal("purpleSpeedTimer",60)
						--Effects("curse",1)
					elseif knife.GetVar("color") == "mutant" then
						GameOver()
					end
				end
			end
		end
	end
    end

	if spawntimer == 360 then
		--EndWave()
	end
end
 
function OnHit(knife)
end