-- Колоризация не влияет на сбой.
-- Анимация не влияет, суть именно в лазерах, остальные атаки отключены. В конце атаки массивы подчищаются, не влияют.
Arena.ResizeImmediate(155,130)
require "Libraries/Playermove"
require "Libraries/hurt"
Player.SetControlOverride(true)
attacktimer = 0
animtimer = 0
currentframe = 0
vzmah_anim = {"chara/att1", "chara/att2", "chara/att3", "chara/att4", "chara/att5"}
blast_exist = false
vzmah_exist = false
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
HurtUpd()
Moving()
	if endgame==false then
		attacktimer = attacktimer + 1
		animtimer = animtimer + 1
		else
		attacktimer=1
		animtimer=1
	end

	hue = hue + 8*math.pi / 180
	if hue > math.pi * 2 then
		hue = hue - math.pi * 2
	end

	if attacktimer == 2 then
		vzmah = CreateProjectile('chara/att0', 0, 0)
		vzmah.SetVar("bulletType", "sprite")
		vzmah_exist = true
		Audio.PlaySound("slice2")
	end

	if attacktimer == 30 then
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

	if attacktimer > 55 and attacktimer < 100 and endgame == false then
		if attacktimer%10 == 0 then
			local warn1v = CreateProjectile('chara/warnline', attacktimer-50, attacktimer-50)
			warn1v.sprite.rotation = 0
			warn1v.SetVar("bulletType", "sprite")
			warn1v.SetVar("angle", 0)
			warn1v.SetVar("creatime", attacktimer)
			table.insert(warnings, warn1v)

			local warn1h = CreateProjectile('chara/warnline', attacktimer-50, attacktimer-50)
			warn1h.sprite.rotation = 90
			warn1h.SetVar("bulletType", "sprite")
			warn1h.SetVar("angle", 90)
			warn1h.SetVar("creatime", attacktimer)
			table.insert(warnings, warn1h)

			local warn2v = CreateProjectile('chara/warnline', -attacktimer+50, -attacktimer+50)
			warn2v.sprite.rotation = 0
			warn2v.SetVar("bulletType", "sprite")
			warn2v.SetVar("angle", 0)
			warn2v.SetVar("creatime", attacktimer)
			table.insert(warnings, warn2v)

			local warn2h = CreateProjectile('chara/warnline', -attacktimer+50, -attacktimer+50)
			warn2h.sprite.rotation = 90
			warn2h.SetVar("bulletType", "sprite")
			warn2h.SetVar("angle", 90)
			warn2h.SetVar("creatime", attacktimer)
			table.insert(warnings, warn2h)

			--Audio.PlaySound("lasershot")
		end
	end

	for i=1,#warnings do
		local warn = warnings[i]
		if warn.isactive then
			local lifetime = warn.GetVar("creatime")
			local ugol = warn.GetVar("angle")
			local beam_x = warn.x
			local beam_y = warn.y
			warn.sprite.color = warning_gradient:getColorAt((attacktimer%30) / 30)
			if (attacktimer-lifetime) > 40 then
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

	if attacktimer == 90 and endgame == false then
			local knife_ru = CreateProjectileAbs('vert_knife', 630, 470)
			knife_ru.sprite.rotation = -10
			knife_ru.SetVar("bulletType", "knife")
			knife_ru.SetVar("angle", -10)
			table.insert(knives, knife_ru)

			local knife_rb = CreateProjectileAbs('vert_knife', 650, 10)
			knife_rb.sprite.rotation = 192
			knife_rb.SetVar("bulletType", "knife")
			knife_rb.SetVar("angle", 192)
			table.insert(knives, knife_rb)

			local knife_lb = CreateProjectileAbs('vert_knife', 40, 10)
			knife_lb.sprite.rotation = 170
			knife_lb.SetVar("bulletType", "knife")
			knife_lb.SetVar("angle", 170)
			table.insert(knives, knife_lb)

			local knife_lu = CreateProjectileAbs('vert_knife', 20, 470)
			knife_lu.sprite.rotation = 15
			knife_lu.SetVar("bulletType", "knife")
			knife_lu.SetVar("angle", 15)
			table.insert(knives, knife_lu)
	end

	for k=1,#knives do
		local knife = knives[k]
		local napravlenie = knife.GetVar("angle")
		local move_x = 11*math.sin(math.pi*napravlenie/180)
		local move_y = -11*math.cos(math.pi*napravlenie/180)
		if (Player.x+34>knife.x and Player.x-34<knife.x) and (Player.y+34>knife.y and Player.y-34<knife.y) then
			if collision.CheckCollision(Player,knife) then
				KnifeHurt(1)
			end
		end
		knife.Move(move_x, move_y)
		if knife.absy > 480 or knife.absy < 0 then
			local new_y = (3*knife.absy+240)/4
			knife.MoveToAbs(knife.absx, new_y)
			napravlenie = 180-napravlenie
			knife.sprite.rotation = napravlenie
			knife.SetVar("angle", napravlenie)
		end
	end

	if attacktimer==260 then
		DoWarns(65,1)
		DoWarns(60,2)
		elseif attacktimer==270 then
		DoWarns(54,1)
		DoWarns(50,2)
		elseif attacktimer==280 then
		DoWarns(42,1)
		DoWarns(40,2)
		elseif attacktimer==290 then
		DoWarns(30,1)
		DoWarns(30,2)
	end
	for l=1,#blasters do
		local blaster = blasters[l]
		local napravlenie = blaster.GetVar("angle")
		local ugol = blaster.GetVar("ang")
		local rasst = blaster.GetVar("rad")
		local mesto = blaster.GetVar("shag")
		local vremya = blaster.GetVar("starttime")
		if (attacktimer-vremya) < 30 then
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
		if (attacktimer-vremya) > 60 and (attacktimer-vremya) < 250 then
			ugol = ugol + 1
			blaster.sprite.rotation = ugol
			blaster.SetVar("ang", ugol)
			mesto = mesto - 1
			blaster.SetVar("shag", mesto)
			local new_x = rasst * math.sin(math.pi*mesto/180)
			local new_y = rasst * math.cos(math.pi*mesto/180)
			blaster.MoveTo(new_x, new_y)
			local timi=attacktimer-vremya-60
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
		if (attacktimer-vremya) > 90 and (attacktimer-vremya) < 250 then
			rasst = rasst - 0.5
			blaster.SetVar("rad", rasst)
		end

		if (attacktimer-vremya) == 251 then
			blaster.Remove()
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

	if attacktimer == 440 then
 		table.remove(warnings)
		table.remove(lasers)
		table.remove(knives)
		table.remove(blasters)
		table.remove(beams)
		table.remove(dummies)
		EndWave()
	end
end

function DoWarns(ingo,side)
	if side==1 then
		for i=0,1 do
			local x=ingo
			local warn = CreateProjectile('chara/warnline', x-2*x*i, 0)
			warn.sprite.rotation = 0
			warn.SetVar("bulletType", "sprite")
			warn.SetVar("angle", 0)
			warn.SetVar("creatime", attacktimer)
			table.insert(warnings, warn)
		end
		else
		for i=0,1 do
			local y=ingo
			local warn = CreateProjectile('chara/warnline', 0, y-2*y*i)
			warn.sprite.rotation = 90
			warn.SetVar("bulletType", "sprite")
			warn.SetVar("angle", 90)
			warn.SetVar("creatime", attacktimer)
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
	lastsecond = attacktimer
end

function OnHit(bullet)
	if bullet.GetVar('bulletType') == "deadly" then
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
		--elseif bullet.GetVar('bulletType') == "beam" then
		--KnifeHurt(4)
	end
end