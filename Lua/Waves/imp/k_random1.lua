num_knives = 0
spawntimer = 0
knives = {}
Arena.Resize(200, 200)
Arena.MoveTo(320,140,true,true)
collision = require "Libraries/rotational_collision"
lock=CreateProjectile("empty",0,0)
lock.SetVar("empty",true)
target=CreateProjectile("empty",0,0)
target.SetVar("empty",true)
 
require "Libraries/Playermove"
require "Libraries/hurt"
Player.SetControlOverride(true)

DoGhost("smile",0,600)

name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
name3="Deadly"
if GetGlobal("DifficultyPoints") >= 621 then
	name3="Fatal"
end
name4="Lethal"
if GetGlobal("DifficultyPoints") >= 621 then
	name4="Fatal"
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
        knife = CreateProjectileAbs('KnifeDown'..name3, spawnx, spawny)
        knife.SetVar("posx", spawnx)
        knife.SetVar("posy", spawny)
        knife.SetVar("angle", angle)
        knife.sprite.rotation = angle
        num_knives = num_knives+1
        table.insert(knives, knife)
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
        knife = CreateProjectileAbs('KnifeDownPurple', spawnx, spawny)
        knife.SetVar("posx", spawnx)
        knife.SetVar("posy", spawny)
        knife.SetVar("angle", angle)
		knife.SetVar("color", "purple")
        knife.sprite.rotation = angle
        num_knives = num_knives+1
        table.insert(knives, knife)
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
    local new_x = knife.x+dx
    local new_y = knife.y+dy
	knife.MoveTo(new_x, new_y)
end
 
 
function Update()
HurtUpd(900)
Moving()
    spawntimer = spawntimer + 1
    if spawntimer%10 == 1 then
        SpawnKnife()
    end

	if spawntimer%30 == 1 then
        SpawnKnife2()
    end
 
    for i=1, num_knives do
        local knife = knives[i]
	if knife.isactive then
		if knife.absy>520 or knife.absy<-40 or knife.absx>680 or knife.absx<-40 then
			knife.Remove()
			else
	        	MoveKnife(knife)
			if (Player.x+36>knife.x and Player.x-36<knife.x) and (Player.y+36>knife.y and Player.y-36<knife.y) and knife.GetVar("color") ~= "purple" then
				if collision.CheckCollision(Player, knife) and knife.sprite.alpha then
					KnifeHurt(2)
				end
			elseif (Player.x+36>knife.x and Player.x-36<knife.x) and (Player.y+36>knife.y and Player.y-36<knife.y) and knife.GetVar("color") == "purple" then
				if collision.CheckCollision(Player, knife) and knife.sprite.alpha then
					SetGlobal("purpleSpeed",1)
					SetGlobal("purpleSpeedTimer",60)
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