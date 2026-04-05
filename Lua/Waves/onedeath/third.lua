spawntime=0
Arena.Resize(100,100)
Player.MoveTo(0,0,true)
Arena.MoveTo(320,240,true,true)
old1=math.random(2)*2-3
side1=1
knife1=CreateProjectile("KnifeRightwhite",140,old1*23)
knife1.sprite.rotation=old1*90
old2=math.random(2)*2-3
side2=1
knife2=CreateProjectile("KnifeRightwhite",old2*23,140)
knife2.sprite.rotation=old2*90+90
spawntime=0
time1=-30
time2=-75
collision = require "Libraries/rotational_collision"
require "Libraries/Playermove"
require "Libraries/hurt"
weapons={knife1, knife2}



function Move1()
	time1=time1+1
	if time1<0 then
		elseif time1>0 and time1<60 then
		knife1.MoveTo(side1*140*math.cos(math.pi*time1/60),old1*23)
		elseif time1>60 and time1<91 then
		if time1==61 then
			new1=math.random(2)*2-3
			side1=-side1
		end
		local he=old1*(90-time1)/30+new1*(time1-60)/30
		knife1.MoveTo(side1*140,he*23)
		if side1==1 then
			knife1.sprite.rotation=he*90+360*(time1-60)/30
			else
			knife1.sprite.rotation=180-he*90-360*(time1-60)/30
		end
		elseif time1==91 then
		old1=new1
		time1=0
		knife1.MoveTo(side1*140,old1*23)
	end
end

function Move2()
	time2=time2+1
	if time2<0 then
		elseif time2>0 and time2<60 then
		knife2.MoveTo(old2*23,side2*140*math.cos(math.pi*time2/60))
		elseif time2>60 and time2<91 then
		if time2==61 then
			new2=math.random(2)*2-3
			side2=-side2
		end
		local he=old2*(90-time2)/30+new2*(time2-60)/30
		knife2.MoveTo(he*23,side2*140)
		if side2==1 then
			knife2.sprite.rotation=90-he*90+360*(time2-60)/30
			else
			knife2.sprite.rotation=he*90+270-360*(time2-60)/30
		end
		elseif time2==91 then
		old2=new2
		time2=0
		knife2.MoveTo(old2*23,side2*140)
	end
end

function Update()
spawntime=spawntime+1
HurtUpd()
Moving()


Move1()
Move2()


for i=1,#weapons do
	local bullet=weapons[i]
	if (Player.x+40>bullet.x and Player.x-40<bullet.x) and (Player.y+40>bullet.y and Player.y-40<bullet.y) then
		if collision.CheckCollision(Player, bullet) then
			LongHurt(20,30)
		end
	end
end
if spawntime==600 then
	Arena.ResizeImmediate(565,130)
	Arena.MoveTo(0,0,true,true)
	EndWave()
end

end


function OnHit()
end