timer = 0
hue = 0
Arena.Resize(160, 160)


blasters={}
dummies1 = {}
dummies2 = {}
bigstars={}
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
spawntimer2=85
Player.hp=135

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

function CreateCrossPlusNormalBlasters()
	blasters_exist = true
	local first=math.random(4)-0.5
	
	local x=Player.x+200*math.cos(first*math.pi/2)
	local y=Player.y+200*math.sin(first*math.pi/2)
	local away=math.random(201)-101
	blaster1 = CreateProjectile("blaster", x, y)
	blaster1.sprite.rotation = -90+first*90
	blaster1.sprite.alpha=0
	blaster1.SetVar("rot",first)
	blaster1.SetVar("time", 0)
	blaster1.SetVar("rotatepoint",{Player.x,Player.y})
	table.insert(blasters,blaster1)

	x=Player.x+200*math.cos((first+1)*math.pi/2)
	y=Player.y+200*math.sin((first+1)*math.pi/2)

	blaster2 = CreateProjectile("blaster", Player.x,Player.y + v_alt * 200)
	blaster2.sprite.rotation = 90 - 90 * v_alt
	blaster2.SetVar("time", 0)
	blaster2.sprite.alpha=0
	blaster2.SetVar("rotatepoint",{Player.x,Player.y})
	blaster2.SetVar("rot",2-v_alt)
	table.insert(blasters,blaster2)

	Audio.PlaySound("sfx_BlasterEntry")
end

function CreateCrossPlusNormalBlasters2()
	blasters_exist = true
	local first=math.random(4)-0.5
	
	local x=Player.x+200*math.cos(first*math.pi/2)
	local y=Player.y+200*math.sin(first*math.pi/2)
	
	blasters_exist = true
	local away=math.random(201)-101
	blaster1 = CreateProjectile("blaster",Player.x+ h_alt * 200 , Player.y)
	blaster1.sprite.rotation = -90 * h_alt
	blaster1.sprite.alpha=0
	blaster1.SetVar("time", 0)
	blaster1.SetVar("rotatepoint",{Player.x,Player.y})
	blaster1.SetVar("rot",1-h_alt)
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

function CreateCrossPlusNormalBlasters3()
	blasters_exist = true
	local first=math.random(4)-0.5
	
	local x=Player.x+200*math.cos(first*math.pi/2)
	local y=Player.y+200*math.sin(first*math.pi/2)
	
	blasters_exist = true
	local away=math.random(201)-101
	blaster1 = CreateProjectile("blaster",Player.x+ h_alt * 200 , Player.y)
	blaster1.sprite.rotation = -90 * h_alt
	blaster1.sprite.alpha=0
	blaster1.SetVar("time", 0)
	blaster1.SetVar("rotatepoint",{Player.x,Player.y})
	blaster1.SetVar("rot",1-h_alt)
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

	x=Player.x+200*math.cos((first+1)*math.pi/2)
	y=Player.y+200*math.sin((first+1)*math.pi/2)

	blaster3 = CreateProjectile("blaster", x, y)
	blaster3.sprite.rotation = -90+first*90
	blaster3.sprite.alpha=0
	blaster3.SetVar("rot",first)
	blaster3.SetVar("time", 0)
	blaster3.SetVar("rotatepoint",{Player.x,Player.y})
	table.insert(blasters,blaster3)

	Audio.PlaySound("sfx_BlasterEntry")
end

function CreateCrossPlusNormalBlasters4()
	blasters_exist = true
	local first=math.random(4)-0.5
	
	local x=Player.x+200*math.cos(first*math.pi/2)
	local y=Player.y+200*math.sin(first*math.pi/2)
	
	blasters_exist = true
	local away=math.random(201)-101
	blaster1 = CreateProjectile("blaster",Player.x+ h_alt * 200 , Player.y)
	blaster1.sprite.rotation = -90 * h_alt
	blaster1.sprite.alpha=0
	blaster1.SetVar("time", 0)
	blaster1.SetVar("rotatepoint",{Player.x,Player.y})
	blaster1.SetVar("rot",1-h_alt)
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

	x=Player.x+200*math.cos((first+1)*math.pi/2)
	y=Player.y+200*math.sin((first+1)*math.pi/2)

	blaster3 = CreateProjectile("blaster", Player.x,Player.y + v_alt * 200)
	blaster3.sprite.rotation = 90 - 90 * v_alt
	blaster3.SetVar("time", 0)
	blaster3.sprite.alpha=0
	blaster3.SetVar("rotatepoint",{Player.x,Player.y})
	blaster3.SetVar("rot",2-v_alt)

	Audio.PlaySound("sfx_BlasterEntry")
end

