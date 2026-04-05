spawntime=0
Arena.Resize()
Player.MoveTo(0,0,true)
collision = require "Libraries/rotational_collision"
require "Libraries/Playermove"
require "Libraries/hurt"
weapons={}





function Update()
HurtUpd()
Moving()

end


function OnHit()
end