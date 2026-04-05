spawntime=0
Arena.Resize(140,140)
Player.MoveTo(0,0,true)
collision = require "Libraries/rotational_collision"
require "Libraries/Playermove"
require "Libraries/hurt"
knife1=CreateProjectile("KnifeRightwhite",Player.x+100,Player.y)
knife2=CreateProjectile("KnifeRightwhite",(math.random(13)-7),200)
weapons={}
fallingknifes={}
table.insert(weapons,knife1)
table.insert(weapons,knife2)
knifepoint=Player.y
fallen=false
falltime=0
newplacex=(math.random(13)-7)*10
oldplacex=knife2.x
knife2.sprite.rotation=270

function Update()
spawntime=spawntime+1
for i=1,#weapons do
	local bullet=weapons[i]
	if (Player.x+40>bullet.x and Player.x-40<bullet.x) and (Player.y+40>bullet.y and Player.y-40<bullet.y) then
		if collision.CheckCollision(Player, bullet) then
			LongHurt(20,30)
		end
	end
end
MoreNear()
knife1.MoveTo(100*math.cos(spawntime*math.pi/80),knifepoint)
knife1.sprite.rotation=(spawntime%160)*9/4+90
HurtUpd()
Moving()
for i=1,1 do
	falltime=falltime+1
	if fallen==false then
		if falltime<41 then
			knife2.MoveTo(oldplacex*(40-falltime)/40+newplacex*falltime/40,200)
		end
		if falltime==60 then
			fallen=true
			falltime=0
		end
		else
		if falltime<21 then
			knife2.MoveTo(knife2.x,200-270*math.sin(math.pi*falltime/20))
		end
		if falltime==21 then
			falltime=0
			fallen=false
			local save=newplacex
			while (newplacex-save)<11 and (newplacex-save)>-11 do
				newplacex=(math.random(13)-7)*10
			end
			oldplacex=knife2.x
		end
	end
end
end

function MoreNear()
local delta=Player.y-knifepoint
knifepoint=knifepoint+delta*(0.01+0.03*math.cos(math.pi*delta/280))
end


function OnHit()
end