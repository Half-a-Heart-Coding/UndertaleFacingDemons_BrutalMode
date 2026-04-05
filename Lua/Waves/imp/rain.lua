Arena.ResizeImmediate(160,80)
Player.MoveTo(0,-20)
spawntime=0
safe=0
rain={}
rain2={}
local damage=1
require "Libraries/Playermove"
require "Libraries/hurt"
local j = 1
local jGoingUp = 1
spawnTimerDelay = 45
animtimer = 0
currentframe = 0
vzmah_anim = {"chara/att1", "chara/att2", "chara/att3", "chara/att4", "chara/att5"}
blast_exist = false
vzmah_exist = false
blast2_exist = false
vzmah2_exist = false
endgame = false
sdvig = 1
require "Libraries/colortoys"
collision = require "Libraries/rotational_collision"
warning_gradient = Gradient.new({{1, 0, 0}, {1, 0.5, 0}, {1, 0, 0}}) -- красный-оранжевый-красный
warnings = {}
lasers = {}
deadtime=0
knives = {}
blasters = {}
beams = {}
links={}
beam_v = {"laser0/laserv0", "laser0/laserv1", "laser0/laserv2", "laser0/laserv3", "laser0/laserv4", "laser0/laserv5", "laser0/laserv6", "laser0/laserv7", "laser0/laserv8", "laser0/laserv9", "laser0/laserv10", "laser0/laservfade0", "laser0/laservfade1", "laser0/laservfade2", "laser0/laservfade3", "laser0/laservfade4", "laser0/laservfade5", "laser0/laservfade6", "laser0/laservfade7", "laser0/laservfade8", "laser0/laservfade9"}
hue = 0
dummies = {}
function Update()
HurtUpd(900)
Moving()
spawntime=spawntime+1
if spawntime%45==0 then
   if safe==0 then
      for i=1,4 do
		local knife=nil
		if GetGlobal("DifficultyPoints") >= 621 then
			 knife = CreateProjectile("KnifeDownFatal",-110+40*i,300)
		else
			 knife = CreateProjectile("KnifeDown",-110+40*i,300)
		end
         knife.SetVar("color","white")
         table.insert(rain,knife)
	 knife.sprite.alpha=0
	 knife.SetVar("time",0)
	 if i~=j or i==j then
	 local knife2=nil
		if GetGlobal("DifficultyPoints") >= 621 then
			 knife2 = CreateProjectile("KnifeUpFatal",-90+40*i,-100)
		else
			 knife2 = CreateProjectile("KnifeUp",-90+40*i,-100)
		end
         knife2.SetVar("color","white")
         table.insert(rain2,knife2)
		 knife2.sprite.alpha=0
		 knife2.SetVar("time",0)
		 if math.random(2) >= 1 and spawntime>=450 then
			DoWarns(-90+40*i,1)
			--DoWarns(25,1)
		end
	 end
      end
      safe=1
      else
      for i=1,4 do
         local knife=nil
		if GetGlobal("DifficultyPoints") >= 621 then
			 knife = CreateProjectile("KnifeDownFatal",-90+40*i,300)
		else
			 knife = CreateProjectile("KnifeDown",-90+40*i,300)
		end
         knife.SetVar("color","white")
         table.insert(rain,knife)
	 knife.sprite.alpha=0
	 knife.SetVar("time",0)
	 local knife2=nil
	 if i~=j or i==j then
		if GetGlobal("DifficultyPoints") >= 621 then
			 knife2 = CreateProjectile("KnifeUpFatal",-110+40*i,-100)
		else
			 knife2 = CreateProjectile("KnifeUp",-110+40*i,-100)
		end
         knife2.SetVar("color","white")
         table.insert(rain2,knife2)
		knife2.sprite.alpha=0
		knife2.SetVar("time",0)
		if math.random(2) >= 1 and spawntime>=450 then
			DoWarns(-110+40*i,1)
			--DoWarns(25,1)
		end
	 end
      end
      safe=0
	  j = j + jGoingUp
   if j > 3 then
    jGoingUp = -1
   end
   if j < 2 then
    jGoingUp = 1
   end
   end
    --for i=1,4 do
        --if i == j then
        --else
    local name=""
		if GetGlobal("DifficultyPoints") >= 621 then
			 --knife = CreateProjectile("KnifeUpFatal",-90+20*i,-100)
			 name="Fatal"
		end--else
		--knife = CreateProjectile("KnifeUp"..name,-90+20*j,-100)
		--end
    --knife.SetVar("color","white")
    --table.insert(rain2,knife)
	--knife.sprite.alpha=0
	--knife.SetVar("time",0)

        --end
     --end
