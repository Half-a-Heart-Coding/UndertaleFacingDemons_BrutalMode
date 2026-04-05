Arena.ResizeImmediate(250, 250)
spawntime = 0+60*math.random(4)
rand1=math.random(2)*2-3
rand2=math.random(2)*2-3
knifes = {}

require "Libraries/Playermove"
require "Libraries/hurt"

name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
name3="Deadly"
if GetGlobal("DifficultyPoints") >= 621 then
	name3="Fatal"
end
name4="Lethal"
if GetGlobal("DifficultyPoints") >= 621 then
	name4="Fatal"
end
name5="Fatal"
if GetGlobal("DifficultyPoints") >= 621 then
	name5="Mutant"
end

function WaveUp()
		local kx = -120
		rand1=-rand1
		local max=6
		if rand1==1 then
			max=5
			kx=kx+21
		end
		for n=0, max do
			local k=kx+n*42
			local kn = CreateProjectile('KnifeDown'..name4, k, 300)
			kn.SetVar("speed",{0,-4})
			kn.SetVar("time",0)
			table.insert(knifes, kn) 
		end 
end
function WaveDown()
		local kx = -120
		rand1=-rand1
		local max=6
		if rand1==1 then
			max=5
			kx=kx+21
		end
		for n=0, max do
			local k=kx+n*42
			local kn = CreateProjectile('KnifeUp'..name4, k, -300)
			kn.SetVar("speed",{0,4})
			kn.SetVar("time",0)
			table.insert(knifes, kn) 
		end 
end
function WaveLeft()
		local kx = -120
		local max=5
		if rand1==1 then
			max=4
			kx=kx+21
		end
		for n=0, max do
			local k=kx+n*42
			local kn = CreateProjectile('KnifeRight'..name4, -300, k)
			kn.SetVar("speed",{4,0})
			kn.SetVar("time",0)
			table.insert(knifes, kn) 
		end 
end
function WaveRight()
		local kx = -120
		local max=5
		if rand1==1 then
			max=4
			kx=kx+21
		end
		for n=0, max do
			local k=kx+n*42
			local kn = CreateProjectile('KnifeLeft'..name4, 300, k)
			kn.SetVar("speed",{-4,0})
			kn.SetVar("time",0)
			table.insert(knifes, kn) 
		end 
end
function Update()
HurtUpd(900)
spawntime = spawntime + rand2
if spawntime%40==1 and ((spawntime-1)/40)%4==0 then
	WaveUp()
	elseif spawntime%40==1 and ((spawntime-1)/40)%4==1 then
	WaveRight()
	elseif spawntime%40==1 and ((spawntime-1)/40)%4==2 then
	WaveDown()
	elseif spawntime%40==1 and ((spawntime-1)/40)%4==3 then
	WaveLeft()
end
Moving()
	
	for i=1,#knifes do
		local k=knifes[i]
		if k.isactive then
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<31 then
				k.sprite.alpha=math.sin(time*math.pi/60)
			end
			local s=k.GetVar("speed")
			local x=4/4
			k.Move(s[1]*x,s[2]*x)
			if k.x>600 or k.x<-600 or k.y>400 or k.y<-400 then
				k.Remove()
			end
		end
	end

end


function OnHit(bullet)
local color = bullet.GetVar("color")	
		KnifeHurt(3)
		Effects("curse",2)
end