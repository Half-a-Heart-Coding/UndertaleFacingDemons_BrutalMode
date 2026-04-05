require "Libraries/Playermove"
knifes={}
k1y=0
k2y=0
awayx=0
require "Libraries/hurt"
Arena.ResizeImmediate(100,100)
collision = require "Libraries/rotational_collision"
knife1=CreateProjectile("KnifeRightwhite",-200,25)
knife1.sprite.alpha=0
knife1.sprite.rotation=270
table.insert(knifes,knife1)
knife2=CreateProjectile("KnifeRightwhite",200,-25)
knife2.sprite.alpha=0
knife2.sprite.rotation=90
table.insert(knifes,knife2)
phase=1
spawntime=0
function Update()
spawntime=spawntime+1
for i=1,#knifes do
	local bullet=knifes[i]
	if (Player.x+40>bullet.x and Player.x-40<bullet.x) and (Player.y+40>bullet.y and Player.y-40<bullet.y) then
		if collision.CheckCollision(Player, bullet) then
			LongHurt(20,30)
		end
	end
end
if phase==1 then
	if spawntime<30 then
		knife1.sprite.alpha=math.sin(math.pi*spawntime/58)
	end
	if spawntime>10 and spawntime<50 then
		knife1.MoveTo(200*math.sin(math.pi*(spawntime-30)/40),25)
	end
	if spawntime>30 and spawntime<60 then
		knife2.sprite.alpha=math.sin(math.pi*(spawntime-30)/58)
	end
	if spawntime>40 and spawntime<80 then
		knife2.MoveTo(-200*math.sin(math.pi*(spawntime-60)/40),-25)
	end
	if spawntime==80 then
		phase=2
		spawntime=0
	end
	elseif phase==2 then
	if spawntime<16 then
		knife1.MoveTo(200,25*(15-spawntime)/15)
		knife2.MoveTo(-200,-25*(15-spawntime)/15)
		elseif spawntime<95 then
		if spawntime>50 and spawntime<61 then
			k1y=42*(spawntime-50)/10
			k2y=-42*(spawntime-50)/10
		end
		knife1.MoveTo(-200*math.sin(math.pi*(spawntime-35)/40),k1y)
		knife2.MoveTo(200*math.sin(math.pi*(spawntime-35)/40),k2y)
		elseif spawntime==95 then
		spawntime=0
		phase=3
		Arena.Resize(140,140)
	end
	elseif phase==3 then
	if spawntime<26 then
		knife1.sprite.rotation=270*(25-spawntime)/25+135*spawntime/25
		knife1.MoveTo(200*(25-spawntime)/25+140*spawntime/25,42*(25-spawntime)/25+140*spawntime/25)
		knife2.sprite.rotation=90*(25-spawntime)/25+45*spawntime/25
		knife2.MoveTo(-200*(25-spawntime)/25-140*spawntime/25,-42*(25-spawntime)/25+140*spawntime/25)
		else
		phase=4
		spawntime=0
	end
	elseif phase==4 then
	if spawntime<36 then
		knife1.MoveTo(140*math.cos(math.pi*spawntime/40),140*math.cos(math.pi*spawntime/40))
		knife2.MoveTo(-140*math.cos(math.pi*spawntime/40),140*math.cos(math.pi*spawntime/40))
		if spawntime==35 then
			awayx=-knife1.x
		end
		elseif spawntime<51 then
		knife1.MoveTo(-awayx*(50-spawntime)/15,-awayx)
		knife2.MoveTo(awayx,-awayx*(50-spawntime)/15)
		knife1.sprite.rotation=135*(50-spawntime)/15+90*(spawntime-35)/15
		knife2.sprite.rotation=45*(50-spawntime)/15+180*(spawntime-35)/15
		else
		phase=5
		spawntime=0
	end
	elseif phase==5 then
	if spawntime<26 then
		knife1.MoveTo(0,-awayx*math.cos(math.pi*spawntime/25))
		knife2.MoveTo(awayx*math.cos(math.pi*spawntime/25),0)
		elseif spawntime<41 then
		knife1.sprite.rotation=90*(40-spawntime)/15
		knife2.sprite.rotation=180*(40-spawntime)/15+90*(spawntime-25)/15
		elseif spawntime<66 then
		knife1.MoveTo(0,awayx*math.cos(math.pi*(spawntime-40)/25))
		knife2.MoveTo(-awayx*math.cos(math.pi*(spawntime-40)/25),0)
		else 
		spawntime=0
		phase=6
	end
	elseif phase==6 then
	if spawntime<11 then
		knife1.MoveTo(33*spawntime/10,-awayx)
		knife2.MoveTo(awayx,-33*spawntime/10)
		elseif spawntime<36 then
		knife1.MoveTo(33,-awayx*math.cos(math.pi*(spawntime-10)/25))
		knife2.MoveTo(awayx*math.cos(math.pi*(spawntime-10)/25),-33)
		elseif spawntime<46 then
		knife1.MoveTo(33*(45-spawntime)/10-33*(spawntime-35)/10,awayx)
		knife2.MoveTo(-awayx,-33*(45-spawntime)/10+33*(spawntime-35)/10)
		elseif spawntime<58 then
		knife1.MoveTo(-33,awayx*math.cos(math.pi*(spawntime-45)/25))
		knife2.MoveTo(-awayx*math.cos(math.pi*(spawntime-45)/25),33)
		elseif spawntime<190 then
		knife1.Move(0,-10)
		knife2.Move(10,0)
		else
		EndWave()
		Encounter.SetVar("nextwaves",{"nothing"})
	end	
end
HurtUpd()
Moving()

end


function OnHit()
end