Arena.ResizeImmediate(120,120)
Arena.Move(0,85,true,true)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}
local point=200/8
local startrot=math.random(2)
oldx=-3
oldy=-3
--Player.lv=1
slices={}
--knifes={}
beams={}
throw={}
warns={}
require "Libraries/colortoys"
collision = require "Libraries/rotational_collision"

function DoKnifes()
	local rot=math.random(4)
	local rand=math.random(5)-3
	if startrot==2 then
		while rot%2==1 do
			rot=math.random(4)
		end
		while oldx==rand or oldx-rand>2 or oldx-rand<-2 do
			rand=math.random(5)-3
		end
		oldx=rand
		startrot=1
		else
		while rot%2==0 do
			rot=math.random(4)
		end
		while oldy==rand or oldy-rand>2 or oldy-rand<-2 do
			rand=math.random(5)-3
		end
		oldy=rand
		startrot=2
	end
	for i=-2,2 do
		local x=24*i
		if i==rand then
			--SendKnife2(x,rot)
			else
			SendKnife(x,rot)
		end
	end
end

function DoKnifes2()
	local rot=math.random(4)
	local rand=math.random(5)-3
	for i=-2,2 do
		local x=24*i
		if i==rand then
			SendKnife2(x,rot)
			else
			--SendKnife(x,rot)
		end
	end
end

function DoKnifes3(side)
	for i=-2,2 do
		local x=24*i
		--if i==rand then
			--SendKnife2(x,rot)
			--else
			SendKnife3(x,side)
		--end
	end
end


function SendKnife(x,side)
	local spr="KnifeDownMutant"
	if side%2==1 then
		spr="KnifeLeftMutant"
	end
	local knife=0
	if side%2==0 then
		knife=CreateProjectile(spr,x,200-200*(side-2))
		else
		knife=CreateProjectile(spr,200-200*(side-1),x)
	end
	if side>2 then
		knife.sprite.rotation=180
	end	
	knife.SetVar("i",i)
	knife.SetVar("time",-50)
	knife.SetVar("side",side)	
	knife.SetVar("speed",speed)
	knife.SetVar("color","mutant")
	knife.sprite.alpha=0
	table.insert(knifes,knife)
end

function SendKnife2(x,side)
	local spr="KnifeDownFake"
	if side%2==1 then
		spr="KnifeLeftFake"
	end
	local knife=0
	if side%2==0 then
		knife=CreateProjectile(spr,x,200-200*(side-2))
		else
		knife=CreateProjectile(spr,200-200*(side-1),x)
	end
	if side>2 then
		knife.sprite.rotation=180
	end	
	knife.SetVar("i",i)
	knife.SetVar("time",-50)
	knife.SetVar("side",side)	
	knife.SetVar("color","warn")
	knife.SetVar("speed",speed)
	knife.sprite.alpha=0
	knife.sprite.color={1,1,1}
	table.insert(knifes,knife)
end

function SendKnife3(x,side)
	local spr="KnifeDownMutant"
	if side%2==1 then
		spr="KnifeLeftMutant"
	end
	local knife=0
	if side%2==0 then
		knife=CreateProjectile(spr,x,200-200*(side-2))
		else
		knife=CreateProjectile(spr,200-200*(side-1),x)
	end
	if side>2 then
		knife.sprite.rotation=180
	else
		--knife.sprite.rotation=270
	end	
	knife.SetVar("i",i)
	knife.SetVar("time",150)
	knife.SetVar("side",side)	
	knife.SetVar("color","red")
	knife.SetVar("speed",speed)
	--knife.sprite.color={1,0,0}
	knife.sprite.alpha=1
	table.insert(knifes,knife)
end

num_knives = 0
knives5 = {}
--Arena.Resize(200, 200)
--Arena.MoveTo(320,140,true,true)
--collision = require "Libraries/rotational_collision"
lock=CreateProjectile("empty",0,0)
lock.SetVar("empty",true)
target=CreateProjectile("empty",0,0)
target.SetVar("empty",true)

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
		knife.SetVar("color", "red")
		knife.SetVar("timer", 0)
        knife.sprite.rotation = angle
        num_knives = num_knives+1
        table.insert(knives5, knife)
end

num_spears = 0
spears = {}
bullets = {}
starttime = Time.time
burn=0
burntime=0

function SpawnSpear()
	spawny = 220
	starttime = Time.time
	--for i=1, 3 do
		local spawnx = 30 - 60
		local spearpos = Player.x + spawnx
		local angle = -5 + 10
		local borntime = Time.time+1*0.1
		spear = CreateProjectile('vert_spear', spearpos, spawny)
		spear.SetVar("posx", spearpos)
		spear.SetVar("color","white")
		spear.SetVar("posy", spawny)
		spear.SetVar("angle", angle)
		spear.SetVar("timeoflife", borntime)
		spear.sprite.rotation = angle
		num_spears = num_spears+1
		table.insert(spears, spear)
	--end
