spawntime=1
require "Libraries/arena"
require "Libraries/hurt"
knifessides={}
kniferand={}
knifeup={}
timer5={}
away=50
dir=math.random(2)*2-3
function Update()
HurtUpd(9999)
arenachange(100,100,0,away,11,11,false,true)
spawntime=spawntime+1
if spawntime<470 then
	if spawntime%30==0 then
		local knife=CreateProjectile("KnifeLeft",dir*300,-10+20*math.random(5))
		knife.sprite.rotation=90-90*dir
		table.insert(kniferand,knife)
		knife.SetVar("color","Knife")
		dir=-dir
	end
end
if spawntime<350 and spawntime%70==0 then
	rand1=math.random(5)+1
	for i=1,6 do
		if i==rand1 or i+1==rand1 then
			else local knife=CreateProjectile("KnifeDown",-59+18*i,353)
			knife.SetVar("color","Knife")
			table.insert(knifeup,knife)
		end
	end
end
for i=1,#knifeup do
	if not timer5[i] then
		timer5[i]=0
		else timer5[i]=timer5[i]+1
	end
	local knife=knifeup[i]
	if knife.isactive and timer5[i]>24 then
		knife.move(0,-6)
		if knife.y<-32 then
			knife.Remove()
		end
	end
end
for i=1,#kniferand do
	local knife=kniferand[i]
	if knife.isactive then
		knife.move(-6*math.cos(knife.sprite.rotation*math.pi/180),0)
		if knife.x>301 or knife.x<-301 then
			knife.Remove()
		end
		if spawntime==470 and knife.isactive then
			knife.Remove()
		end
	end
end
if spawntime==390 then
	rand1=math.random(4)+1
	for i=1,5 do
		if i==rand1 or i+1==rand1 then
			word="Blue"
			else word=""
		end
		local knife1=CreateProjectile("KnifeLeft"..word,82,395-20*i)
		local knife2=CreateProjectile("KnifeLeft"..word,-82,395-20*i)
		knife2.sprite.rotation=180
		table.insert(knifessides,knife1)
		table.insert(knifessides,knife2)
		knife1.SetVar("color","Knife"..word)
		knife2.SetVar("color","Knife"..word)
	end
end
if spawntime==410 then
	rand1=math.random(5)+1
	for i=1,6 do
		if i==rand1 or i+1==rand1 then
			else local knife=CreateProjectile("KnifeDownLong",-59+18*i,335)
			knife.SetVar("color","Knife")
		end
	end
end
if spawntime>470 and away<335 then
	if away==50 then
		Audio.PlaySound("reflect")
	end
	away=away+7.5
	if away==335 then
		Audio.PlaySound("slam")
		timer=0
	end
end
if not timer then
	else timer=timer+1
	if timer==13 then
		timer=false
	end
end
if spawntime==580 then
	EndWave()
	fakearenaend()
end
for i=1,#knifessides do
	local knife=knifessides[i]
	local rot = knife.sprite.rotation
	if not timer then
		else knife.Move(-6*math.cos(rot*math.pi/180),0)
		knife.sprite.SendToTop()
	end
end	
end
function OnHit(attack)
	local color = attack.GetVar("color")
	if color=="KnifeBlue" and ((Input.Down>0 and Player.y>arenadown()) or (Input.Up>0 and Player.y<arenaup()) or (Input.Left>0 and Player.x>arenaleft()) or (Input.Right>0 and Player.x>arenaright())) then
		Effects("curse",1)
		KnifeHurt(1)
		elseif color=="Knife" then
		Effects("curse",1)
		KnifeHurt(1)
	end
end
	