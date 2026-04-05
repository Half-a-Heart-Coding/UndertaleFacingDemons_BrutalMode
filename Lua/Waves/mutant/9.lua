require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
spawntime2=0
shadows={}
left={}
local curse=false
if Encounter.GetVar("IsCursed")==true then
	curse=true
end
shad_anim={{1, 0, 0}, {0.5, 0, 0},{0,0,0},{0.5,0,0}}
Arena.ResizeImmediate(120,120)
for i=1,200 do
	left[i]=CreateProjectile("empty",0,0)
	left[i].SetVar("color",none)
	left[i].SetVar("togo",false)
end
num=1

function SendShadow(name, position, speed2, istrue)
	local knife=CreateProjectile("Knife"..name.."Mutant",position[1],position[2],"Top")
	knife.SetVar("speed",speed2)
	knife.SetVar("name","Shadow"..name.."Fatal")
	knife.SetVar("time",0)
	knife.sprite.alpha=0
	knife.SetVar("istrue",istrue)
	knife.SetVar("color","mutant")
	table.insert(shadows,knife)
	time=0
end
		
speed=-1
WasRed=false
knifes={}
collision = require "Libraries/rotational_collision"
Player.hp=135

function RedKnifes()
	local k=CreateProjectile("KnifeDownMutant",0,100)
	k.sprite.alpha=0
	k.SetVar("time",0)
	k.SetVar("speed",{0,-6})
	k.SetVar("color","knife")
	table.insert(knifes,k)
	k=CreateProjectile("KnifeRightMutant",-100,0)
	k.sprite.alpha=0
	k.SetVar("time",0)
	k.SetVar("speed",{6,0})
	k.SetVar("color","knife")
	table.insert(knifes,k)
	k=CreateProjectile("KnifeUpMutant",0,-100)
	k.sprite.alpha=0
	k.SetVar("time",0)
	k.SetVar("speed",{0,6})
	k.SetVar("color","knife")
	table.insert(knifes,k)
	k=CreateProjectile("KnifeLeftMutant",100,0)
	k.sprite.alpha=0
	k.SetVar("time",0)
	k.SetVar("speed",{-6,0})
	k.SetVar("color","knife")
	table.insert(knifes,k)
end

function BlueKnifes()
	local s=6*math.sin(1*math.pi/4)
	local k=CreateProjectile("KnifeLeftblueFatal",70,70)
	--k.sprite.color={0/255, 168/255, 242/255}
	k.sprite.alpha=0
	k.sprite.rotation=-45
	k.SetVar("time",0)
	k.SetVar("color","blue")
	k.SetVar("speed",{-s,-s})
	table.insert(knifes,k)
	k=CreateProjectile("KnifeLeftblueFatal",70,-70)
	--k.sprite.color={0/255, 168/255, 242/255}
	k.sprite.alpha=0
	k.sprite.rotation=-135
	k.SetVar("time",0)
	k.SetVar("color","blue")
	k.SetVar("speed",{-s,s})
	table.insert(knifes,k)
	k=CreateProjectile("KnifeLeftblueFatal",-70,-70)
	--k.sprite.color={0/255, 168/255, 242/255}
	k.sprite.alpha=0
	k.sprite.rotation=135
	k.SetVar("time",0)
	k.SetVar("color","blue")
	k.SetVar("speed",{s,s})
	table.insert(knifes,k)
	k=CreateProjectile("KnifeLeftblueFatal",-70,70)
	--k.sprite.color={0/255, 168/255, 242/255}
	k.sprite.alpha=0
	k.sprite.rotation=45
	k.SetVar("time",0)
	k.SetVar("color","blue")
	k.SetVar("speed",{s,-s})
	table.insert(knifes,k)
end