function CreateCrossPlusNormalBlasters5()
	blasters_exist = true
	local first=math.random(4)-0.5
	
	local x=Player.x+200*math.cos(first*math.pi/2)
	local y=Player.y+200*math.sin(first*math.pi/2)
	
	blasters_exist = true
	local away=math.random(201)-101
	blaster1 = CreateProjectile("blaster", Player.x,Player.y + v_alt * 200)
	blaster1.sprite.rotation = 90 - 90 * v_alt
	blaster1.SetVar("time", 0)
	blaster1.sprite.alpha=0
	blaster1.SetVar("rotatepoint",{Player.x,Player.y})
	blaster1.SetVar("rot",2-v_alt)
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

	x=Player.x+200*math.cos((first+1)*math.pi/2)
	y=Player.y+200*math.sin((first+1)*math.pi/2)

	blaster3 = CreateProjectile("blaster", x, y)
	blaster3.sprite.rotation = -90+first*90
	blaster3.sprite.alpha=0
	blaster3.SetVar("rot",first)
	blaster3.SetVar("time", 0)
	blaster3.SetVar("rotatepoint",{Player.x,Player.y})
	table.insert(blasters,blaster3)

	Audio.PlaySound("sfx_BlasterEntry")
end

function CreateCrossPlusNormalBlasters6()
	blasters_exist = true
	local first=math.random(4)-0.5
	
	local x=Player.x+200*math.cos(first*math.pi/2)
	local y=Player.y+200*math.sin(first*math.pi/2)
	
	blasters_exist = true
	local away=math.random(201)-101
	blaster1 = CreateProjectile("blaster",Player.x+ h_alt * 200 , Player.y)
	blaster1.sprite.rotation = -90 * h_alt
	blaster1.sprite.alpha=0
	blaster1.SetVar("time", 0)
	blaster1.SetVar("rotatepoint",{Player.x,Player.y})
	blaster1.SetVar("rot",1-h_alt)
	table.insert(blasters,blaster1)

	x=Player.x+200*math.cos((first+1)*math.pi/2)
	y=Player.y+200*math.sin((first+1)*math.pi/2)

	blaster2 = CreateProjectile("blaster", x, y)
	blaster2.sprite.rotation = -90+first*90
	blaster2.sprite.alpha=0
	blaster2.SetVar("rot",first)
	blaster2.SetVar("time", 0)
	blaster2.SetVar("rotatepoint",{Player.x,Player.y})
	table.insert(blasters,blaster2)

	x=Player.x+200*math.cos((first+1)*math.pi/2)
	y=Player.y+200*math.sin((first+1)*math.pi/2)

	blaster3 = CreateProjectile("blaster", Player.x,Player.y + v_alt * 200)
	blaster3.sprite.rotation = 90 - 90 * v_alt
	blaster3.SetVar("time", 0)
	blaster3.sprite.alpha=0
	blaster3.SetVar("rotatepoint",{Player.x,Player.y})
	blaster3.SetVar("rot",2-v_alt)

	Audio.PlaySound("sfx_BlasterEntry")
end