end
hue = hue + 8*math.pi / 180
	if hue > math.pi * 2 then
		hue = hue - math.pi * 2
	end

	if spawntime == 299999 then
		vzmah = CreateProjectile('chara/att0', 0, 0)
		vzmah.SetVar("bulletType", "sprite")
		vzmah_exist = true
		Audio.PlaySound("slice2")
	end

	if spawntime == 309999 then
		blast = CreateProjectile('laser0/laserv0', 0, 0)
		blast_exist = true
		blast.SetVar("bulletType", "deadly")
		Audio.PlaySound("bolt")
	end

	if vzmah_exist then
		if animtimer%5 == 0 then
			currentframe = currentframe + 1
			vzmah.sprite.Set(vzmah_anim[currentframe])
		end
		if currentframe >=5 then
			vzmah_exist = false
			vzmah.Remove()
		end
	end

	if blast_exist then
		blast.sprite.alpha = blast.sprite.alpha - 0.1
		if blast.sprite.alpha < 0.3 then
			blast.SetVar("bulletType", "sprite")
		end
		if blast.sprite.alpha <= 0.1 then
			blast.Remove()
			blast_exist = false
		end
	end

	for i=1,#warnings do
		local warn = warnings[i]
		if warn.isactive then
			local lifetime = warn.GetVar("creatime")
			local ugol = warn.GetVar("angle")
			local beam_x = warn.x
			local beam_y = warn.y
			warn.sprite.color = warning_gradient:getColorAt((spawntime%30) / 30)
			if (spawntime-lifetime) > 40 then
				warn.Remove()
				if ugol == 0 then
					local laser = CreateProjectile('laser0/laserv0', beam_x, beam_y)
					laser.SetVar("bulletType", "deadly")
					table.insert(lasers, laser)
					if i>16 and i%2==0 then
						Audio.PlaySound("bolt_high")
					end
					else
					local laser = CreateProjectile('laser0/laserh0', beam_x, beam_y)
					laser.SetVar("bulletType", "deadly")
					table.insert(lasers, laser)
					if i<16 or i%2==0 then
						Audio.PlaySound("bolt_high")
					end
				end
			end
		end
	end

	for j=1,#lasers do
		local las = lasers[j]
		if las.isactive then
			las.sprite.alpha = las.sprite.alpha - 0.1
			if las.sprite.alpha < 0.1 then
				las.Remove()
			end
		end
	end
	for l=1,#blasters do
		local blaster = blasters[l]
		local napravlenie = blaster.GetVar("angle")
		local ugol = blaster.GetVar("ang")
		local rasst = blaster.GetVar("rad")
		local mesto = blaster.GetVar("shag")
		local vremya = blaster.GetVar("starttime")
		if (spawntime-vremya) < 30 then
			ugol = ugol - 1
			blaster.sprite.rotation = ugol
			blaster.SetVar("ang", ugol)
			rasst = rasst - 2
			blaster.SetVar("rad", rasst)
			local new_x = rasst * math.sin(math.pi*mesto/180)
			local new_y = rasst * math.cos(math.pi*mesto/180)
			blaster.MoveTo(new_x, new_y)
			blaster.SetVar("posx", new_x)
			blaster.SetVar("posy", new_y)
		end
		if (spawntime-vremya) > 60 and (spawntime-vremya) < 250 then
			ugol = ugol + 1
			blaster.sprite.rotation = ugol
			blaster.SetVar("ang", ugol)
			mesto = mesto - 1
			blaster.SetVar("shag", mesto)
			local new_x = rasst * math.sin(math.pi*mesto/180)
			local new_y = rasst * math.cos(math.pi*mesto/180)
			blaster.MoveTo(new_x, new_y)
			local timi=spawntime-vremya-60
			if blaster.GetVar("isActivated") == false then
				links[l]={}
				Audio.PlaySound("lasershot")
				blaster.sprite.Set("blaster2")
				blaster.SetVar("isActivated", true)
				local beamx = blaster.x + 675*math.sin(math.pi*ugol/180)
				local beamy = blaster.y - 675*math.cos(math.pi*ugol/180)
				local beam2 = CreateProjectile('laser1/laserv2', beamx, beamy)
				--beam2.sprite.SetAnimation(beam_v, 0.17)
				beam2.sprite.rotation = ugol
				beam2.sprite.alpha = 0.8
				beam2.SetVar("colorized", true)
				beam2.SetVar("hueshift", math.random(30)/10)
				beam2.SetVar("path", mesto)
				beam2.SetVar("angle", ugol)
				beam2.SetVar("dist", rasst)
				table.insert(beams, beam2)
				local beam1 = CreateProjectile('laser1/laserv0', beamx, beamy)
				--beam1.sprite.SetAnimation(beam_v, 0.17)
				beam1.sprite.rotation = ugol
				beam1.SetVar("colorized", false)
				beam1.SetVar("path", mesto)
				beam1.SetVar("angle", ugol)
				beam1.SetVar("dist", rasst)
				table.insert(beams, beam1)
				links[l]={beam1,beam2}
				local dummy_r = CreateProjectile('empty', Arena.width/2+81, 0)
				dummy_r.SetVar("speedx", -0.33)
				dummy_r.SetVar("speedy", 0)
				dummy_r.SetVar("bulletType", "beam")
				table.insert(dummies, dummy_r)
				local dummy_l = CreateProjectile('empty', -Arena.width/2-81, 0)
				dummy_l.SetVar("speedx", 0.33)
				dummy_l.SetVar("speedy", 0)
				dummy_l.SetVar("bulletType", "beam")
				table.insert(dummies, dummy_l)
				local dummy_t = CreateProjectile('empty', 0, Arena.height/2+115)
				dummy_t.SetVar("speedx", 0)
				dummy_t.SetVar("speedy", -0.27)
				dummy_t.SetVar("bulletType", "beam")
				table.insert(dummies, dummy_t)
				local dummy_b = CreateProjectile('empty', 0, -Arena.height/2-115)
				dummy_b.SetVar("speedx", 0)
				dummy_b.SetVar("speedy", 0.27)
				dummy_b.SetVar("bulletType", "beam")
				table.insert(dummies, dummy_b)
			end
			if timi<95 then
				local wid=1+1.5*math.sin(math.pi*timi/140)
				local beamy=links[l]
				beamy[1].sprite.Scale(wid,1)
				beamy[2].sprite.Scale(wid,1)
				else
				local wid=1+1.5*math.sin(math.pi*(190-timi)/140)
				local beamy=links[l]
				beamy[1].sprite.Scale(wid,1)
				beamy[2].sprite.Scale(wid,1)
			end
		end
		if (spawntime-vremya) > 90 and (spawntime-vremya) < 250 then
			rasst = rasst - 0.5
			blaster.SetVar("rad", rasst)
		end

		if (spawntime-vremya) == 251 then
			blaster.Remove()
		end
		
	end

	 if  deadtime<0 then
		--deadscreen = CreateProjectile("999999", 0,145-Arena.height/2)
		deadtime=deadtime + 1
		if deadtime == 0 then
			deadscreen.Remove()
			deadscreen = nil
		end
	 end
	if endgame then
  deadtime=deadtime+1
  Audio.Stop()
  Player.SetControlOverride(true)
  if  deadtime<60 then
     deadscreen = CreateProjectile("999999", 0,145-Arena.height/2)
     deadtime=60
     else
	deadscreen.sprite.SendToTop()
     deadscreen.MoveTo(5*math.sin(deadtime*math.pi/5),145-Arena.height/2)
  end
  if deadtime==120 then
	SetGlobal("Playerisdead",true)
	SetGlobal("charaisdead",0)
	EndWave()
	SetGlobal("nocomment",true)
  end
	end

	if spawntime%100==0 and spawntime>450 then
		--DoWarns(25,2)
		--DoWarns(25,1)
	end

