
require "Libraries/Playermove"
require "Libraries/hurt"



function Update()
HurtUpd()
Moving()

end

function OnHit()
Effects("curse",1)
KnifeHurt(1)
end