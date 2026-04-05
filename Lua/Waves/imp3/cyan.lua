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
--Encounter.Call("SetMusic", "last")
Player.sprite.color={0/255, 168/255, 242/255}
DoGhost("smile",0,600)
chargeTime=0
charged=false
forces={}
knives2={}
purpleSpeed2=1
bombs={}
bombs2={}
bombs3={}

if Encounter.GetVar("diff")~= 30 and Encounter.GetVar("diff")~= 28 and Encounter.GetVar("diff")~= 27 then
	Encounter.SetVar("SavedProg",66)
end
name5="Fatal"
if Encounter.GetVar("diff")==30 then
	name5="Mutant"
end

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
        knife = CreateProjectileAbs('KnifeDown'..name5, spawnx, spawny)
        knife.SetVar("posx", spawnx)
        knife.SetVar("posy", spawny)
        knife.SetVar("angle", angle)
		knife.SetVar("color","fatal")
		knife.SetVar("time",0)
        knife.sprite.rotation = angle
        num_knives = num_knives+1
        table.insert(knives2, knife)
		--SendShadow("DownLethal",knife.GetVar("posx"),knife.GetVar("posy"),{-6,0},true,knife.GetVar("angle"), 2)
end

function SendShadow(name, positionx, positiony, speed, istrue, angle, time)
	knife=CreateProjectileAbs("KnifeDownLethal",positionx,positiony)
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
	local color=1--math.random(3)
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
			knife = CreateProjectileAbs('KnifeDownblueDeadly', spawnx, spawny)
			knife.SetVar("posx", spawnx)
			knife.SetVar("posy", spawny)
			knife.SetVar("angle", angle)
			knife.SetVar("color", "blue")
			knife.sprite.rotation = angle
			num_knives = num_knives+1
			table.insert(knives, knife)
		else
			knife = CreateProjectileAbs('KnifeDownOrangeDeadly', spawnx, spawny)
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
	dx=dx*3
	dy=dy*3
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

swarmTimer=1
phase=1
 
