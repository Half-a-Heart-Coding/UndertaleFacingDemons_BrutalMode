timer = 0
hue = 0
Arena.Resize(160, 160)


blasters={}
dummies1 = {}
dummies2 = {}
stars = {}

h_alt = 0
v_alt = 0
cross = false

stardx = 0
stardy = 0
star_exist = false

require "Libraries/colortoys"
require "Libraries/Playermove"
require "Libraries/hurt"

DoGhost("Asriel_Sprite",1,600)

blasters_exist = false
blast1 = 9999
collision = require "Libraries/rotational_collision"


function CreateBlasters()
	blasters_exist = true
	local away=math.random(201)-101
	blaster1 = CreateProjectile("blaster",Player.x+ h_alt * 200 , Player.y)
	blaster1.sprite.rotation = -90 * h_alt
	blaster1.sprite.alpha=0
	blaster1.SetVar("time", 0)
	blaster1.SetVar("rotatepoint",{Player.x,Player.y})
	blaster1.SetVar("rot",1-h_alt)
	table.insert(blasters,blaster1)

	blaster2 = CreateProjectile("blaster", Player.x,Player.y + v_alt * 200)
	blaster2.sprite.rotation = 90 - 90 * v_alt
	blaster2.SetVar("time", 0)
	blaster2.sprite.alpha=0
	blaster2.SetVar("rotatepoint",{Player.x,Player.y})
	blaster2.SetVar("rot",2-v_alt)
	
	table.insert(blasters,blaster2)

	Audio.PlaySound("sfx_BlasterEntry")
end

function CreateCrossBlasters()
	blasters_exist = true
	local first=math.random(4)-0.5
	
	local x=Player.x+200*math.cos(first*math.pi/2)
	local y=Player.y+200*math.sin(first*math.pi/2)
	
	blaster1 = CreateProjectile("blaster", x, y)
	blaster1.sprite.rotation = -90+first*90
	blaster1.sprite.alpha=0
	blaster1.SetVar("rot",first)
	blaster1.SetVar("time", 0)
	blaster1.SetVar("rotatepoint",{Player.x,Player.y})
	table.insert(blasters,blaster1)

	x=Player.x+200*math.cos((first+1)*math.pi/2)
	y=Player.y+200*math.sin((first+1)*math.pi/2)

	blaster2 = CreateProjectile("blaster", x, y)
	blaster2.sprite.rotation = -90+first*90+90
	blaster2.sprite.alpha=0
	blaster2.SetVar("rot",first+1)
	blaster2.SetVar("time", 0)
	blaster2.SetVar("rotatepoint",{Player.x,Player.y})
	table.insert(blasters,blaster2)

	Audio.PlaySound("sfx_BlasterEntry")
end

