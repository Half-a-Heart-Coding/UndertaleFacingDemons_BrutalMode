Arena.ResizeImmediate(125,125)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}
amm=1
sides={}
Player.MoveTo(0,0,true)
rotated=0
name=""
if GetGlobal("DifficultyPoints") >= 621 then
	name="Fatal"
end
Player.SetControlOverride(true)
attacktimer = 0
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
blasters = {}
beams = {}
links={}
beam_v = {"laser0/laserv0", "laser0/laserv1", "laser0/laserv2", "laser0/laserv3", "laser0/laserv4", "laser0/laserv5", "laser0/laserv6", "laser0/laserv7", "laser0/laserv8", "laser0/laserv9", "laser0/laserv10", "laser0/laservfade0", "laser0/laservfade1", "laser0/laservfade2", "laser0/laservfade3", "laser0/laservfade4", "laser0/laservfade5", "laser0/laservfade6", "laser0/laservfade7", "laser0/laservfade8", "laser0/laservfade9"}
hue = 0
dummies = {}

function DoRow(side)
	local rand=math.random(5)-3
	for i=-2,2 do
		local x=25*i
		local y=160
		local knife
		local bonusWait = 0
		if side == 1 or side == 3 then
			bonusWait = 30
		end
		if side==1 then
			knife=CreateProjectile("KnifeDown"..name,x,y)
			knife.SetVar("speed",{0,-1})
			elseif side==2 then
			knife=CreateProjectile("KnifeRight"..name,-y,x)
			knife.SetVar("speed",{1,0})
			elseif side==3 then
			knife=CreateProjectile("KnifeUp"..name,x,-y)
			knife.SetVar("speed",{0,1})
			elseif side==4 then
			knife=CreateProjectile("KnifeLeft"..name,y,x)
			knife.SetVar("speed",{-1,0})
		end
		if rand==i then
			knife.SetVar("time",0-bonusWait)
			knife.SetVar("first",1)
			knife.SetVar("stime",0+bonusWait)
			else
			knife.SetVar("time",-30-bonusWait)
			knife.SetVar("first",0)
			knife.SetVar("stime",30+bonusWait)
		end
		knife.SetVar("firing",false)
		knife.sprite.alpha=0
		table.insert(knifes,knife)
	end
end
function Update()
HurtUpd(1000)
Moving()
spawntime=spawntime+1

if spawntime==30 then
	DoRow(1)
	--elseif spawntime==90 then
	--	DoWarns(Player.x,1)
	--	DoWarns(Player.y,2)
	elseif spawntime==60 then
	DoRow(2)
	--elseif spawntime==180 then
	--	DoWarns(Player.x,1)
	--	DoWarns(Player.y,2)
	elseif spawntime==150 then
	DoRow(3)
	--elseif spawntime==270 then
	--	DoWarns(Player.x,1)
	--	DoWarns(Player.y,2)
	elseif spawntime==180 then
	DoRow(4)
	--elseif spawntime==360 then
	--	DoWarns(Player.x,1)
	--	DoWarns(Player.y,2)
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		local st=k.GetVar("stime")
		k.SetVar("time",time)
		local s=k.GetVar("speed")
		if time>0 and time<31 then
			local sin=3*math.cos(time*math.pi/60)
			k.Move(s[1]*sin,s[2]*sin)
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
		if time+st>300 then
			if time+st<360 then
				local sin=1.5*math.cos(((time+st)-300)*math.pi/120)
				k.Move(-s[1]*sin,-s[2]*sin)
				elseif time>580 and k.GetVar("first") ~= 1 then
				k.Move(s[1]*-8,s[2]*-8)
				elseif time>360 then
				k.Move(s[1]*5,s[2]*5)
			end
		end
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
	KnifeHurt(1)
end