function Update()
HurtUpd(99999)
Moving()
	if endgame==false then
		spawntimer = spawntimer + 1
	end
    --if spawntimer%15 == 1 then
    --    SpawnKnife()
    --end

	--if spawntimer%12 == 1 then
    --    SpawnKnife2()
    --end
	SetGlobal("purpleSpeedTimer",60)

	if Input.Confirm>0 and charged ~= true and chargeTime>=90 then 
		SetGlobal("purpleSpeed",purpleSpeed2*1.5)
		chargeTime=-90
		charged=true
		local force = CreateProjectile("green/force",0,0)
		force.SetVar("scalex",0.5)
		force.sprite.color={0.5,0.5,1}
		force.SetVar("scaley",0.5)
		table.insert(forces,force)
	else
		if chargeTime<90 then
			--if Input.Confirm<=0 then
				chargeTime=chargeTime+1
			--end
			SetGlobal("purpleSpeed",purpleSpeed2)
			if chargeTime<=-60 then
				Player.sprite.color={0, 0.35, 1}
			else
				Player.sprite.color={0, 0.5, 1}
			end
		else
			chargeTime=90
			SetGlobal("purpleSpeed",purpleSpeed2)
			Player.sprite.color={0/255, 168/255, 242/255}
			charged=false
		end
	end

	for i=1,#forces do
	local force=forces[i]
	if force~=nil and force.isactive then
		force.sprite.Scale(force.GetVar("scalex"), force.GetVar("scaley"))
		force.SetVar("scalex",force.GetVar("scalex")+0.1)
		force.SetVar("scaley",force.GetVar("scaley")+0.1)
		force.sprite.alpha=1-((force.GetVar("scalex")/10)-0.1)
		force.MoveTo(Player.x,Player.y)
		for i=1,#knives do 
			local knife=knives[i]
			if (Player.x+force.GetVar("scalex")*40>knife.x and Player.x-force.GetVar("scalex")*40<knife.x) and (Player.y+force.GetVar("scaley")*40>knife.y and Player.y-force.GetVar("scaley")*40<knife.y) then
				--if shield==nil then
					--elseif dir==sdir then
					knife.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
			end
		end

		for i=1,#knives2 do 
			local knife=knives2[i]
			if (Player.x+force.GetVar("scalex")*40>knife.x and Player.x-force.GetVar("scalex")*40<knife.x) and (Player.y+force.GetVar("scaley")*40>knife.y and Player.y-force.GetVar("scaley")*40<knife.y) then
				--if shield==nil then
					--elseif dir==sdir then
					knife.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
			end
		end

		--for i=1,#bombs do 
		--	local knife=bombs[i]
		--	if (Player.x+force.GetVar("scalex")*40>knife.x and Player.x-force.GetVar("scalex")*40<knife.x) and (Player.y+force.GetVar("scaley")*40>knife.y and Player.y-force.GetVar("scaley")*40<knife.y) and knife.GetVar("color")=="bum" then
				--if shield==nil then
					--elseif dir==sdir then
		--			knife.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
		--	end
		--end

		--for i=1,#bombs2 do 
		--	local knife=bombs2[i]
		--	if (Player.x+force.GetVar("scalex")*40>knife.x and Player.x-force.GetVar("scalex")*40<knife.x) and (Player.y+force.GetVar("scaley")*40>knife.y and Player.y-force.GetVar("scaley")*40<knife.y) and knife.GetVar("color")=="bum" then
				--if shield==nil then
					--elseif dir==sdir then
		--			knife.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
		--	end
		--end

		--for i=1,#bombs3 do 
		--	local knife=bombs3[i]
		--	if (Player.x+force.GetVar("scalex")*40>knife.x and Player.x-force.GetVar("scalex")*40<knife.x) and (Player.y+force.GetVar("scaley")*40>knife.y and Player.y-force.GetVar("scaley")*40<knife.y) and knife.GetVar("color")=="bum" then
				--if shield==nil then
					--elseif dir==sdir then
		--			knife.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
		--	end
		--end

		for i=1,#shadows do 
			local knife=shadows[i]
			if (Player.x+force.GetVar("scalex")*40>knife.x and Player.x-force.GetVar("scalex")*40<knife.x) and (Player.y+force.GetVar("scaley")*40>knife.y and Player.y-force.GetVar("scaley")*40<knife.y) then
				--if shield==nil then
					--elseif dir==sdir then
					knife.Remove()
					--Audio.PlaySound("reflect")
					--shield.sprite.Set("green/shield_hit")
				--end
			end
		end

		if force.GetVar("scalex") > 1.5 then
			force.SetVar("scalex",1)
			force.SetVar("scaley",1)
			--force.isactive=false
			--force.isactive(false)
			force.sprite.alpha=1
			force.Remove()
		end

	end