function Update()
HurtUpd(610)
Moving()
	timer = timer + 1
	hue = hue + 6*math.pi / 180
	if hue > math.pi * 2 then
		hue = hue - math.pi * 2
	end

	if (timer+30)%80 == 0 then
		h_alt = math.random(2)*2-3 -- подозреваю, что есть способ поизящнее, ноооо.....
		v_alt = math.random(2)*2-3 -- говнокооод, говнокооооод, на вид как говно, а на деле он код
		if math.random(2) == 2 then
			CreateBlasters()
			else
			CreateCrossBlasters()
		end
	end


	if timer == 240 then
		bigstar = CreateProjectile("b_star", math.random(241)-121, 330)
		bigstar.SetVar("firstpoint",{bigstar.x,300})
		elseif timer>240 then
		if timer<300 then
			local new=(timer-240)/60
			local old=1-new
			bigstar.sprite.color=color_multiply(hsv_to_rgb(hue, 1.0, 0.70), 1.0)
			local pos=bigstar.GetVar("firstpoint")
			bigstar.sprite.rotation=bigstar.sprite.rotation+3
			bigstar.MoveTo(old*pos[1],old*330+new*(Arena.height/2+5+bigstar.sprite.height/2))
			elseif timer==300 then
			bigstar.Remove()
			stars={}
			randomangle=math.random(36)
			for i=1,6 do
				stars[i]=CreateProjectile("m_star",0,101)
				stars[i].sprite.color=color_multiply(hsv_to_rgb(hue, 1.0, 0.70), 1.0)
				stars[i].sprite.rotation=math.random(360)
				stars[i].SetVar("rot",math.random(2)*2-3)
			end
			elseif timer<451 then
			local away=300*math.sin((timer-300)*math.pi/300)
			for i=1,6 do
				local angle=(360/#stars)*i+(timer-300)*2+randomangle
				stars[i].MoveTo(away*math.cos(angle*math.pi/180),101+away*math.sin(angle*math.pi/180))
				stars[i].sprite.rotation=stars[i].sprite.rotation+5*stars[i].GetVar("rot")
				local px=Player.x
				local py=Player.y
				local x=stars[i].x
				local y=stars[i].y
				if timer>390 then
					stars[i].sprite.alpha=math.cos((timer-360)*math.pi/120)
				end
				if px+14>x and px-14<x and py+14>y and py-14<y and stars[i].sprite.alpha>0.5 then
					LongHurt(10,30)
				end
				if timer==450 then
					stars[i].Remove()
				end
			end
		end
	end

	for i=1,#blasters do
		local blaster=blasters[i]
		if blaster.isactive then
			local time=blaster.GetVar("time")+1
			blaster.SetVar("time",time)
			local angle=blaster.GetVar("rot")*90	
			local position=blaster.GetVar("rotatepoint")
			if time<60 then
				blaster.sprite.alpha=math.sin(time*math.pi/120)
				local away=200-60*math.sin(time*math.pi/120)
				blaster.MoveTo(position[1]+away*math.cos(angle*math.pi/180),position[2]+away*math.sin(angle*math.pi/180))
				blaster.SetVar("oldpos",{blaster.x,blaster.y})
				elseif time<91 then
				if time%1==0 then
					local pos=blaster.GetVar("oldpos")
					local away=0
					if time<80 then
						away=3*math.sin(time*math.pi/4)
						else
						away=3*math.sin(time*math.pi/2)
					end
					blaster.MoveTo(pos[1]+away*math.cos((angle+90)*math.pi/180),pos[2]+away*math.sin((angle+90)*math.pi/180))
				end
				elseif time<121 then
				if time==91 then
					local ang=blaster.sprite.rotation
					local laser=CreateProjectile("laser1/laserv3",blaster.x+650*math.sin(ang*math.pi/180),blaster.y-650*math.cos(ang*math.pi/180))
					laser.sprite.rotation=ang
					local beam=CreateProjectile("laser1/laserv3",laser.x,laser.y)
					blaster.SetVar("beam",beam)
					beam.sprite.rotation=laser.sprite.rotation
					blaster.SetVar("laser",laser)
					blaster.sprite.SendToTop()
					blaster.sprite.Set("blaster2")
					Audio.PlaySound("sfx_Blaster")
					blaster.SetVar("hue",math.random(360))
				end
				local away=140+80*math.sin((time-90)*math.pi/60)
				blaster.MoveTo(position[1]+away*math.cos(angle*math.pi/180),position[2]+away*math.sin(angle*math.pi/180))
				local laser=blaster.GetVar("laser")
				local beam=blaster.GetVar("beam")
				local ang=blaster.sprite.rotation
				laser.MoveTo(blaster.x+650*math.sin(ang*math.pi/180),blaster.y-650*math.cos(ang*math.pi/180))
				beam.MoveTo(laser.x,laser.y)
				elseif time<141 then
				blaster.sprite.alpha=math.cos((time-120)*math.pi/40)
				local laser=blaster.GetVar("laser")
				laser.sprite.alpha=blaster.sprite.alpha
			end
			if time>90 then
				local laser=blaster.GetVar("laser")
				local h=blaster.GetVar("hue")
				local beam=blaster.GetVar("beam")
				laser.sprite.color=color_multiply(hsv_to_rgb((hue+h*math.pi/180), 1.0, 0.70), 1.0)
				if collision.CheckCollision(Player,laser) and beam.sprite.alpha>0.75 then
					KnifeHurt(3)
				end	
				if collision.CheckCollision(Player,laser) and laser.sprite.alpha>0.75 then
					KnifeHurt(1)
				end	
				if time<120 then
					local size=1+math.sin(math.pi*(time-90)/40)
					laser.sprite.Scale(size,1)
					beam.sprite.scale(size/4,1)
					else
					size=1+math.sqrt(2)/2+2*(1-math.cos((time-120)*math.pi/40))
					laser.sprite.Scale(size,1)
					beam.sprite.scale(size/4,1)
					local alpha=(140-time)/20
					beam.sprite.alpha=alpha
					laser.sprite.alpha=alpha
				end
			end
			if time==140 then
				blaster.Remove()
				local laser=blaster.GetVar("laser")
				laser.Remove()
			end
		end
	end
end

function OnHit(bullet) 
end