end

function MoveSpear(spear)
	local ugol = spear.GetVar("angle")
	local vremya = spear.GetVar("timeoflife")
	local evaluatetime = Time.time - vremya
	if evaluatetime > 0.1 then
		local dx = 5.0*math.sin(math.pi*ugol/180)
		local dy = -5.0*math.cos(math.pi*ugol/180)
		local new_x = spear.x+(dx*2)
		local new_y = spear.y+(dy*2)
		spear.MoveTo(new_x, new_y)
	end
end


function CheckSpear(spear)
	local posx = spear.x
	local posy = spear.y
	local dist=90
	--if Player.x+dist>posx and Player.x-dist<posx and Player.y+dist>posy and Player.y-dist<posy then
	--	if collision.CheckCollision(Player, spear) then
	--		LongHurt(20,60)
	--	end
	--end
	if (posy < -Arena.height/2 + 8) and spear.sprite.alpha>0 then
		spear.sprite.alpha = 0
		local bullet = CreateProjectile('bullet', posx, posy)
		bullet.SetVar("color","white")
		bullet.SetVar('vely', 0)
		bullet.SetVar('velx', 1 - 2*math.random())
		table.insert(bullets, bullet)
		--spear.isactive=false
	end
end

function MoveKnife(knife)
    local ugol = knife.GetVar("angle")
    local old_x = knife.GetVar("posx")
    local old_y = knife.GetVar("posy")
	local dist=math.sqrt((Player.x-knife.x)*(Player.x-knife.x)+(Player.y-knife.y)*(Player.y-knife.y))
   
    local dx = math.sin(math.pi*ugol/180) -- надо подрегулировать скорость
    local dy = -1*math.cos(math.pi*ugol/180)
 
	dx=dx*5
	dy=dy*5
    local new_x = knife.x+(dx*3)
    local new_y = knife.y+(dy*3)
	knife.MoveTo(new_x, new_y)
end

function MoveKnifeStart(knife)
    local ugol = knife.GetVar("angle")
    local old_x = knife.GetVar("posx")
    local old_y = knife.GetVar("posy")
	local dist=math.sqrt((Player.x-knife.x)*(Player.x-knife.x)+(Player.y-knife.y)*(Player.y-knife.y))
   
    local dx = math.sin(math.pi*ugol/180) -- надо подрегулировать скорость
    local dy = -1*math.cos(math.pi*ugol/180)
 
	dx=dx*12
	dy=dy*12
    local new_x = knife.x+(dx*5)
    local new_y = knife.y+(dy*5)
	knife.MoveTo(new_x, new_y)
end

function Update()
if spawntime%300==80 then
	DoKnifes()
end
--if spawntime%240==0 then
--	DoKnifes2()
--end

if spawntime%180==0 then
	DoWarn(Player.x,Player.y,90)
	DoWarn(Player.x,Player.y,0)
end
--if spawntime%300==60 then
---	DoSlice(0,0,90,"strong")
--	DoSlice(0,0,0,"strong")
--end
HurtUpd(900)--3600
Moving()
spawntime=spawntime+1
 --spawntimer = spawntimer + 1
    if spawntime%180 == 1 then
        SpawnKnife()
    end
 
    for i=1, num_knives do
        local knife = knives5[i]
	if knife.isactive then
		knife.SetVar("timer", knife.GetVar("timer")+1)
		if knife.GetVar("timer") ==1 then
	        MoveKnifeStart(knife)
		end
		if knife.absy>520 or knife.absy<-40 or knife.absx>680 or knife.absx<-40 then
			knife.Remove()
			elseif knife.GetVar("timer") >=60 then
	        	MoveKnife(knife)
			if (Player.x+36>knife.x and Player.x-36<knife.x) and (Player.y+36>knife.y and Player.y-36<knife.y) then
				if collision.CheckCollision(Player, knife) and knife.sprite.alpha then
					GameOver()
				end
			end
		end
	end
    end
	attacktime = Time.time - starttime
	--if attacktime > 10 then
	--	SpawnSpear()
	--end

	for j=1, num_spears do
		local spear = spears[j]
		MoveSpear(spear)
		CheckSpear(spear)
   	end
	   for i=1,#slices do
	local s=slices[i]
	if s.isactive then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		if time<31 and time%5==0 then
			s.sprite.Set("att"..time/5)
			elseif time==31 then
			s.sprite.Set("deadlyslice")
			Audio.PlaySound("bolt")
			elseif time<61 then
			s.sprite.alpha=math.cos((time-31)*math.pi/60)
			elseif time==61 then
			s.Remove()
		end
		if time>30 and time<36 then
			if collision.CheckCollision(Player,s)==true then
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
			end	
		end
	end