function Update()
HurtUpd(1200)
Moving()
spawntime2=spawntime2+1
if spawntime2%80==40 then
	local rand=math.random(2)
	if rand1==1 then
		rand2=rand2+1
		elseif rand1==2 then
		if rand2==2 then
			rand2=rand2+1
		end
	end
	for i=1,2 do
		local x=-72+48*i
		local s=false
		if i==rand then
			s=true
		end
		SendShadow("Down",{x,310},{0,-4},s)
	end
	elseif spawntime2%80==0 then
	for i=1,3 do
		local x=-96+48*i
		local s=false
		SendShadow("Down",{x,310},{0,-4},s)
	end
	speed=speed+1
	WasRed=true
	if speed==13 then
		speed=12
	end
	RedKnifes()
	--elseif spawntime>90 and WasRed==true then
	BlueKnifes()
	WasRed=false
end
for i=1,#shadows do
	local s=shadows[i]
	if s.isactive then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		local speed=s.GetVar("speed")
		s.Move(speed[1],speed[2])
		if time<21 then
			s.sprite.alpha=math.sin(time*math.pi/40)
			elseif (time-31)%7==0 and s.GetVar("istrue")==true then
			left[num].sprite.Set(s.GetVar("name"))
			left[num].MoveTo(s.x,s.y)
			left[num].SetVar("time",0)
			left[num].SetVar("color","knife")
			left[num].SetVar("togo",true)
			num=num+1
			if num==201 then
				num=1
			end
		end
		local k=s
		if (Player.x+34>k.x and Player.x-34<k.x) and (Player.y+34>k.y and Player.y-34<k.y) then
			if k.GetVar("color")=="knife" or (k.GetVar("color")=="blue" and isMoving() ) then
				if collision.CheckCollision(Player,k) then
					LongHurt(33,30)
					--Effects("curse",1)
				end
			end
			if k.GetVar("color")=="mutant" then
				if collision.CheckCollision(Player,k) then
					KnifeHurt(999999)
					--Effects("curse",1)
				end
			end
		end
		if s.x>400 or s.x<-400 or s.y<-300 then
			s.Remove()
		end
	end
end

for i=1,#left do
	local s=left[i]
	if s.GetVar("togo")==true then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		if time<41 then
			local sin=0.75*math.cos(time*math.pi/80)
			s.sprite.color={1,1,1}
			s.sprite.alpha=sin
			if time==30 then
				s.SetVar("color","none")
			end
			else
			s.SetVar("togo",false)
		end
		local k=s
		if (Player.x+34>k.x and Player.x-34<k.x) and (Player.y+34>k.y and Player.y-34<k.y) then
			--if k.GetVar("color")=="knife" or (k.GetVar("color")=="blue" and isMoving() ) then
				if collision.CheckCollision(Player,k) then
					LongHurt(33,30)
					--Effects("curse",1)
				end
			--end
			if k.GetVar("color")=="mutant" then
				if collision.CheckCollision(Player,k) then
					KnifeHurt(999999)
					--Effects("curse",1)
				end
			end
		end
	end
end

spawntime=spawntime+1--+0.5*(1-math.cos(speed*math.pi/24))
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1--+2*math.sin(speed*math.pi/24)
		k.SetVar("time",time)
		local sp=k.GetVar("speed")
		if time<40 then
			elseif time<75 then		
			local sin=math.sin((time-40)*math.pi/65)
			k.Move(sp[1]*sin,sp[2]*sin)
			else		
			k.Move(sp[1],sp[2])
		end
		if time<41 then	
			k.sprite.alpha=math.sin(time*math.pi/65)
		end
		if (Player.x+34>k.x and Player.x-34<k.x) and (Player.y+34>k.y and Player.y-34<k.y) then
			if k.GetVar("color")=="knife" or (k.GetVar("color")=="blue" and isMoving() ) then
				if collision.CheckCollision(Player,k) then
					--KnifeHurt(1)
					LongHurt(33,30)
					--Effects("curse",1)
				end
			end
			if k.GetVar("color")=="mutant" then
				if collision.CheckCollision(Player,k) then
					KnifeHurt(999999)
					--Effects("curse",1)
				end
			end
		end
		if k.x>600 or k.x<-600 or k.y>400 or k.y<-400 then
			k.Remove()
		end
	end
end


end

function OnHit(ingo)

end