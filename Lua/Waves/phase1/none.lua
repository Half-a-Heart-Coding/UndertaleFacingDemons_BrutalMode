
require "Libraries/Playermove"
require "Libraries/hurt"



function Update()
HurtUpd(600)
Moving()

end

function OnHit()
Effects("curse",1)
KnifeHurt(1)
end