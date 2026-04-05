spawntimer = 0
knives = {}
lastknives = {}
lastknifespeed = 10
horizknives = {}
orientknife = -1
Arena.Resize(155, 130)
Player.SetControlOverride(true)
playerspeed_x = 0
playerspeed_y = 0
endwave=false
aud_volume = 1
aud_pitch = 1.2


incontrol = false
require "Libraries/hurt"

vzmah_anim = {"chara/att1", "chara/att2", "chara/att3", "chara/att4", "chara/att5"}
vzmahi = {}
deadtime=0
blasts = {}

endgame = false
lastsecond = 0
sdvig = 1



function Update()
	HurtUpd(12000000)
	if endgame==false then
		spawntimer = spawntimer + 1
		else spawntimer=1
	end
	if endwave==false then
		Player.MoveTo(Player.x+playerspeed_x, Player.y+playerspeed_y, false)
	end
	if incontrol then
		if Input.Up>0 and Input.Down==0 then
			playerspeed_y=2
			elseif Input.Up==0 and Input.Down>0 then
			playerspeed_y=-2
			else playerspeed_y=0
		end
		if Input.Right>0 and Input.Left==0 then
			playerspeed_x=3
			elseif Input.Right==0 and Input.Left>0 then
			playerspeed_x=-2
			else playerspeed_x=0
		end
	end

	if spawntimer == 12 then
		playerspeed_x = 1
		playerspeed_y = 10
		Player.sprite.rotation = 180
		Audio.PlaySound("hurtsound")
	end

	if spawntimer == 24 then
		playerspeed_x = 1
		playerspeed_y = -10
		Player.sprite.rotation = 0
		Audio.PlaySound("hurtsound")
	end

	if spawntimer == 36 then
		playerspeed_x = 11
		playerspeed_y = 3
		Player.sprite.rotation = 90
		Arena.Resize(650, 80)
		Audio.PlaySound("hurtsound")
	end

	if spawntimer == 48 then
		playerspeed_x = -50
		playerspeed_y = 0
		Player.sprite.rotation = -90
		--Arena.Resize(650, 80)
		Audio.PlaySound("hurtsound")
	end

	if spawntimer == 60 then
		--Arena.Resize(650, 80)
		incontrol = true
		playerspeed_x = -1
		playerspeed_y = 0
		Player.sprite.rotation = -90
	end

	if spawntimer > 60 and spawntimer < 540 then
		if Input.Up == 0 and Input.Down == 0 and Input.Left == 0 and Input.Right == 0 then
			playerspeed_x = 0
			playerspeed_y = 0
		end

-------------------------------------------------------- игрока "сдувает" назад
		if endgame == false then
			Player.MoveTo(Player.x-1, Player.y, false)
		end
--------------------------------------------------------

		if spawntimer%6 == 0 then
			local knife = CreateProjectile('vert_knife', -10+0.5*spawntimer, 320*orientknife)
			knife.sprite.rotation = 90 - orientknife*90
			knife.SetVar("bulletType", "knife")
			orientknife = -orientknife
			table.insert(knives, knife)
		end
		if spawntimer%96 == 0 and spawntimer<470 then
			local knife_y = Player.y
			local hknife = CreateProjectile('KnifeLeft', 360, knife_y)
			hknife.SetVar("bulletType", "knife")
			table.insert(horizknives, hknife)
		end
		if spawntimer%160 == 0 then
			Audio.PlaySound("slice2")
			local vzmah = CreateProjectile('chara/att0', 0.4*spawntimer+80, 10)
			vzmah.SetVar("bulletType", "sprite")
			vzmah.SetVar("exist", true)
			vzmah.SetVar("currentframe", 0)
			table.insert(vzmahi, vzmah)
		end

	end


	if spawntimer == 542 then
		Arena.Resize(16, 160)
	end
	if spawntimer==560 then
		incontrol = false
		playerspeed_x=0
		playerspeed_y=-10
		Player.sprite.rotation=0
	end
	if Player.y==-72 and endwave==false then
		Player.sprite.rotation=180
		playerspeed_y=10
		Audio.PlaySound("slam")
	end
	if Player.y==72 and endwave==false then
		endwave=true
		Audio.PlaySound("slam")
		SetGlobal("nextwave",true)
		Player.SetControlOverride(false)
	end
		









	for i=1, #knives do
		local knife = knives[i]
		if spawntimer > 538 and spawntimer < 540 then
			knife.sprite.alpha = 0
			knife.SetVar("bulletType", "sprite")
		else
			new_x = knife.x - 3
		end
		new_y = knife.y * (0.99-0.0001*spawntimer)
		knife.MoveTo(new_x, new_y)
		if endgame then
			knife.sprite.alpha = 0
		end

	end

	for j=1, #horizknives do
		local knife = horizknives[j]
		new_x = knife.x - 5
		new_y = knife.y
		knife.MoveTo(new_x, new_y)
		if endgame then
			knife.sprite.alpha = 0
		end
	end

	for k=1, #vzmahi do
		local vzmah = vzmahi[k]
		local frame = vzmah.GetVar("currentframe")
		if vzmah.GetVar('exist') == true and spawntimer%7 == 0 then
			frame = frame+1
			vzmah.sprite.Set(vzmah_anim[frame])
			vzmah.SetVar("currentframe", frame)
			if frame == 5 then
				vzmah.SetVar("exist", false)
				vzmah.sprite.alpha = 0
				Audio.PlaySound("bolt")
				local blast = CreateProjectile('laser0/laserv0', vzmah.x, vzmah.y)
				blast.SetVar("exist", true)
				blast.SetVar("bulletType", "deadly")
				table.insert(blasts, blast)
			end
		end

		vzmah.Move(-3, 0)
	end

	for l=1, #blasts do
		local blast = blasts[l]
		if blast.GetVar('exist') == true then
			blast.sprite.alpha = blast.sprite.alpha - 0.16
			if blast.sprite.alpha < 0.2 then
				blast.sprite.alpha = 0
				blast.SetVar("exist", true)
				blast.SetVar("bulletType", "sprite")
			end
		end
		blast.Move(-3, 0)
	end



	for m=1, #lastknives do
		local knife = lastknives[m]
		local ugol = knife.GetVar("angle")
		local skorost = knife.GetVar("speed")
		local vremya = knife.GetVar("timestamp")
		if (spawntimer - vremya) > 40 then
			local dx = skorost*math.sin(math.pi*ugol/180)
			local dy = -skorost*math.cos(math.pi*ugol/180)
			knife.Move(dx, dy)
		end

	end



if endgame==true then
  deadtime=deadtime+1
  Encounter.Call("SetMusic","none")
  Player.SetControlOverride(true)
  if  deadtime<60 then
     deadscreen = CreateProjectile("999999", 0,145-Arena.height/2)
     deadtime=60
     else
     deadscreen.MoveTo(5*math.sin(deadtime*math.pi/5),145-Arena.height/2)
  end
  if deadtime==120 then
	FakeDeath()
  end
end

end


function GameOver()
	Audio.Stop()
	Player.SetControlOverride(true)
	playerspeed_x = 0
	playerspeed_y = 0
	Player.sprite.rotation = 0
	endgame = true
	incontrol = false
	endwave=true
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
		elseif bullet.GetVar('bulletType') == "knife" then
		KnifeHurt(1)
	end
end