end

	if spawntimer%360 == 1 and phase~=2 then
		for i=1,swarmTimer do
			SpawnKnife2()
		end
		swarmTimer=swarmTimer+1
    end

	if spawntimer%180==0 and (spawntimer<900 or phase==2) then
		SpawnKnife()
	elseif spawntimer%150==0 and spawntimer<1500 and spawntimer>900 and phase==1 then
		SpawnKnife()
	elseif spawntimer%120==0 and spawntimer>1500 and phase==1 then
		SpawnKnife()
	--elseif spawntimer%90==0 and spawntimer<3000 and spawntimer>2400 then
	--	SpawnKnife()
	--elseif spawntimer%60==0 and spawntimer>3000 then
	--	SpawnKnife()
	end

	if spawntimer%150==60 and phase==1 then
		if math.random(2)==1 then
			local random=math.random(300)-150
			local random2=(math.random(2)*2-3)
			local bomb=CreateProjectile("bomb0",random,random2*400)
			bomb.SetVar("color","bum")
			table.insert(bombs,bomb)
			bomb.SetVar("time",0)
			bomb.SetVar("timer",0)
			bomb.SetVar("speedx",0)
			bomb.SetVar("speedy",random2*(math.random(3)+1))
		else
			local random=(math.random(2)*2-3)
			local random2=math.random(300)-150
			local bomb=CreateProjectile("bomb0",random*400,random2)
			bomb.SetVar("color","bum")
			table.insert(bombs,bomb)
			bomb.SetVar("time",0)
			bomb.SetVar("timer",0)
			bomb.SetVar("speedx",random*(math.random(3)+1))
			bomb.SetVar("speedy",0)
		end
	end

	if spawntimer%240==0 and spawntimer>=600 and phase==1 then
		if math.random(2)==1 then
			local random=math.random(300)-150
			local random2=(math.random(2)*2-3)
			local bomb=CreateProjectile("bomb2",random,random2*400)
			bomb.SetVar("color","bum")
			table.insert(bombs2,bomb)
			bomb.SetVar("time",0)
			bomb.SetVar("timer",0)
			bomb.SetVar("speedx",0)
			bomb.SetVar("speedy",random2*(math.random(3)+1))
		else
			local random=(math.random(2)*2-3)
			local random2=math.random(300)-150
			local bomb=CreateProjectile("bomb2",random*400,random2)
			bomb.SetVar("color","bum")
			table.insert(bombs2,bomb)
			bomb.SetVar("time",0)
			bomb.SetVar("timer",0)
			bomb.SetVar("speedx",random*(math.random(3)+1))
			bomb.SetVar("speedy",0)
		end
	end

	if spawntimer%450==180 and spawntimer>=1200 and phase==1 then
		if math.random(2)==1 then
			local random=0
			local random2=(math.random(2)*2-3)
			local bomb=CreateProjectile("bomb4",random,random2*400)
			bomb.SetVar("color","bum")
			table.insert(bombs3,bomb)
			bomb.SetVar("time",0)
			bomb.SetVar("timer",0)
			bomb.SetVar("speedx",0)
			bomb.SetVar("speedy",random2*5)
		else
			local random=(math.random(2)*2-3)
			local random2=0
			local bomb=CreateProjectile("bomb4",random*400,random2)
			bomb.SetVar("color","bum")
			table.insert(bombs3,bomb)
			bomb.SetVar("time",0)
			bomb.SetVar("timer",0)
			bomb.SetVar("speedx",random*5)
			bomb.SetVar("speedy",0)
		end
	end

for i=1,#bombs do
	local b=bombs[i]
	if b.isactive then
		local time=b.GetVar("time")
		if time==0 then
			b.Move(b.GetVar("speedx")*-0.5,b.GetVar("speedy")*-0.5)
			b.SetVar("timer",b.GetVar("timer")+1)
			if b.GetVar("timer") > 330 then
				b.sprite.color={1,0,0}
			end
			if (b.y<5 and b.y>-5) or (b.x<5 and b.x>-5) or b.GetVar("timer") > 360 then
				b.SetVar("time",1)
		    end
		else
			b.SetVar("time",time+1)
            b.SetVar("color","bum")
			if time<20 then
				if time==1 then
					Audio.PlaySound("plusexplode")
				end
				if time%2==0 then
					b.sprite.Set("bomb"..(time/2)%2)
				end
				elseif time==20 then
				local laser=CreateProjectile("mylaser/laserv2",b.x,b.y)
				b.sprite.Set("mylaser/laserh2")
				laser.sprite.color=b.sprite.color
				b.SetVar("laser",laser)
				laser.sprite.Scale(2,2)
				b.sprite.Scale(2,2)
				b.SetVar("type","bomb")
                laser.SetVar("color","bum")
				laser.SetVar("type","bomb")
				--DoHole(b.x,4)
				--DoHole(b.x,3)
				--DoHole(b.x,2)
				--DoHole(b.x,1)
				elseif time<31 then
				b.sprite.alpha=1-math.sin((time-20)*math.pi/20)
				local l=b.GetVar("laser")
				l.sprite.alpha=b.sprite.alpha
				elseif time==31 then
				b.Remove()
				local l=b.GetVar("laser")
				l.Remove()
			end
		end
	end
end