end
    for i=1,#bullets do
        local bullet = bullets[i]
        local velx = bullet.GetVar('velx')
        local vely = bullet.GetVar('vely')
        local newposx = bullet.x + velx
        local newposy = bullet.y + vely
        if(bullet.x > -Arena.width/2 and bullet.x < Arena.width/2) then
            if(bullet.y < -Arena.height/2 + 8) then 
                newposy = -Arena.height/2 + 8
                vely = 2 + math.random()
            end
        end
        vely = vely - 0.04
        bullet.MoveTo(newposx, newposy)
        bullet.SetVar('vely', vely)
    end

	for i=1,#warns do
	local w=warns[i]
	if w.isactive then
		local time=w.GetVar("time")+1
		w.SetVar("time",time)
		if time<30 then
			if time%5==1 then
				if time%10==1 then
					w.sprite.color={1,0,0}
					else
					w.sprite.color={1,1,0}
				end
			end
			else
			DoSlice(w.x,w.y,w.sprite.rotation,w.GetVar("strong"))
			w.Remove()
		end
	end
end
for i=1,#beams do
	local b=beams[i]
	if b.isactive then
		local time=b.GetVar("time")+1
		b.SetVar("time",time)
		if time<31 then
			b.sprite.alpha=math.sin(time*math.pi/60)
		end
		if time<31 then
			local away=b.GetVar("away")+80*(1-math.sin(time*math.pi/60))
			local px=b.GetVar("px")
			local py=b.GetVar("py")
			local rotation=b.sprite.rotation+90
			b.MoveTo(px+away*math.cos(rotation*math.pi/180),py+away*math.sin(rotation*math.pi/180))
			if time==30 then
				b.SetVar("time",60)
			end
			elseif time==61 then
			local waittime=b.GetVar("awaittime")
			if waittime>0 then
				waittime=waittime-1
				b.SetVar("time",60)
			end
			b.SetVar("awaittime",waittime)
			elseif time<91 then
			local away=b.GetVar("away")
			local rotation=b.sprite.rotation+90
			local px=b.GetVar("px")+4*math.cos((rotation-90)*math.pi/180)*math.sin((time-60)*math.pi/6)
			local py=b.GetVar("py")+4*math.sin((rotation-90)*math.pi/180)*math.sin((time-60)*math.pi/6)
			b.MoveTo(px+away*math.cos(rotation*math.pi/180),py+away*math.sin(rotation*math.pi/180))
			elseif time==91 then
			Audio.PlaySound("lasershot")
			local away=b.GetVar("away")
			local px=b.GetVar("px")
			local py=b.GetVar("py")
			b.sprite.Set("blaster2")
			local rotation=b.sprite.rotation+90
			b.MoveTo(px+away*math.cos(rotation*math.pi/180),py+away*math.sin(rotation*math.pi/180))
			local laser=CreateProjectile("laser0/laserv2",0,0)
			laser.SetVar("time", math.random(30)/10)
			b.sprite.SendToTop()
			laser.sprite.rotation=b.sprite.rotation
			b.SetVar("laser",laser)
			elseif time<211 then
			b.sprite.alpha=math.cos((time-90)*math.pi/120)
			local rotation=b.sprite.rotation+90
			local speed=3*(1-math.cos((time-90)*math.pi/120))
			b.Move(speed*math.cos(rotation*math.pi/180),speed*math.sin(rotation*math.pi/180))
			elseif time==211 then
			b.Remove()
		end
		if time>90 and time<211 then
			local l=b.GetVar("laser")
			local hueshift=l.GetVar("time") + 8*math.pi / 180
			l.sprite.color = color_multiply(hsv_to_rgb(hueshift, 1.0, 0.70), 0.5)
			l.SetVar("time",hueshift)
			local rot=b.sprite.rotation-90
			local ht=l.sprite.height
			l.MoveTo(b.x+math.cos(rot*math.pi/180)*550,b.y+math.sin(rot*math.pi/180)*550)
			if time<106 then
				l.sprite.Scale(0.8+0.2*math.sin((time-90)*math.pi/30),1)
				elseif time<181 then
				l.sprite.Scale(1-0.5*(1-math.cos((time-105)*math.pi/150)),1)
				l.sprite.alpha=0.6+0.4*math.cos((time-105)*math.pi/150)
				elseif time<211 then
				l.sprite.Scale(0.5-0.2*math.sin((time-180)*math.pi/60),1)
				l.sprite.alpha=0.6*(1-math.sin((time-180)*math.pi/60))
			end
			if time<181 then
				if collision.CheckCollision(Player,l) then
					GameOver()
				end
			end
		end
	end
