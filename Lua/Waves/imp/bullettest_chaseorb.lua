collision = require "Libraries/rotational_collision"
Arena.Resize(165, 140)
name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
chasingbullet = CreateProjectile('KnifeDown'..name2, Arena.width/2, Arena.height/2)
chasingbullet.SetVar('xspeed', 0)
chasingbullet.SetVar('yspeed', 0)
chasingbullet.SetVar("color","knife")
angle = 0
bones = {}
spawntimer = 0
attacktimer = 0
animtimer = 0
currentframe = 0
vzmah_anim = {"chara/att1", "chara/att2", "chara/att3", "chara/att4", "chara/att5"}
blast_exist = false
vzmah_exist = false
endgame = false
sdvig = 1
require "Libraries/colortoys"
warning_gradient = Gradient.new({{1, 0, 0}, {1, 0.35, 0}, {1, 0, 0}}) -- красный-оранжевый-красный
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
require "Libraries/Playermove"
require "Libraries/hurt"

DoGhost("Paps_Sprite",1,600)

--Player.hp=135

function CreateBones()
	bonetop = CreateProjectile('bone', Arena.width/2, Arena.height/2-8)
	bonetop.SetVar('xspeed', -1)
	bonetop.SetVar('yspeed', 0)
	bonetop.SetVar("color","bone")
	table.insert(bones, bonetop)

	bonedown = CreateProjectile('bone', -Arena.width/2, -Arena.height/2+8)
	bonedown.SetVar('xspeed', 1)
	bonedown.SetVar('yspeed', 0)
	bonedown.SetVar("color","bone")
	table.insert(bones, bonedown)

	boneright = CreateProjectile('bone', Arena.width/2-8, -Arena.height/2)
	boneright.sprite.rotation = 90
	boneright.SetVar('xspeed', 0)
	boneright.SetVar('yspeed', 1)
	boneright.SetVar("color","bone")
	table.insert(bones, boneright)
	
	boneleft = CreateProjectile('bone', -Arena.width/2+8, Arena.height/2)
	boneleft.sprite.rotation = 90
	boneleft.SetVar('xspeed', 0)
	boneleft.SetVar('yspeed', -1)
	boneleft.SetVar("color","bone")
	table.insert(bones, boneleft)

end




function Update()
HurtUpd(900)
Moving()
	spawntimer = spawntimer+1

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

	if(spawntimer % 10 == 0) then
		if spawntimer > 60 then
			CreateBones()
		end
	end

	local xdifference = Player.x - chasingbullet.x
	local ydifference = Player.y - chasingbullet.y
	local xspeed = chasingbullet.GetVar('xspeed') / 2 + xdifference / 85
	local yspeed = chasingbullet.GetVar('yspeed') / 2 + ydifference / 85
	local dist = math.sqrt(xdifference*xdifference + ydifference*ydifference)
	if Player.y < chasingbullet.y then
		angle = math.asin(xdifference/dist)*180/math.pi
	else
		angle = 180 - math.asin(xdifference/dist)*180/math.pi
	end
	chasingbullet.sprite.rotation = angle
	chasingbullet.Move(xspeed, yspeed)
	chasingbullet.SetVar('xspeed', xspeed)
	chasingbullet.SetVar('yspeed', yspeed)
	if collision.CheckCollision(Player, chasingbullet) then
		KnifeHurt(1)
	end


	for i=1,#bones do
		local bone = bones[i]
		local velx = bone.GetVar('xspeed')
		local vely = bone.GetVar('yspeed')
		bone.Move(velx, vely)
		if bone.x > Arena.width/2 or bone.x < -Arena.width/2 or bone.y > Arena.height/2 or bone.y < -Arena.height/2 then
			bone.sprite.alpha = 0
			--table.remove(bones, bone)
		end
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
			warn.sprite.color = warning_gradient:getColorAt((attacktimer%30) / 30)
			if (attacktimer-lifetime) > 40 then
				warn.Remove()
				if ugol == 0 then
					local laser = CreateProjectile('laser0/laserv0', beam_x, beam_y)
					laser.SetVar("bulletType", "deadly")
					table.insert(lasers, laser)
					--if i>16 and i%2==0 then
						Audio.PlaySound("bolt_high")
					--end
					else
					local laser = CreateProjectile('laser0/laserh0', beam_x, beam_y)
					laser.SetVar("bulletType", "deadly")
					table.insert(lasers, laser)
					--if i<16 or i%2==0 then
						Audio.PlaySound("bolt_high")
					--end
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

	if attacktimer%270 == 0 then
		DoWarns(0,1)
		--DoWarns(0,2)
	elseif attacktimer%270 == 135 then
		--DoWarns(0,1)
		DoWarns(0,2)
	end

	--if attacktimer%240 == 0 and attacktimer>800 then
	--	DoWarns(45,2)
		--DoWarns(0,2)
	--elseif attacktimer%240 == 120 and attacktimer>800 then
		--DoWarns(0,1)
	--	DoWarns(45,1)
	--end

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
			--Audio.PlaySound("lasershot")
			if blaster.GetVar("isActivated") == false then
				links[l]={}
				--Audio.PlaySound("lasershot")
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
				dummy_r.SetVar("bulletType", "deadly")
				table.insert(dummies, dummy_r)
				local dummy_l = CreateProjectile('empty', -Arena.width/2-81, 0)
				dummy_l.SetVar("speedx", 0.33)
				dummy_l.SetVar("speedy", 0)
				dummy_l.SetVar("bulletType", "deadly")
				table.insert(dummies, dummy_l)
				local dummy_t = CreateProjectile('empty', 0, Arena.height/2+115)
				dummy_t.SetVar("speedx", 0)
				dummy_t.SetVar("speedy", -0.27)
				dummy_t.SetVar("bulletType", "deadly")
				table.insert(dummies, dummy_t)
				local dummy_b = CreateProjectile('empty', 0, -Arena.height/2-115)
				dummy_b.SetVar("speedx", 0)
				dummy_b.SetVar("speedy", 0.27)
				dummy_b.SetVar("bulletType", "deadly")
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

function GameOver()
	Encounter.Call("SetMusic","none")
	Player.SetControlOverride(true)
	endgame = true
	lastsecond = attacktimer
end

function OnHit(b)
	if b.GetVar("color")=="bone" then
		LongHurt(10,90)
	end
	if b.GetVar("bulletType") == "deadly" then
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