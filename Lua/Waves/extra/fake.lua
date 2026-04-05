spawntimer = 0
knive = {}
playerspeed_x = 0
playerspeed_y = 0
Arena.Resize (16, 16)

vzmah_anim = {"chara/att1", "chara/att2", "chara/att3", "chara/att4", "chara/att5"}
vzmahi = {}

blasts = {}

sdvig = 1
endgame = false
lastsecond = 0

function Update()
spawntimer = spawntimer + 1
if spawntimer%20 == 0 then
			Audio.PlaySound("slice2")
			local vzmah = CreateProjectile('chara/att0', -0.2*spawntimer+80, 10)
			vzmah.SetVar("bulletType", "sprite")
			vzmah.SetVar("exist", true)
			vzmah.SetVar("currentframe", 0)
			table.insert(vzmahi, vzmah)
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
	
	if endgame then
		if spawntimer%5 == 0 then
			local dx = 10*sdvig
			deadscreen.Move(dx, 0)
			sdvig = -1*sdvig
		end
		if (spawntimer-lastsecond) >= 10 then
			SetGlobal("Playerisdead",true)
			SetGlobal("nocomment",true)
			EndWave()
		end
	end
end

function GameOver()
	Audio.Stop()
	Player.SetControlOverride(true)
	playerspeed_x = 0
	playerspeed_y = 0
	Player.sprite.rotation = 0
	deadscreen = CreateProjectileAbs('chara/999999', 320, 240)
	endgame = true
	incontrol = false
	lastsecond = spawntimer
end
end

function OnHit(bullet)
	if bullet.GetVar('bulletType') == "deadly" then
		GameOver()
	end
end