function Update()
HurtUpd(1800)
Moving()
	timer = timer + 1
	hue = hue + 6*math.pi / 180
	if hue > math.pi * 2 then
		hue = hue - math.pi * 2
	end

	if (timer+30)%75 == 0 and timer>99900 then
		h_alt = math.random(2)*2-3 -- подозреваю, что есть способ поизящнее, ноооо.....
		v_alt = math.random(2)*2-3 -- говнокооод, говнокооооод, на вид как говно, а на деле он код
		local mathRand=math.random(4)
		if mathRand == 2 then
			CreateBlasters()
		elseif mathRand == 3 then
			CreateCrossPlusNormalBlasters()
		elseif mathRand == 1 then
			CreateCrossPlusNormalBlasters2()
		else
			CreateCrossBlasters()
		end
	end

	if (timer+30)%90 == 0 and timer>1299900 then
		h_alt = math.random(2)*2-3 -- подозреваю, что есть способ поизящнее, ноооо.....
		v_alt = math.random(2)*2-3 -- говнокооод, говнокооооод, на вид как говно, а на деле он код
		local mathRand=math.random(4)
		if mathRand == 2 then
			CreateCrossPlusNormalBlasters3()
		elseif mathRand == 3 then
			CreateCrossPlusNormalBlasters4()
		elseif mathRand == 1 then
			CreateCrossPlusNormalBlasters5()
		else
			CreateCrossPlusNormalBlasters6()
		end
	end

	local randgen=math.random(4)
	if timer%80==100 or (timer%spawntimer2==1 and randgen==1) then
		local bigstar = CreateProjectile("b_star", math.random(241)-121, 330)
		bigstar.SetVar("firstpoint",{bigstar.x,300})
		bigstar.SetVar("time",0)
		bigstar.SetVar("posx",bigstar.x)
		bigstar.SetVar("posy",bigstar.y)
		table.insert(bigstars,bigstar)
		--elseif timer%240>1 and timer>99999 then
		--end
		spawntimer2=spawntimer2-1
	end

	if timer%80==401 or (timer%spawntimer2==1 and randgen==2) then
		local bigstar = CreateProjectile("b_star", math.random(241)-121, -330)
		bigstar.SetVar("firstpoint",{bigstar.x,-300})
		bigstar.SetVar("time",0)
		bigstar.SetVar("posx",bigstar.x)
		bigstar.SetVar("posy",bigstar.y)
		table.insert(bigstars,bigstar)
		--elseif timer%240>1 and timer>99999 then
		--end
		spawntimer2=spawntimer2-1
	end

	if timer%80==201 or (timer%spawntimer2==1 and randgen==3) then
		local bigstar = CreateProjectile("b_star", 330, math.random(241)-121)
		bigstar.SetVar("firstpoint",{300,bigstar.y})
		bigstar.SetVar("time",0)
		bigstar.SetVar("posx",bigstar.x)
		bigstar.SetVar("posy",bigstar.y)
		table.insert(bigstars,bigstar)
		--elseif timer%240>1 and timer>99999 then
		--end
		spawntimer2=spawntimer2-1
	end

	if timer%80==601 or (timer%spawntimer2==1 and randgen==4) then
		local bigstar = CreateProjectile("b_star", -330, math.random(241)-121)
		bigstar.SetVar("firstpoint",{-300,bigstar.y})
		bigstar.SetVar("time",0)
		bigstar.SetVar("posx",bigstar.x)
		bigstar.SetVar("posy",bigstar.y)
		table.insert(bigstars,bigstar)
		--elseif timer%240>1 and timer>99999 then
		--end
		spawntimer2=spawntimer2-1
	end

	for i=1,#bigstars do
		local bigstar=bigstars[i]
		if bigstar.isactive then
			bigstar.SetVar("time",bigstar.GetVar("time")+0.5)
			if bigstar.GetVar("time")<30 then
				local new=(bigstar.GetVar("time")-10)/30
				local old=1-new
				--bigstar.sprite.color=color_multiply(hsv_to_rgb(1, 1.0, 0.70), 1.0)
				local pos=bigstar.GetVar("firstpoint")
				bigstar.sprite.rotation=bigstar.sprite.rotation+3
				--if pos[1]==
				bigstar.MoveTo(old*pos[1],old*pos[2])--old*330+new*(Arena.height/2+5+bigstar.sprite.height/2)--old*pos[1]
				elseif bigstar.GetVar("time")>=30 then
				--stars={}
				local randomangle=math.random(24)
				for j=1,8 do
					local star=CreateProjectile("m_star",bigstar.x,bigstar.y)
					star.sprite.color=color_multiply(hsv_to_rgb(hue, 1.0, 0.70), 1.0)
					star.sprite.rotation=math.random(360)
					star.SetVar("rot",math.random(2)*2-3)
					star.SetVar("time",30)
					star.SetVar("posx",bigstar.x)
					star.SetVar("posy",bigstar.y)
					star.SetVar("rand",randomangle)
					table.insert(stars,star)
				end
				bigstar.Remove()
			end
		end
	end

	for i=1,#stars do
		local star = stars[i]
		if star.isactive then
			star.SetVar("time",star.GetVar("time")+0.75)
			if star.GetVar("time")<251 and star.GetVar("time")>30 then
				local away=300*math.sin((star.GetVar("time")-30)*math.pi/300)
				--for i=1,6 do
					local angle=(360/8)*i+(star.GetVar("time")-30)*2+star.GetVar("rand")
					star.MoveTo(star.GetVar("posx")+away*math.cos(angle*math.pi/180),star.GetVar("posy")+away*math.sin(angle*math.pi/180))
					star.sprite.rotation=star.sprite.rotation+5*star.GetVar("rot")
					local px=Player.x
					local py=Player.y
					local x=star.x
					local y=star.y
					if star.GetVar("time")>60 then
						star.sprite.alpha=math.cos((star.GetVar("time")-30)*math.pi/120)
					end
					if px+14>x and px-14<x and py+14>y and py-14<y and star.sprite.alpha>0.5 then
						LongHurt(10,20)
					end
					if star.GetVar("time")>=66 then
						star.Remove()
					end
				--end
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
				--if collision.CheckCollision(Player,laser) and beam.sprite.alpha>0.75 then
				--	KnifeHurt(3)
				--end	
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
