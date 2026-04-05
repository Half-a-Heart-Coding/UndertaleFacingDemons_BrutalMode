spawntime=1
require "Libraries/arena"
local heart=CreateProjectile("empty",Player.x,Player.y)
heart.sprite.Set("ut-heart")
heart.sprite.alpha=0
heart.sprite.color={1,0,0}
heart.sprite.Scale(10,10)
away=100
dir=math.random(2)*2-3
function Update()
Encounter.SetVar("nextwaves",{"nothing"})
arenachange(21,21,0,away,11,11,false,true,2,2)
Player.MoveTo(0,away,true)
spawntime=spawntime+1
if spawntime<300 then
	heart.sprite.alpha=1*(spawntime)/300
	heart.MoveTo(Player.x,Player.y)
	heart.sprite.Scale(1+9*(300-spawntime)/300,1+9*(300-spawntime)/300)
	elseif spawntime<360 then
	heart.sprite.alpha=1-(spawntime-300)/60
	Player.sprite.color={1,(spawntime-300)/59,1}
	elseif spawntime==360 then
	Audio.PlaySound("tranformacion")
	elseif spawntime<371 then
	Player.sprite.color={1,1*(370-spawntime)/10,1*(370-spawntime)/10}
end
if spawntime==450 then
	EndWave()
	fakearenaend()
end

end


function OnHit(attack)
end
	