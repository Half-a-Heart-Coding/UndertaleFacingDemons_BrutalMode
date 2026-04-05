num_knives = 0
spawntimer = 0
knives = {}
Arena.Resize(200, 160)
collision = require "Libraries/rotational_collision"
lock=CreateProjectile("empty",0,0)
lock.SetVar("empty",true)
target=CreateProjectile("empty",0,0)
target.SetVar("empty",true)
 
require "Libraries/Playermove"
require "Libraries/hurt"
Player.SetControlOverride(true)

DoGhost("smile",0,600)

function SpawnKnife()
	pointed=false
	local randx=math.random(Arena.width/2+20)*(math.random(2)*2-3)
	local randy=math.random(Arena.height/2+20)*(math.random(2)*2-3)
    target.MoveTo(randx,randy)
    spawnx = math.random(-35, 675)
    spawny = math.random(-35, 515)
		while pointed==false do
			if (spawnx>0 and spawnx<640 and spawny>0 and spawny<480) then
  				spawnx = math.random(-35, 675)
  				spawny = math.random(-35, 515)
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
        knife = CreateProjectileAbs('vert_knife', spawnx, spawny)
        knife.SetVar("posx", spawnx)
        knife.SetVar("posy", spawny)
        knife.SetVar("angle", angle)
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
 
    if dist>25 and dist<55 then
	dx=dx*(6*(1-math.cos(2*(dist-25)*math.pi/180)))
	dy=dy*(6*(1-math.cos(2*(dist-25)*math.pi/180)))
	elseif dist>54 and dist<115 then
	dx=dx*(6*math.sin((dist-25)*math.pi/180))
	dy=dy*(6*math.sin((dist-25)*math.pi/180))
	elseif dist<26 then
	dx=0
	dy=0
	else 
	dx=dx*6
	dy=dy*6
   end
    local new_x = knife.x+dx
    local new_y = knife.y+dy
	knife.MoveTo(new_x, new_y)
end
 
 
function Update()
HurtUpd(600)
Moving()
    spawntimer = spawntimer + 1
    if spawntimer%15 == 1 then
        SpawnKnife()
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
					KnifeHurt(1)
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