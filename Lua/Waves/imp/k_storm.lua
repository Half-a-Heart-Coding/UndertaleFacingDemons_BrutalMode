num_knives = 0
spawntimer = 0
spawntimer2 = 0
knives = {}
require "Libraries/Playermove"
require "Libraries/hurt"
Player.SetControlOverride(true)
Arena.Resize(100, 100)
collision = require "Libraries/rotational_collision"
randomshift = math.random(0, 360)
name=""
if GetGlobal("DifficultyPoints") >= 621 then
	name="Fatal"
end
name2="Deadly"
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
 
function SpawnKnife(tim)
	local spawntimer=tim*1
    spawnx = 220*math.sin(3.4*math.pi*(randomshift+spawntimer)/180)
    spawny = 220*math.cos(3.4*math.pi*(randomshift+spawntimer)/180) -- плотность узора 3,4 (если менять, то во всех трёх строчках)
    angle = -(randomshift+spawntimer)*3.4
    knife = CreateProjectile('KnifeDown'..name, spawnx, spawny)
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
   
    local dx = 1.3*math.sin(math.pi*ugol/180)
    local dy = -1.3*math.cos(math.pi*ugol/180) -- скорость ножей 1,3 (если менять, то в обеих строчках)
 
    local new_x = knife.x+dx
    local new_y = knife.y+dy
    knife.MoveTo(new_x, new_y)
end
 
 
function Update()
HurtUpd(1000)
Moving()
    spawntimer2 = spawntimer2 + 1
    if spawntimer2%300 < 150 then
        spawntimer = spawntimer + 1
    else
        spawntimer = spawntimer - 1
    end
    if spawntimer%6 == 0 and not (spawntimer2%300 <= 180 and spawntimer2%300 >= 120) and not (spawntimer2%300 <= 30 or spawntimer2%300 >= 270) then
        SpawnKnife(spawntimer)
        if spawntimer2 >= 750 then
            spawntimer2 = spawntimer2 + 3
            if spawntimer2%300 < 150 then
                spawntimer = spawntimer + 3
            else
                spawntimer = spawntimer - 3
            end
        end
    end
 
    for i=1, num_knives do
        local knife = knives[i]
        MoveKnife(knife)
	if (Player.x+34>knife.x and Player.x-34<knife.x) and (Player.y+34>knife.y and Player.y-34<knife.y) then
		if collision.CheckCollision(Player, knife) and knife.sprite.alpha then
			KnifeHurt(1)
		end
	end
    end
end
 
function OnHit(knife)
end

