Arena.Resize(160,195)
spawntime=1
knifes={}
leftknifes={}
rightknifes={}
timer1={}
timer2={}
timer3={}
timer4={}
require "Libraries/Playermove"
require "Libraries/hurt"
napr=math.random(2)*2-3
knifesdown={}
function Update()
HurtUpd(600)
Moving()
--[[if spawntime%120==0 then
	local knife1=CreateProjectile("KnifeDown",Player.x,Player.y+200)
	knife1.sprite.alpha=0
	local knife2=CreateProjectile("KnifeUp",Player.x,Player.y-200)
	knife2.sprite.alpha=0
	table.insert(knifes,knife1)
	knife1.SetVar("y",1)
	knife1.SetVar("place",Player.y+16)
	table.insert(knifes,knife2)
	knife2.SetVar("y",-1)
	knife2.SetVar("place",Player.y-16)
end]]
if spawntime%25==0 then
	local knife=CreateProjectile("KnifeDown",-90+20*math.random(8),200)
	knife.sprite.alpha=0
	table.insert(knifesdown,knife)
end
for i=1,#knifesdown do
	local k=knifesdown[i]
	if k.isactive then
		if not timer4[i] then
			timer4[i]=1
			else timer4[i]=timer4[i]+1
		end
		if timer4[i]<20 then
			k.sprite.alpha=math.sin(timer4[i]*math.pi/40)
		end
		if timer4[i]>30 and timer4[i]<60 then
			k.Move(0,-8*math.sin((timer4[i]-30)*math.pi/60))
			elseif timer4[i]>59 then
			k.Move(0,-8)
		end
	end
end
for i=1,#knifes do
	local knife = knifes[i]
	local n=knife.GetVar("y")
	local p=knife.GetVar("place")
	if knife.isactive then
		if not timer1[i] then
			timer1[i]=1
			else timer1[i]=timer1[i]+1
		end
		if timer1[i]<31 then
			local place=p+n*184*math.cos(timer1[i]*math.pi/60)
			knife.MoveTo(knife.x,place)
		end
		if timer1[i]<16 then
			knife.sprite.alpha=math.sin(timer1[i]*math.pi/30)
		end
		if timer1[i]>30 and timer1[i]<45 then
			knife.sprite.alpha=1-math.sin((timer1[i]-30)*math.pi/30)
			if timer1[i]==35 then
				knife.SetVar("color","none")
			end
		end
		if timer1[i]==45 then
			knife.Remove()
		end	
	end
end
if spawntime%140==2 then
	napr=math.random(2)*2-3
	upi=(math.random(2)*2-3)*12.5+12.5
	elseif spawntime%140==60 then
	for i=1,4 do
		local knife=CreateProjectile("KnifeLeft",112*napr,-112.5+50*i-upi)
		knife.sprite.rotation=90-napr*90
		if napr==-1 then
			table.insert(leftknifes,knife)
			else table.insert(rightknifes,knife)
		end
		knife.sprite.alpha=0
	end
	napr=-napr
	upi=25-upi
	elseif spawntime%140==130 then
	for i=1,4 do
		local knife=CreateProjectile("KnifeLeft",112*napr,-112.5+50*i-upi)
		knife.sprite.rotation=90-napr*90
		if napr==-1 then
			table.insert(leftknifes,knife)
			else table.insert(rightknifes,knife)
		end
		knife.sprite.alpha=0
	end
end
for i=1,#leftknifes do
	local knife = leftknifes[i]
	if knife.isactive then
		if not timer2[i] then
			timer2[i]=0
			else
			timer2[i]=timer2[i]+1
		end
		if timer2[i]<30 then
			knife.sprite.alpha=math.sin(timer2[i]*math.pi/60)
		end
		if timer2[i]>40 and timer2[i]<55 then
			knife.Move(-2*math.cos((timer2[i]-40)*math.pi/30),0)
			elseif timer2[i]>60 then
			knife.Move(6,0)
		end
		if knife.x>350 then
			knife.Remove()
		end
	end
end
for i=1,#rightknifes do
	local knife = rightknifes[i]
	if knife.isactive then
		if not timer3[i] then
			timer3[i]=0
			else
			timer3[i]=timer3[i]+1
		end
		if timer3[i]<30 then
			knife.sprite.alpha=math.sin(timer3[i]*math.pi/60)
		end
		if timer3[i]>40 and timer3[i]<55 then
			knife.Move(2*math.cos((timer3[i]-40)*math.pi/30),0)
			elseif timer3[i]>60 then
			knife.Move(-6,0)
		end
		if knife.x<-350 then
			knife.Remove()
		end
	end
end
spawntime=spawntime+1
if spawntime==600 then
	EndWave()
end
end
function OnHit(k)
	if not  k.GetVar("color") then
		KnifeHurt(1)
		Effects("curse",1)
		elseif k.GetVar("color")=="none" then
	end
end