for i=1,#bombs2 do
	local b=bombs2[i]
	if b.isactive then
		local time=b.GetVar("time")
		if time==0 then
			b.Move(b.GetVar("speedx")*-0.5,b.GetVar("speedy")*-0.5)
			b.SetVar("timer",b.GetVar("timer")+1)
			if b.GetVar("timer") > 330 then
				b.sprite.color={1,0,0}
			end
			if (b.y<5 and b.y>-5) or (b.x<5 and b.x>-5) or b.GetVar("timer") > 360 then
				b.SetVar("time",1)
		    end
		else
			b.SetVar("time",time+1)
            b.SetVar("color","none")
			if time<20 then
				if time==1 then
					Audio.PlaySound("plusexplode")
				end
				if time%2==0 then
					b.sprite.Set("bomb"..(time/2)%2+2)
				end
				elseif time==20 then
				local laser=CreateProjectile("mylaser/laserv2",b.x,b.y)
				b.sprite.Set("mylaser/laserh2")
				b.sprite.rotation=45
				laser.sprite.rotation=45
				laser.sprite.color=b.sprite.color
				b.SetVar("laser",laser)
				--laser.sprite.Scale(2,2)
				--b.sprite.Scale(2,2)
				b.SetVar("type","bomb")
                laser.SetVar("color","none")
				laser.SetVar("type","bomb")
				--DoHole(b.x,4)
				--DoHole(b.x,3)
				--DoHole(b.x,2)
				--DoHole(b.x,1)
				elseif time<31 then
				b.sprite.alpha=1-math.sin((time-20)*math.pi/20)
				if collision.CheckCollision(Player, b) and chargeTime > -60 then
					if b.sprite.color=={1,0,0} then
						LongHurt(25,45,true)
					else
						LongHurt(20,30,true)
					end
				end
				local l=b.GetVar("laser")
				l.sprite.alpha=b.sprite.alpha
				if collision.CheckCollision(Player, l) and chargeTime > -60 then
					if l.sprite.color=={1,0,0} then
						LongHurt(25,45,true)
					else
						LongHurt(20,30,true)
					end
				end
				elseif time==31 then
				b.Remove()
				local l=b.GetVar("laser")
				l.Remove()
			end
		end
	end
end