end

for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		if k.GetVar("color") == "warn" then
			time=k.GetVar("time")+0.5
		end
		k.SetVar("time",time)
		local side=k.GetVar("side")
		if time>60 and time<106 then
			if side%2==1 then
				local x=(200-336*math.sin((time-60)*math.pi/100))*(2-side)
				k.MoveTo(x,k.y)
				else
				local y=(200-336*math.sin((time-60)*math.pi/100))*(3-side)
				k.MoveTo(k.x,y)
			end
		end
		if time>120 then
			if side%2==1 then
				local x=(200-336*math.sin((time-80)*math.pi/100))*(2-side)
				k.MoveTo(x,k.y)
				else
				local y=(200-336*math.sin((time-80)*math.pi/100))*(3-side)
				k.MoveTo(k.x,y)
			end
		end
		if time==100 then
			--if side%2==1 then
				--SendKnife3(k.y,side)
			--	DoKnifes3(side)
			--else
				--SendKnife3(k.x,side)
			--end
			if k.GetVar("color") == "warn" then
				DoKnifes3(side)
			end
			k.Remove()
		end
		if time<31 then
			k.sprite.alpha=math.sin(time*math.pi/60)
		elseif time>160 and time<190 then
			k.sprite.alpha=math.sin((time-150)*math.pi/60)
		elseif time==190 then
			k.Remove()
		end
	end
end



end

function DoWarn(pointx,pointy,rot,strong)
	local warn=CreateProjectile("chara/warnline",pointx,pointy)
	table.insert(warns,warn)
	warn.SetVar("strong",strong)
	if strong=="strong" then
		warn.sprite.Scale(2,2)
	end
	warn.SetVar("time",0)
	warn.sprite.rotation=rot
end
function DoSlice(pointx,pointy,rotation,strong)
	local slice=CreateProjectile("empty",pointx,pointy)
	slice.sprite.rotation=rotation
	--if strong=="strong" then
	--	slice.sprite.Scale(2,2)
	--end
	slice.SetVar("time",0)
	--slice.SetVar("color","purple")
	Audio.PlaySound("slice2")
	table.insert(slices,slice)
end

function GameOver()
	Audio.Stop()
	Player.SetControlOverride(true)
	playerspeed_x = 0
	playerspeed_y = 0
	Player.sprite.rotation = 0
	endgame = true
	incontrol = false
	endwave=true
	KnifeHurt(9999)
end

function OnHit(k)
	if k.GetVar("color") == "mutant" then
		GameOver()
	end
	if 1 == 2 then
		if k.GetVar("color") == "red" then
			--KnifeHurt(3)
			if Player.lv > 5 then
				Player.lv=Player.lv-5
			else
				KnifeHurt(3)
			end
			--Effects("curse",2)
		elseif k.GetVar("color") == "gold" then
		--	KnifeHurt(2)
		if Player.lv > 2 then
				Player.lv=Player.lv-2
			else
				KnifeHurt(2)
			end
		--	Effects("curse",1)
		elseif k.GetVar("color") == "blue" and isMoving() then
		--	KnifeHurt(1)
		if Player.lv > 1 then
				Player.lv=Player.lv-1
			else
				KnifeHurt(1)
			end
		--	Effects("curse",1)
		elseif k.GetVar("color") == "orange" and not isMoving() then
		--	KnifeHurt(1)
		if Player.lv > 1 then
				Player.lv=Player.lv-1
			else
				KnifeHurt(1)
			end
		--	Effects("curse",1)
		elseif k.GetVar("color") == "purple" then
			--Encounter.SetVar("cursed", true)
			--Encounter.SetVar("IsCursed",true)
			--Effects("curse",0.1)
			--if  then
				--Encounter.SetVar("MaxHp", Encounter.GetVar("MaxHp")+1)
			--if Player.lv > 1 then
			--	Player.lv=Player.lv-1
			--else
				KnifeHurt(1)
			--end
			--else
				--Encounter.SetVar("MaxHp", 2)
				--Player.lv=99
			--end
		elseif k.GetVar("color") == "white" then
		--	KnifeHurt(1)
			if Player.lv > 1 then
				Player.lv=Player.lv-1
			else
				KnifeHurt(1)
			end
		--	Effects("curse",1)
		elseif k.GetVar("color") == "warn" then
			--k.sprite.color={0,0,0}
			k.Remove()
		end
	end
end