for i=1,#rain do
   local knife = rain[i]
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
   if knife.isactive then
      knife.Move(0,-6)
   end
   if knife.y<-300 then
      knife.Remove()
   end
end
for i=1,#rain2 do
   local knife = rain2[i]
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
   if knife.isactive then
      knife.Move(0,4)
   end
   if knife.y>200 then
      knife.Remove()
   end
end
end

function DoWarns(ingo,side)
	if side==1 then
		--for i=0,1 do
			local x=ingo
			local warn = CreateProjectile('chara/warnline', x-2*x, 0)
			warn.sprite.rotation = 0
			warn.SetVar("bulletType", "sprite")
			warn.SetVar("angle", 0)
			warn.SetVar("creatime", spawntime)
			table.insert(warnings, warn)
		--end
		else
		for i=0,1 do
			local y=ingo
			local warn = CreateProjectile('chara/warnline', 0, y-2*y*i)
			warn.sprite.rotation = 90
			warn.SetVar("bulletType", "sprite")
			warn.SetVar("angle", 90)
			warn.SetVar("creatime", spawntime)
			table.insert(warnings, warn)
		end
	end
end
function LowerColor(ingo)
	local outgo=ingo
	for i=1,3 do
		outgo[i]=ingo[i]/4
	end
	return outgo
end

function GameOver()
	Encounter.Call("SetMusic","none")
	Player.SetControlOverride(true)
	endgame = true
	lastsecond = spawntime
end

function OnHit(attack)
if attack.GetVar("color")=="white" then
	KnifeHurt(1)
end
if attack.GetVar('bulletType') == "deadly" then
	if GetGlobal("HasExtraLife") == true then
		SetGlobal("ConfusionMode", 0)
		Player.hp = 135
		SetGlobal("diffCurseChaosTimer", 0)
		SetGlobal("curse", 0)
		SetGlobal("HasExtraLife", false)
		deadscreen = CreateProjectile("999999", 0,145-Arena.height/2)
		deadtime=-30
		deadscreen.sprite.SendToTop()
		deadscreen.MoveTo(5*math.sin(deadtime*math.pi/5),145-Arena.height/2)
		timer = 45
	else	
		if GetGlobal("KnifeProtection") == true then
			if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
				LongHurt(25,60)
			elseif Player.hp > 33 then
				LongHurt(33,60)
			else
				GameOver()
			end
		else
			GameOver()
		end
	end
		--elseif bullet.GetVar('bulletType') == "beam" then
		--KnifeHurt(4)
	end
end