for i=1,#bombs3 do
	local b=bombs3[i]
	if b.isactive then
		local time=b.GetVar("time")
		if time==0 then
			b.Move(b.GetVar("speedx")*-0.2,b.GetVar("speedy")*-0.2)
			b.SetVar("timer",b.GetVar("timer")+1)
			if b.GetVar("timer") > 330 then
				b.sprite.color={1,0,0}
				phase=2
			elseif b.GetVar("timer") > 300 then
				b.sprite.color={1,0.5,0}
				phase=1.5
			end
			if b.GetVar("timer") > 360 then
				b.SetVar("time",1)
		    end
		else
			b.SetVar("time",time+1)
			phase=2
            b.SetVar("color","none")
			if time<20 then
				if time==1 then
					Audio.PlaySound("plusexplode")
				end
				if time%2==0 then
					b.sprite.Set("bomb"..(time/2)%2+4)
				end
				elseif time==20 then
				local laser=CreateProjectile("mylaser/laserv2",b.x,b.y)
				local laser2=CreateProjectile("mylaser/laserh2",b.x,b.y)
				local laser3=CreateProjectile("mylaser/laserv2",b.x,b.y)
				b.sprite.Set("mylaser/laserh2")
				laser2.sprite.rotation=45
				laser3.sprite.rotation=45
				laser.sprite.color=b.sprite.color
				laser2.sprite.color=b.sprite.color
				laser3.sprite.color=b.sprite.color
				b.SetVar("laser",laser)
				b.SetVar("laser2",laser2)
				b.SetVar("laser3",laser3)
				--laser.sprite.Scale(2,2)
				laser2.sprite.Scale(0.75,0.75)
				laser3.sprite.Scale(0.75,0.75)
				--b.sprite.Scale(2,2)
				b.SetVar("type","bomb")
                laser.SetVar("color","none")
				laser.SetVar("type","bomb")
				laser2.SetVar("color","none")
				laser2.SetVar("type","bomb")
				laser3.SetVar("color","none")
				laser3.SetVar("type","bomb")
				--DoHole(b.x,4)
				--DoHole(b.x,3)
				--DoHole(b.x,2)
				--DoHole(b.x,1)
				elseif time<601 then
				b.sprite.alpha=1
				if collision.CheckCollision(Player, b) and chargeTime > -60 then
					if b.sprite.color=={1,0,0} then
						LongHurt(25,45,true)
					else
						LongHurt(20,30,true)
					end
				end
				local l=b.GetVar("laser")
				l.sprite.alpha=b.sprite.alpha
				if collision.CheckCollision(Player, l) and chargeTime > -60 then
					if l.sprite.color=={1,0,0} then
						LongHurt(25,45,true)
					else
						LongHurt(20,30,true)
					end
				end
				local l2=b.GetVar("laser2")
				l2.sprite.alpha=b.sprite.alpha
				if collision.CheckCollision(Player, l2) and chargeTime > -60 then
					if l2.sprite.color=={1,0,0} then
						LongHurt(25,45,true)
					else
						LongHurt(20,30,true)
					end
				end
				local l3=b.GetVar("laser3")
				l3.sprite.alpha=b.sprite.alpha
				if collision.CheckCollision(Player, l3) and chargeTime > -60 then
					if l3.sprite.color=={1,0,0} then
						LongHurt(25,45,true)
					else
						LongHurt(20,30,true)
					end
				end
				b.sprite.rotation=b.sprite.rotation+0.5
				l.sprite.rotation=l.sprite.rotation+0.5
				l2.sprite.rotation=l2.sprite.rotation+0.5
				l3.sprite.rotation=l3.sprite.rotation+0.5
				elseif time==601 then
				b.Remove()
				local l=b.GetVar("laser")
				l.Remove()
				local l2=b.GetVar("laser2")
				l2.Remove()
				local l3=b.GetVar("laser3")
				l3.Remove()
				EndWave()
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
 
    for i=1, #knives do
        local knife = knives[i]
	if knife.isactive then
		if knife.absy>520 or knife.absy<-40 or knife.absx>680 or knife.absx<-40 then
			knife.Remove()
			else
	        	MoveKnife(knife)
				MoveKnife(knife)
				if (Player.x+100>knife.x and Player.x-100<knife.x) and (Player.y+100>knife.y and Player.y-100<knife.y) then
					MoveKnife(knife)
				end
			if (Player.x+36>knife.x and Player.x-36<knife.x) and (Player.y+36>knife.y and Player.y-36<knife.y) then
				if collision.CheckCollision(Player, knife) and knife.sprite.alpha and chargeTime > -60 then
					if knife.GetVar("color") == "fatal" then
						if GetGlobal("KnifeProtection") == true then
							if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
								LongHurt(25,60)
							elseif Player.hp > 33 then
								LongHurt(33,60)
							else
								GameOver()
							end
						else
							GameOver()
						end
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
						--SetGlobal("purpleSpeed",GetGlobal("purpleSpeed")+0.01)
						purpleSpeed2=purpleSpeed2+0.01
						--Effects("curse",1)
					end
				end
			end
		end
	end
    end

	for i=1, #knives2 do
        local knife = knives2[i]
	if knife.isactive then
		if knife.absy>520 or knife.absy<-40 or knife.absx>680 or knife.absx<-40 then
			knife.Remove()
			else
				if knife.GetVar("time")==nil then
					knife.SetVar("time",0)
				else
					knife.SetVar("time",knife.GetVar("time")+1)
					if knife.GetVar("time")<30 or knife.GetVar("time")>90 then
						MoveKnife(knife)
						MoveKnife(knife)
						MoveKnife(knife)
						MoveKnife(knife)
						MoveKnife(knife)
					end
				end
			if (Player.x+36>knife.x and Player.x-36<knife.x) and (Player.y+36>knife.y and Player.y-36<knife.y) then
				if collision.CheckCollision(Player, knife) and knife.sprite.alpha and chargeTime > -60 then
					if knife.GetVar("color") == "fatal" then
						if GetGlobal("KnifeProtection") == true then
							if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
								LongHurt(25,60)
							elseif Player.hp > 33 then
								LongHurt(33,60)
							else
								GameOver()
							end
						else
							GameOver()
						end
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
						--SetGlobal("purpleSpeed",GetGlobal("purpleSpeed")+0.01)
						purpleSpeed2=purpleSpeed2+0.01
						--Effects("curse",1)
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
	if knife.GetVar("color") == "bum" and chargeTime > -60 then
		if knife.sprite.color=={1,0,0} then
			LongHurt(25,45,true)
		else
			LongHurt(20,30,true)
		end
	end
end