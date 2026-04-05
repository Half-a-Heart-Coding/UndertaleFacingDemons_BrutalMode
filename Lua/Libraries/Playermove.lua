local speed=0
local movespeed=0
local movi=false
if Encounter.GetVar("diff") == 11 then
	if Encounter.GetVar("movefast")==true then
	speed=12
	else speed=10
	end
elseif (Encounter.GetVar("diff") == 21 and Encounter.GetVar("evrerythingModeEffect") == "SpeedDemon") then
	if Encounter.GetVar("movefast")==true then
	speed=10
	else speed=8
	end
elseif (Encounter.GetVar("diff") == 21 and Encounter.GetVar("evrerythingModeEffect") == "Frozen") then
	if Encounter.GetVar("movefast")==true then
	speed=2
	else speed=1.5
	end
elseif Encounter.GetVar("diff") == 12 then
	if Encounter.GetVar("movefast")==true then
	speed=1.5
	else speed=1
	end
else
	if Encounter.GetVar("movefast")==true then
	speed=3
	else speed=2
	end
end
if Encounter.GetVar("progress") == 47 or Encounter.GetVar("progress") == 48 then
	speed = speed * 2
end
--purpleSpeed=0
SetGlobal("purpleSpeed",0)
SetGlobal("purpleSpeedTimer", 0)
Player.SetControlOverride(true)
--local mousePos
--	local Vector3 mousePosition {
        --get {
            --mousePos = Input.mousePosition
            --mousePos.x -= displayedSize.z;
--            return Input.mousePosition;
        --}
--	}
--local mousePosX = FacingDemons.Lua.Libraries.Mouse.MousePosX
--local mousePosY = FacingDemons.Lua.Libraries.Mouse.MousePosY
local playerY2 = 0
local playerX2 = 0
HasExtraLife2 = GetGlobal("HasExtraLife")
bullet2bs = {}
local bullet2b = nil
local timer = 0
--function OnHit(attack)
--	local bullet2b = bullet2bs[i]
	--local burn=GetGlobal("burn")
--	if attack.GetVar("color")=="fire" and bullet2b.GetVar('vely2') == 1 then
--		SetGlobal("burn", GetGlobal("burn") + 1)
--	end
--end

function Moving()
	timer = timer + 1
	if Encounter.GetVar("diff") == 21 then

			SetGlobal("FramesAgo75y", GetGlobal("FramesAgo74y"))
			SetGlobal("FramesAgo74y", GetGlobal("FramesAgo73y"))
			SetGlobal("FramesAgo73y", GetGlobal("FramesAgo72y"))
			SetGlobal("FramesAgo72y", GetGlobal("FramesAgo71y"))
			SetGlobal("FramesAgo71y", GetGlobal("FramesAgo70y"))
			SetGlobal("FramesAgo70y", GetGlobal("FramesAgo69y"))
			SetGlobal("FramesAgo69y", GetGlobal("FramesAgo68y"))
			SetGlobal("FramesAgo68y", GetGlobal("FramesAgo67y"))
			SetGlobal("FramesAgo67y", GetGlobal("FramesAgo66y"))
			SetGlobal("FramesAgo66y", GetGlobal("FramesAgo65y"))
			SetGlobal("FramesAgo65y", GetGlobal("FramesAgo64y"))
			SetGlobal("FramesAgo64y", GetGlobal("FramesAgo63y"))
			SetGlobal("FramesAgo63y", GetGlobal("FramesAgo62y"))
			SetGlobal("FramesAgo62y", GetGlobal("FramesAgo61y"))
			SetGlobal("FramesAgo61y", GetGlobal("FramesAgo60y"))

			SetGlobal("FramesAgo60y", GetGlobal("FramesAgo59y"))
			SetGlobal("FramesAgo59y", GetGlobal("FramesAgo58y"))
			SetGlobal("FramesAgo58y", GetGlobal("FramesAgo57y"))
			SetGlobal("FramesAgo57y", GetGlobal("FramesAgo56y"))
			SetGlobal("FramesAgo56y", GetGlobal("FramesAgo55y"))
			SetGlobal("FramesAgo55y", GetGlobal("FramesAgo54y"))
			SetGlobal("FramesAgo54y", GetGlobal("FramesAgo53y"))
			SetGlobal("FramesAgo53y", GetGlobal("FramesAgo52y"))
			SetGlobal("FramesAgo52y", GetGlobal("FramesAgo51y"))
			SetGlobal("FramesAgo51y", GetGlobal("FramesAgo50y"))
			SetGlobal("FramesAgo50y", GetGlobal("FramesAgo49y"))
			SetGlobal("FramesAgo49y", GetGlobal("FramesAgo48y"))
			SetGlobal("FramesAgo48y", GetGlobal("FramesAgo47y"))
			SetGlobal("FramesAgo47y", GetGlobal("FramesAgo46y"))
			SetGlobal("FramesAgo46y", GetGlobal("FramesAgo45y"))
			SetGlobal("FramesAgo45y", GetGlobal("FramesAgo44y"))

			SetGlobal("FramesAgo44y", GetGlobal("FramesAgo43y"))
			SetGlobal("FramesAgo43y", GetGlobal("FramesAgo42y"))
			SetGlobal("FramesAgo42y", GetGlobal("FramesAgo41y"))
			SetGlobal("FramesAgo41y", GetGlobal("FramesAgo40y"))
			SetGlobal("FramesAgo40y", GetGlobal("FramesAgo39y"))
			SetGlobal("FramesAgo39y", GetGlobal("FramesAgo38y"))
			SetGlobal("FramesAgo38y", GetGlobal("FramesAgo37y"))
			SetGlobal("FramesAgo37y", GetGlobal("FramesAgo36y"))
			SetGlobal("FramesAgo36y", GetGlobal("FramesAgo35y"))
			SetGlobal("FramesAgo35y", GetGlobal("FramesAgo34y"))
			SetGlobal("FramesAgo34y", GetGlobal("FramesAgo33y"))
			SetGlobal("FramesAgo33y", GetGlobal("FramesAgo32y"))
			SetGlobal("FramesAgo32y", GetGlobal("FramesAgo31y"))
			SetGlobal("FramesAgo31y", GetGlobal("FramesAgo30y"))
			SetGlobal("FramesAgo30y", GetGlobal("FramesAgo29y"))
			SetGlobal("FramesAgo29y", GetGlobal("FramesAgo28y"))

			SetGlobal("FramesAgo28y", GetGlobal("FramesAgo27y"))
			SetGlobal("FramesAgo27y", GetGlobal("FramesAgo26y"))
			SetGlobal("FramesAgo26y", GetGlobal("FramesAgo25y"))
			SetGlobal("FramesAgo25y", GetGlobal("FramesAgo24y"))
			SetGlobal("FramesAgo24y", GetGlobal("FramesAgo23y"))
			SetGlobal("FramesAgo23y", GetGlobal("FramesAgo22y"))
			SetGlobal("FramesAgo22y", GetGlobal("FramesAgo21y"))
			SetGlobal("FramesAgo21y", GetGlobal("FramesAgo20y"))
			SetGlobal("FramesAgo20y", GetGlobal("FramesAgo19y"))
			SetGlobal("FramesAgo19y", GetGlobal("FramesAgo18y"))
			SetGlobal("FramesAgo18y", GetGlobal("FramesAgo17y"))
			SetGlobal("FramesAgo17y", GetGlobal("FramesAgo16y"))
			SetGlobal("FramesAgo16y", GetGlobal("FramesAgo15y"))
			SetGlobal("FramesAgo15y", GetGlobal("FramesAgo14y"))
			SetGlobal("FramesAgo14y", GetGlobal("FramesAgo13y"))
			SetGlobal("FramesAgo13y", GetGlobal("FramesAgo12y"))

			SetGlobal("FramesAgo12y", GetGlobal("FramesAgo11y"))
			SetGlobal("FramesAgo11y", GetGlobal("FramesAgo10y"))
			SetGlobal("FramesAgo10y", GetGlobal("FramesAgo9y"))
			SetGlobal("FramesAgo9y", GetGlobal("FramesAgo8y"))
			SetGlobal("FramesAgo8y", GetGlobal("FramesAgo7y"))
			SetGlobal("FramesAgo7y", GetGlobal("FramesAgo6y"))
			SetGlobal("FramesAgo6y", GetGlobal("FramesAgo5y"))
			SetGlobal("FramesAgo5y", GetGlobal("FramesAgo4y"))
			SetGlobal("FramesAgo4y", GetGlobal("FramesAgo3y"))
			SetGlobal("FramesAgo3y", GetGlobal("FramesAgo2y"))
			SetGlobal("FramesAgo2y", GetGlobal("FramesAgo1y"))
			SetGlobal("FramesAgo1y", Player.y)

			--SetGlobal("FramesAgo60x", GetGlobal("FramesAgo59x"))
			SetGlobal("FramesAgo75x", GetGlobal("FramesAgo74x"))
			SetGlobal("FramesAgo74x", GetGlobal("FramesAgo73x"))
			SetGlobal("FramesAgo73x", GetGlobal("FramesAgo72x"))
			SetGlobal("FramesAgo72x", GetGlobal("FramesAgo71x"))
			SetGlobal("FramesAgo71x", GetGlobal("FramesAgo70x"))
			SetGlobal("FramesAgo70x", GetGlobal("FramesAgo69x"))
			SetGlobal("FramesAgo69x", GetGlobal("FramesAgo68x"))
			SetGlobal("FramesAgo68x", GetGlobal("FramesAgo67x"))
			SetGlobal("FramesAgo67x", GetGlobal("FramesAgo66x"))
			SetGlobal("FramesAgo66x", GetGlobal("FramesAgo65x"))
			SetGlobal("FramesAgo65x", GetGlobal("FramesAgo64x"))
			SetGlobal("FramesAgo64x", GetGlobal("FramesAgo63x"))
			SetGlobal("FramesAgo63x", GetGlobal("FramesAgo62x"))
			SetGlobal("FramesAgo62x", GetGlobal("FramesAgo61x"))
			SetGlobal("FramesAgo61x", GetGlobal("FramesAgo60x"))

			SetGlobal("FramesAgo60x", GetGlobal("FramesAgo59x"))
			SetGlobal("FramesAgo59x", GetGlobal("FramesAgo58x"))
			SetGlobal("FramesAgo58x", GetGlobal("FramesAgo57x"))
			SetGlobal("FramesAgo57x", GetGlobal("FramesAgo56x"))
			SetGlobal("FramesAgo56x", GetGlobal("FramesAgo55x"))
			SetGlobal("FramesAgo55x", GetGlobal("FramesAgo54x"))
			SetGlobal("FramesAgo54x", GetGlobal("FramesAgo53x"))
			SetGlobal("FramesAgo53x", GetGlobal("FramesAgo52x"))
			SetGlobal("FramesAgo52x", GetGlobal("FramesAgo51x"))
			SetGlobal("FramesAgo51x", GetGlobal("FramesAgo50x"))
			SetGlobal("FramesAgo50x", GetGlobal("FramesAgo49x"))
			SetGlobal("FramesAgo49x", GetGlobal("FramesAgo48x"))
			SetGlobal("FramesAgo48x", GetGlobal("FramesAgo47x"))
			SetGlobal("FramesAgo47x", GetGlobal("FramesAgo46x"))
			SetGlobal("FramesAgo46x", GetGlobal("FramesAgo45x"))
			SetGlobal("FramesAgo45x", GetGlobal("FramesAgo44x"))

			SetGlobal("FramesAgo44x", GetGlobal("FramesAgo43x"))
			SetGlobal("FramesAgo43x", GetGlobal("FramesAgo42x"))
			SetGlobal("FramesAgo42x", GetGlobal("FramesAgo41x"))
			SetGlobal("FramesAgo41x", GetGlobal("FramesAgo40x"))
			SetGlobal("FramesAgo40x", GetGlobal("FramesAgo39x"))
			SetGlobal("FramesAgo39x", GetGlobal("FramesAgo38x"))
			SetGlobal("FramesAgo38x", GetGlobal("FramesAgo37x"))
			SetGlobal("FramesAgo37x", GetGlobal("FramesAgo36x"))
			SetGlobal("FramesAgo36x", GetGlobal("FramesAgo35x"))
			SetGlobal("FramesAgo35x", GetGlobal("FramesAgo34x"))
			SetGlobal("FramesAgo34x", GetGlobal("FramesAgo33x"))
			SetGlobal("FramesAgo33x", GetGlobal("FramesAgo32x"))
			SetGlobal("FramesAgo32x", GetGlobal("FramesAgo31x"))
			SetGlobal("FramesAgo31x", GetGlobal("FramesAgo30x"))
			SetGlobal("FramesAgo30x", GetGlobal("FramesAgo29x"))
			SetGlobal("FramesAgo29x", GetGlobal("FramesAgo28x"))

			SetGlobal("FramesAgo28x", GetGlobal("FramesAgo27x"))
			SetGlobal("FramesAgo27x", GetGlobal("FramesAgo26x"))
			SetGlobal("FramesAgo26x", GetGlobal("FramesAgo25x"))
			SetGlobal("FramesAgo25x", GetGlobal("FramesAgo24x"))
			SetGlobal("FramesAgo24x", GetGlobal("FramesAgo23x"))
			SetGlobal("FramesAgo23x", GetGlobal("FramesAgo22x"))
			SetGlobal("FramesAgo22x", GetGlobal("FramesAgo21x"))
			SetGlobal("FramesAgo21x", GetGlobal("FramesAgo20x"))
			SetGlobal("FramesAgo20x", GetGlobal("FramesAgo19x"))
			SetGlobal("FramesAgo19x", GetGlobal("FramesAgo18x"))
			SetGlobal("FramesAgo18x", GetGlobal("FramesAgo17x"))
			SetGlobal("FramesAgo17x", GetGlobal("FramesAgo16x"))
			SetGlobal("FramesAgo16x", GetGlobal("FramesAgo15x"))
			SetGlobal("FramesAgo15x", GetGlobal("FramesAgo14x"))
			SetGlobal("FramesAgo14x", GetGlobal("FramesAgo13x"))
			SetGlobal("FramesAgo13x", GetGlobal("FramesAgo12x"))

			SetGlobal("FramesAgo12x", GetGlobal("FramesAgo11x"))
			SetGlobal("FramesAgo11x", GetGlobal("FramesAgo10x"))
			SetGlobal("FramesAgo10x", GetGlobal("FramesAgo9x"))
			SetGlobal("FramesAgo9x", GetGlobal("FramesAgo8x"))
			SetGlobal("FramesAgo8x", GetGlobal("FramesAgo7x"))
			SetGlobal("FramesAgo7x", GetGlobal("FramesAgo6x"))
			SetGlobal("FramesAgo6x", GetGlobal("FramesAgo5x"))
			SetGlobal("FramesAgo5x", GetGlobal("FramesAgo4x"))
			SetGlobal("FramesAgo4x", GetGlobal("FramesAgo3x"))
			SetGlobal("FramesAgo3x", GetGlobal("FramesAgo2x"))
			SetGlobal("FramesAgo2x", GetGlobal("FramesAgo1x"))
			SetGlobal("FramesAgo1x", Player.x)

		if Encounter.GetVar("evrerythingModeEffect") == "RevFunnel" then
			if 0<Player.y then
				Player.MoveTo(Player.x,Player.y+0.25,false)
			elseif 0>Player.y then
				Player.MoveTo(Player.x,Player.y-0.25,false)
			end
				Player.MoveTo(Player.x,Player.y,false)

			if 0<Player.x then
				Player.MoveTo(Player.x+0.5,Player.y,false)
			elseif 0>Player.x then
				Player.MoveTo(Player.x-0.5,Player.y,false)
			end
		end

		if Encounter.GetVar("evrerythingModeEffect") == "Funnel" then
			if 0<Player.y then
				Player.MoveTo(Player.x,Player.y-0.35,false)
			elseif 0>Player.y then
				Player.MoveTo(Player.x,Player.y+0.35,false)
			end
				Player.MoveTo(Player.x,Player.y,false)

			if 0<Player.x then
				Player.MoveTo(Player.x-0.5,Player.y,false)
			elseif 0>Player.x then
				Player.MoveTo(Player.x+0.5,Player.y,false)
			end
		end

		if Encounter.GetVar("evrerythingModeEffect") == "Hell" then

			if GetGlobal("BlackHolePushOrPullTimer") == nil then
				SetGlobal("BlackHolePushOrPullTimer", 30)
			end
			if GetGlobal("BlackHolePushOrPullTimer") > 0 then
				SetGlobal("BlackHolePushOrPullTimer", GetGlobal("BlackHolePushOrPullTimer") - 1)
			end
			if GetGlobal("BlackHolePushOrPullTimer") < 0 then
				SetGlobal("BlackHolePushOrPullTimer", 0)
			end
			if GetGlobal("BlackHolePushOrPullMode") == 1 then
				if 0<Player.y then
					Player.MoveTo(Player.x,Player.y+0.1,false)
				elseif 0>Player.y then
					Player.MoveTo(Player.x,Player.y-0.1,false)
				end
					Player.MoveTo(Player.x,Player.y,false)

				if 0<Player.x then
					Player.MoveTo(Player.x+0.1,Player.y,false)
				elseif 0>Player.x then
					Player.MoveTo(Player.x-0.1,Player.y,false)
				end

				if GetGlobal("FramesAgo30y")<Player.y then
					Player.MoveTo(Player.x,Player.y+0.1,false)
				elseif GetGlobal("FramesAgo30y")>Player.y then
					Player.MoveTo(Player.x,Player.y-0.1,false)
				end
				Player.MoveTo(Player.x,Player.y,false)

				if GetGlobal("FramesAgo30x")<Player.x then
					Player.MoveTo(Player.x+0.1,Player.y,false)
				elseif GetGlobal("FramesAgo30x")>Player.x then
					Player.MoveTo(Player.x-0.1,Player.y,false)
				end
			else
				if 0<Player.y then
					Player.MoveTo(Player.x,Player.y-0.2,false)
				elseif 0>Player.y then
					Player.MoveTo(Player.x,Player.y+0.2,false)
				end
					Player.MoveTo(Player.x,Player.y,false)

				if 0<Player.x then
					Player.MoveTo(Player.x-0.2,Player.y,false)
				elseif 0>Player.x then
					Player.MoveTo(Player.x+0.2,Player.y,false)
				end

				if GetGlobal("FramesAgo30y")<Player.y then
					Player.MoveTo(Player.x,Player.y-0.2,false)
				elseif GetGlobal("FramesAgo30y")>Player.y then
					Player.MoveTo(Player.x,Player.y+0.2,false)
				end
				Player.MoveTo(Player.x,Player.y,false)

				if GetGlobal("FramesAgo30x")<Player.x then
					Player.MoveTo(Player.x-0.2,Player.y,false)
				elseif GetGlobal("FramesAgo30x")>Player.x then
					Player.MoveTo(Player.x+0.2,Player.y,false)
				end
			end
		end

		if Encounter.GetVar("evrerythingModeEffect") == "RevBlackhole" then
			if GetGlobal("LastHitY")<Player.y then
				Player.MoveTo(Player.x,Player.y+0.25,false)
			elseif GetGlobal("LastHitY")>Player.y then
				Player.MoveTo(Player.x,Player.y-0.25,false)
			end
				Player.MoveTo(Player.x,Player.y,false)

			if GetGlobal("LastHitX")<Player.x then
				Player.MoveTo(Player.x+0.25,Player.y,false)
			elseif GetGlobal("LastHitX")>Player.x then
				Player.MoveTo(Player.x-0.25,Player.y,false)
			end
		end

		if Encounter.GetVar("evrerythingModeEffect") == "BlackHole" then
			if GetGlobal("LastHitY")<Player.y then
				Player.MoveTo(Player.x,Player.y-0.35,false)
			elseif GetGlobal("LastHitY")>Player.y then
				Player.MoveTo(Player.x,Player.y+0.35,false)
			end
				Player.MoveTo(Player.x,Player.y,false)

			if GetGlobal("LastHitX")<Player.x then
				Player.MoveTo(Player.x-0.35,Player.y,false)
			elseif GetGlobal("LastHitX")>Player.x then
				Player.MoveTo(Player.x+0.35,Player.y,false)
			end
		end

		if Encounter.GetVar("evrerythingModeEffect") == "Clock" then
			if GetGlobal("FramesAgo45y")<Player.y then
				Player.MoveTo(Player.x,Player.y-0.35,false)
				elseif GetGlobal("FramesAgo45y")>Player.y then
				Player.MoveTo(Player.x,Player.y+0.35,false)
			end
			Player.MoveTo(Player.x,Player.y,false)

			if GetGlobal("FramesAgo45x")<Player.x then
				Player.MoveTo(Player.x-0.35,Player.y,false)
				elseif GetGlobal("FramesAgo45x")>Player.x then
				Player.MoveTo(Player.x+0.35,Player.y,false)
			end
		end

		if Encounter.GetVar("evrerythingModeEffect") == "RevClock" then
			if GetGlobal("FramesAgo45y")<Player.y then
				Player.MoveTo(Player.x,Player.y+0.25,false)
				elseif GetGlobal("FramesAgo45y")>Player.y then
				Player.MoveTo(Player.x,Player.y-0.25,false)
			end
			Player.MoveTo(Player.x,Player.y,false)

			if GetGlobal("FramesAgo45x")<Player.x then
				Player.MoveTo(Player.x+0.25,Player.y,false)
				elseif GetGlobal("FramesAgo45x")>Player.x then
				Player.MoveTo(Player.x-0.25,Player.y,false)
			end
		end

		if Encounter.GetVar("evrerythingModeEffect") == "Chaos" and timer > 75 then

			--if GetGlobal("FireTrailTimer") > 0 then
			--	SetGlobal("FireTrailTimer", GetGlobal("FireTrailTimer") - 1)
			--else
			--SetGlobal("FireTrailTimer", 10)
			--if Encounter.GetVar("burnresistance") ~= true and GetGlobal("HasExtraLife") ~= true and HasExtraLife2 == GetGlobal("HasExtraLife") and timer >= 60 then
				if bullet2b ~= nil then
					if bullet2b.x + 15 > Player.x and bullet2b.x - 15 < Player.x and bullet2b.y + 15 > Player.y and bullet2b.y - 15 < Player.y then
							--if bullet2b.selfAbs.Overlaps(PlayerController.instance.playerAbs) then
								NewAudio.Play("Hits")
								--SetGlobal("LastHitX",Player.x)
								--SetGlobal("LastHitY",Player.y)	
								if Encounter.GetVar("burnresistance") then
									SetGlobal("burn", GetGlobal("burn") + 0.1)
								else
									SetGlobal("burn", GetGlobal("burn") + 0.2)
								end
								--SetGlobal("curse", GetGlobal("curse") + 1)
								--bullet2b.SetVar('canDamage', 0)
								--bullet2b.Enabled = false
								--bullet2b.Remove()
								--bullet2b = nil
								--bullet2b.sprite.color={1,0.35,0}
								--bullet2b.sprite.alpha = 0.35
							end
						--end
						--end

						--if bullet2b.GetVar('timer') == 50 then
							--bullet2b.sprite.color={1,0.5,0}
						--bullet2b.SetVar('canDamage', 1)
						--end	

						--if bullet2b.GetVar('timer') >= 10 then
							--bullet2b.sprite.alpha = 0
							--bullet2b.SetVar('canDamage', 0)
							--bullet2b.sprite.color={1,0.35,0}
							--bullet2b.Enabled = false
							bullet2b.Remove()
							bullet2b = nil
				end
				bullet2b = CreateProjectile('bullet', GetGlobal("FramesAgo75x"), GetGlobal("FramesAgo75y"))
				--local bullet2b = CreateProjectile('bullet', GetGlobal("FramesAgo10x"), GetGlobal("FramesAgo10y"))
				--local bullet2b = CreateProjectile('bullet', Player.x, Player.y)
				bullet2b.SetVar("color","fire2")
				bullet2b.SetVar('vely', 0)
				bullet2b.SetVar('velx', 0)
				bullet2b.SetVar('vely2', 0)
				bullet2b.SetVar('timer', 0)
				bullet2b.SetVar('canDamage', 0)
				bullet2b.sprite.alpha = 0.8
				bullet2b.sprite.color={1,0.5,0}
				--table.insert(bullet2bs, bullet2b)
				--for i=1, #bullet2bs do
					--local bullet2b = bullet2bs[i]
					--if bullet2b.GetVar("canDamage") ~= nil and bullet2b ~= nil then
						--local velx = bullet2b.GetVar('velx')
						--local vely = bullet2b.GetVar('vely')
						--bullet2b.SetVar('vely2', 1)
						--local newposx = bullet2b.x + velx
						--local newposy = bullet2b.y + vely
						--vely = vely
						--bullet2b.MoveTo(newposx, newposy)
						--bullet2b.SetVar('vely', vely)

						--bullet2b.SetVar('timer', bullet2b.GetVar('timer') + 1)

						--if bullet2b.GetVar('timer') == 40 then
						--	bullet2b.sprite.color={1,0.75,0}
						--end	

						--if bullet2b.sprite.alpha < 0.8 and  bullet2b.sprite.alpha > 0 then
						--	bullet2b.sprite.alpha = bullet2b.sprite.alpha + 0.01
						--end

						--if bullet2b.GetVar("timer") < 50 then
						--	bullet2b.SetVar('canDamage', 0)
						--else
						--if bullet2b.GetVar('canDamage') == 1 then
						--end
					--end
				--end
			--end
			--CreateProjectile("system/BR", Player.x, Player.y)
		end
	end
	if Encounter.GetVar("diff") == 17 then
		if Encounter.GetVar("movefast")==true then
			if Input.Cancel==0 then
				movespeed=2
			else
				movespeed=1
			end
		else 
			if Input.Cancel==0 then
				movespeed=3
			else
				movespeed=0.75
			end
		end
		if GetGlobal("BlackHolePushOrPullTimer") == nil then
			SetGlobal("BlackHolePushOrPullTimer", 300)
		end
		if GetGlobal("BlackHolePushOrPullTimer") > 0 then
			SetGlobal("BlackHolePushOrPullTimer", GetGlobal("BlackHolePushOrPullTimer") - 1)
		else
			if GetGlobal("BlackHolePushOrPullMode") == 1 then
				SetGlobal("BlackHolePushOrPullMode", 0)
			else
				SetGlobal("BlackHolePushOrPullMode", 1)
			end
			SetGlobal("BlackHolePushOrPullTimer", 300)
		end
		if GetGlobal("FireTrailTimer") == nil then
			SetGlobal("FireTrailTimer", 90)
		end

		SetGlobal("hpDamageTimer", GetGlobal("hpDamageTimer") + 1)
		if GetGlobal("hpDamageTimer") >= 30 and Encounter.GetVar("ghostresistance") == true then
			if Player.hp < 99 then
				Player.Heal(1)
			end
			SetGlobal("hpDamageTimer", 0)
		end

		SetGlobal("FramesAgo60y", GetGlobal("FramesAgo59y"))
			SetGlobal("FramesAgo59y", GetGlobal("FramesAgo58y"))
			SetGlobal("FramesAgo58y", GetGlobal("FramesAgo57y"))
			SetGlobal("FramesAgo57y", GetGlobal("FramesAgo56y"))
			SetGlobal("FramesAgo56y", GetGlobal("FramesAgo55y"))
			SetGlobal("FramesAgo55y", GetGlobal("FramesAgo54y"))
			SetGlobal("FramesAgo54y", GetGlobal("FramesAgo53y"))
			SetGlobal("FramesAgo53y", GetGlobal("FramesAgo52y"))
			SetGlobal("FramesAgo52y", GetGlobal("FramesAgo51y"))
			SetGlobal("FramesAgo51y", GetGlobal("FramesAgo50y"))
			SetGlobal("FramesAgo50y", GetGlobal("FramesAgo49y"))
			SetGlobal("FramesAgo49y", GetGlobal("FramesAgo48y"))
			SetGlobal("FramesAgo48y", GetGlobal("FramesAgo47y"))
			SetGlobal("FramesAgo47y", GetGlobal("FramesAgo46y"))
			SetGlobal("FramesAgo46y", GetGlobal("FramesAgo45y"))
			SetGlobal("FramesAgo45y", GetGlobal("FramesAgo44y"))

			SetGlobal("FramesAgo44y", GetGlobal("FramesAgo43y"))
			SetGlobal("FramesAgo43y", GetGlobal("FramesAgo42y"))
			SetGlobal("FramesAgo42y", GetGlobal("FramesAgo41y"))
			SetGlobal("FramesAgo41y", GetGlobal("FramesAgo40y"))
			SetGlobal("FramesAgo40y", GetGlobal("FramesAgo39y"))
			SetGlobal("FramesAgo39y", GetGlobal("FramesAgo38y"))
			SetGlobal("FramesAgo38y", GetGlobal("FramesAgo37y"))
			SetGlobal("FramesAgo37y", GetGlobal("FramesAgo36y"))
			SetGlobal("FramesAgo36y", GetGlobal("FramesAgo35y"))
			SetGlobal("FramesAgo35y", GetGlobal("FramesAgo34y"))
			SetGlobal("FramesAgo34y", GetGlobal("FramesAgo33y"))
			SetGlobal("FramesAgo33y", GetGlobal("FramesAgo32y"))
			SetGlobal("FramesAgo32y", GetGlobal("FramesAgo31y"))
			SetGlobal("FramesAgo31y", GetGlobal("FramesAgo30y"))
			SetGlobal("FramesAgo30y", GetGlobal("FramesAgo29y"))
			SetGlobal("FramesAgo29y", GetGlobal("FramesAgo28y"))

			SetGlobal("FramesAgo28y", GetGlobal("FramesAgo27y"))
			SetGlobal("FramesAgo27y", GetGlobal("FramesAgo26y"))
			SetGlobal("FramesAgo26y", GetGlobal("FramesAgo25y"))
			SetGlobal("FramesAgo25y", GetGlobal("FramesAgo24y"))
			SetGlobal("FramesAgo24y", GetGlobal("FramesAgo23y"))
			SetGlobal("FramesAgo23y", GetGlobal("FramesAgo22y"))
			SetGlobal("FramesAgo22y", GetGlobal("FramesAgo21y"))
			SetGlobal("FramesAgo21y", GetGlobal("FramesAgo20y"))
			SetGlobal("FramesAgo20y", GetGlobal("FramesAgo19y"))
			SetGlobal("FramesAgo19y", GetGlobal("FramesAgo18y"))
			SetGlobal("FramesAgo18y", GetGlobal("FramesAgo17y"))
			SetGlobal("FramesAgo17y", GetGlobal("FramesAgo16y"))
			SetGlobal("FramesAgo16y", GetGlobal("FramesAgo15y"))
			SetGlobal("FramesAgo15y", GetGlobal("FramesAgo14y"))
			SetGlobal("FramesAgo14y", GetGlobal("FramesAgo13y"))
			SetGlobal("FramesAgo13y", GetGlobal("FramesAgo12y"))

			SetGlobal("FramesAgo12y", GetGlobal("FramesAgo11y"))
			SetGlobal("FramesAgo11y", GetGlobal("FramesAgo10y"))
			SetGlobal("FramesAgo10y", GetGlobal("FramesAgo9y"))
			SetGlobal("FramesAgo9y", GetGlobal("FramesAgo8y"))
			SetGlobal("FramesAgo8y", GetGlobal("FramesAgo7y"))
			SetGlobal("FramesAgo7y", GetGlobal("FramesAgo6y"))
			SetGlobal("FramesAgo6y", GetGlobal("FramesAgo5y"))
			SetGlobal("FramesAgo5y", GetGlobal("FramesAgo4y"))
			SetGlobal("FramesAgo4y", GetGlobal("FramesAgo3y"))
			SetGlobal("FramesAgo3y", GetGlobal("FramesAgo2y"))
			SetGlobal("FramesAgo2y", GetGlobal("FramesAgo1y"))
			SetGlobal("FramesAgo1y", Player.y)


			SetGlobal("FramesAgo60x", GetGlobal("FramesAgo59x"))
			SetGlobal("FramesAgo59x", GetGlobal("FramesAgo58x"))
			SetGlobal("FramesAgo58x", GetGlobal("FramesAgo57x"))
			SetGlobal("FramesAgo57x", GetGlobal("FramesAgo56x"))
			SetGlobal("FramesAgo56x", GetGlobal("FramesAgo55x"))
			SetGlobal("FramesAgo55x", GetGlobal("FramesAgo54x"))
			SetGlobal("FramesAgo54x", GetGlobal("FramesAgo53x"))
			SetGlobal("FramesAgo53x", GetGlobal("FramesAgo52x"))
			SetGlobal("FramesAgo52x", GetGlobal("FramesAgo51x"))
			SetGlobal("FramesAgo51x", GetGlobal("FramesAgo50x"))
			SetGlobal("FramesAgo50x", GetGlobal("FramesAgo49x"))
			SetGlobal("FramesAgo49x", GetGlobal("FramesAgo48x"))
			SetGlobal("FramesAgo48x", GetGlobal("FramesAgo47x"))
			SetGlobal("FramesAgo47x", GetGlobal("FramesAgo46x"))
			SetGlobal("FramesAgo46x", GetGlobal("FramesAgo45x"))
			SetGlobal("FramesAgo45x", GetGlobal("FramesAgo44x"))

			SetGlobal("FramesAgo44x", GetGlobal("FramesAgo43x"))
			SetGlobal("FramesAgo43x", GetGlobal("FramesAgo42x"))
			SetGlobal("FramesAgo42x", GetGlobal("FramesAgo41x"))
			SetGlobal("FramesAgo41x", GetGlobal("FramesAgo40x"))
			SetGlobal("FramesAgo40x", GetGlobal("FramesAgo39x"))
			SetGlobal("FramesAgo39x", GetGlobal("FramesAgo38x"))
			SetGlobal("FramesAgo38x", GetGlobal("FramesAgo37x"))
			SetGlobal("FramesAgo37x", GetGlobal("FramesAgo36x"))
			SetGlobal("FramesAgo36x", GetGlobal("FramesAgo35x"))
			SetGlobal("FramesAgo35x", GetGlobal("FramesAgo34x"))
			SetGlobal("FramesAgo34x", GetGlobal("FramesAgo33x"))
			SetGlobal("FramesAgo33x", GetGlobal("FramesAgo32x"))
			SetGlobal("FramesAgo32x", GetGlobal("FramesAgo31x"))
			SetGlobal("FramesAgo31x", GetGlobal("FramesAgo30x"))
			SetGlobal("FramesAgo30x", GetGlobal("FramesAgo29x"))
			SetGlobal("FramesAgo29x", GetGlobal("FramesAgo28x"))

			SetGlobal("FramesAgo28x", GetGlobal("FramesAgo27x"))
			SetGlobal("FramesAgo27x", GetGlobal("FramesAgo26x"))
			SetGlobal("FramesAgo26x", GetGlobal("FramesAgo25x"))
			SetGlobal("FramesAgo25x", GetGlobal("FramesAgo24x"))
			SetGlobal("FramesAgo24x", GetGlobal("FramesAgo23x"))
			SetGlobal("FramesAgo23x", GetGlobal("FramesAgo22x"))
			SetGlobal("FramesAgo22x", GetGlobal("FramesAgo21x"))
			SetGlobal("FramesAgo21x", GetGlobal("FramesAgo20x"))
			SetGlobal("FramesAgo20x", GetGlobal("FramesAgo19x"))
			SetGlobal("FramesAgo19x", GetGlobal("FramesAgo18x"))
			SetGlobal("FramesAgo18x", GetGlobal("FramesAgo17x"))
			SetGlobal("FramesAgo17x", GetGlobal("FramesAgo16x"))
			SetGlobal("FramesAgo16x", GetGlobal("FramesAgo15x"))
			SetGlobal("FramesAgo15x", GetGlobal("FramesAgo14x"))
			SetGlobal("FramesAgo14x", GetGlobal("FramesAgo13x"))
			SetGlobal("FramesAgo13x", GetGlobal("FramesAgo12x"))

			SetGlobal("FramesAgo12x", GetGlobal("FramesAgo11x"))
			SetGlobal("FramesAgo11x", GetGlobal("FramesAgo10x"))
			SetGlobal("FramesAgo10x", GetGlobal("FramesAgo9x"))
			SetGlobal("FramesAgo9x", GetGlobal("FramesAgo8x"))
			SetGlobal("FramesAgo8x", GetGlobal("FramesAgo7x"))
			SetGlobal("FramesAgo7x", GetGlobal("FramesAgo6x"))
			SetGlobal("FramesAgo6x", GetGlobal("FramesAgo5x"))
			SetGlobal("FramesAgo5x", GetGlobal("FramesAgo4x"))
			SetGlobal("FramesAgo4x", GetGlobal("FramesAgo3x"))
			SetGlobal("FramesAgo3x", GetGlobal("FramesAgo2x"))
			SetGlobal("FramesAgo2x", GetGlobal("FramesAgo1x"))
			SetGlobal("FramesAgo1x", Player.x)

		--if GetGlobal("FireTrailTimer") > 0 then
		--	SetGlobal("FireTrailTimer", GetGlobal("FireTrailTimer") - 1)
		--else
			--SetGlobal("FireTrailTimer", 10)
			if Encounter.GetVar("burnresistance") ~= true and GetGlobal("HasExtraLife") ~= true and HasExtraLife2 == GetGlobal("HasExtraLife") and timer >= 60 then
				if bullet2b ~= nil then
					if bullet2b.x + 15 > Player.x and bullet2b.x - 15 < Player.x and bullet2b.y + 15 > Player.y and bullet2b.y - 15 < Player.y then
							--if bullet2b.selfAbs.Overlaps(PlayerController.instance.playerAbs) then
								NewAudio.Play("Hits")
								--SetGlobal("LastHitX",Player.x)
								--SetGlobal("LastHitY",Player.y)	
								if Encounter.GetVar("ghostresistance") then
									SetGlobal("burn", GetGlobal("burn") + 0.65)
								else
									SetGlobal("burn", GetGlobal("burn") + 0.35)
								end
								--SetGlobal("curse", GetGlobal("curse") + 1)
								--bullet2b.SetVar('canDamage', 0)
								--bullet2b.Enabled = false
								--bullet2b.Remove()
								--bullet2b = nil
								--bullet2b.sprite.color={1,0.35,0}
								--bullet2b.sprite.alpha = 0.35
							end
						--end
						--end

						--if bullet2b.GetVar('timer') == 50 then
							--bullet2b.sprite.color={1,0.5,0}
						--bullet2b.SetVar('canDamage', 1)
						--end	

						--if bullet2b.GetVar('timer') >= 10 then
							--bullet2b.sprite.alpha = 0
							--bullet2b.SetVar('canDamage', 0)
							--bullet2b.sprite.color={1,0.35,0}
							--bullet2b.Enabled = false
							bullet2b.Remove()
							bullet2b = nil
				end
				bullet2b = CreateProjectile('bullet', GetGlobal("FramesAgo60x"), GetGlobal("FramesAgo60y"))
				--local bullet2b = CreateProjectile('bullet', GetGlobal("FramesAgo10x"), GetGlobal("FramesAgo10y"))
				--local bullet2b = CreateProjectile('bullet', Player.x, Player.y)
				bullet2b.SetVar("color","fire2")
				bullet2b.SetVar('vely', 0)
				bullet2b.SetVar('velx', 0)
				bullet2b.SetVar('vely2', 0)
				bullet2b.SetVar('timer', 0)
				bullet2b.SetVar('canDamage', 0)
				bullet2b.sprite.alpha = 0.85
				bullet2b.sprite.color={1,0.5,0}
				--table.insert(bullet2bs, bullet2b)
				--for i=1, #bullet2bs do
					--local bullet2b = bullet2bs[i]
					--if bullet2b.GetVar("canDamage") ~= nil and bullet2b ~= nil then
						--local velx = bullet2b.GetVar('velx')
						--local vely = bullet2b.GetVar('vely')
						--bullet2b.SetVar('vely2', 1)
						--local newposx = bullet2b.x + velx
						--local newposy = bullet2b.y + vely
						--vely = vely
						--bullet2b.MoveTo(newposx, newposy)
						--bullet2b.SetVar('vely', vely)

						--bullet2b.SetVar('timer', bullet2b.GetVar('timer') + 1)

						--if bullet2b.GetVar('timer') == 40 then
						--	bullet2b.sprite.color={1,0.75,0}
						--end	

						--if bullet2b.sprite.alpha < 0.8 and  bullet2b.sprite.alpha > 0 then
						--	bullet2b.sprite.alpha = bullet2b.sprite.alpha + 0.01
						--end

						--if bullet2b.GetVar("timer") < 50 then
						--	bullet2b.SetVar('canDamage', 0)
						--else
						--if bullet2b.GetVar('canDamage') == 1 then
						--end
					--end
				--end
			end
			--CreateProjectile("system/BR", Player.x, Player.y)
		--end

		if GetGlobal("curse2") ~= 2 and Input.Cancel==0 then
			if GetGlobal("BlackHolePushOrPullMode") == 1 then
				if GetGlobal("LastHitY")<Player.y then
				Player.MoveTo(Player.x,Player.y+0.2,false)
				elseif GetGlobal("LastHitY")>Player.y then
				Player.MoveTo(Player.x,Player.y-0.2,false)
				end
				Player.MoveTo(Player.x,Player.y,false)

				if GetGlobal("LastHitX")<Player.x then
				Player.MoveTo(Player.x+0.2,Player.y,false)
				elseif GetGlobal("LastHitX")>Player.x then
				Player.MoveTo(Player.x-0.2,Player.y,false)
				end

				if 0<Player.y then
				Player.MoveTo(Player.x,Player.y+0.1,false)
				elseif 0>Player.y then
				Player.MoveTo(Player.x,Player.y-0.1,false)
				end
				Player.MoveTo(Player.x,Player.y,false)

				if 0<Player.x then
				Player.MoveTo(Player.x+0.1,Player.y,false)
				elseif 0>Player.x then
				Player.MoveTo(Player.x-0.1,Player.y,false)
				end
			else
				if GetGlobal("LastHitY")<Player.y then
				Player.MoveTo(Player.x,Player.y-0.2,false)
				elseif GetGlobal("LastHitY")>Player.y then
				Player.MoveTo(Player.x,Player.y+0.2,false)
				end
				Player.MoveTo(Player.x,Player.y,false)

				if GetGlobal("LastHitX")<Player.x then
				Player.MoveTo(Player.x-0.2,Player.y,false)
				elseif GetGlobal("LastHitX")>Player.x then
				Player.MoveTo(Player.x+0.2,Player.y,false)
				end

				if 0<Player.y then
				Player.MoveTo(Player.x,Player.y-0.1,false)
				elseif 0>Player.y then
				Player.MoveTo(Player.x,Player.y+0.1,false)
				end
				Player.MoveTo(Player.x,Player.y,false)

				if 0<Player.x then
				Player.MoveTo(Player.x-0.1,Player.y,false)
				elseif 0>Player.x then
				Player.MoveTo(Player.x+0.1,Player.y,false)
				end
			end
		end

		if Input.Up==0 and Input.Down>0 then
			Player.MoveTo(Player.x,Player.y-movespeed,false)
			elseif Input.Up>0 and Input.Down==0 then
			Player.MoveTo(Player.x,Player.y+movespeed,false)
		end

		if Input.Right==0 and Input.Left>0 then
			Player.MoveTo(Player.x-movespeed,Player.y,false)
			elseif Input.Right>0 and Input.Left==0 then
			Player.MoveTo(Player.x+movespeed,Player.y,false)
		end
	
	else

		if Encounter.GetVar("diff") == 16 then
			if Encounter.GetVar("movefast")==true then
			speed=5
			else speed=3
			end
			if GetGlobal("LastHitY")<Player.y then
			playerY2 = Player.y - 5
			elseif GetGlobal("LastHitY")>Player.y then
			playerY2 = Player.y + 5
			else
			playerY2 = 0
			end

			if GetGlobal("LastHitX")<Player.x then
				playerX2 = Player.x - 5
				elseif GetGlobal("LastHitX")>Player.x then
				playerX2 = Player.x + 5
				else
				playerX2 = 0
			end
			SetGlobal("FramesAgo60y", GetGlobal("FramesAgo59y"))
			SetGlobal("FramesAgo59y", GetGlobal("FramesAgo58y"))
			SetGlobal("FramesAgo58y", GetGlobal("FramesAgo57y"))
			SetGlobal("FramesAgo57y", GetGlobal("FramesAgo56y"))
			SetGlobal("FramesAgo56y", GetGlobal("FramesAgo55y"))
			SetGlobal("FramesAgo55y", GetGlobal("FramesAgo54y"))
			SetGlobal("FramesAgo54y", GetGlobal("FramesAgo53y"))
			SetGlobal("FramesAgo53y", GetGlobal("FramesAgo52y"))
			SetGlobal("FramesAgo52y", GetGlobal("FramesAgo51y"))
			SetGlobal("FramesAgo51y", GetGlobal("FramesAgo50y"))
			SetGlobal("FramesAgo50y", GetGlobal("FramesAgo49y"))
			SetGlobal("FramesAgo49y", GetGlobal("FramesAgo48y"))
			SetGlobal("FramesAgo48y", GetGlobal("FramesAgo47y"))
			SetGlobal("FramesAgo47y", GetGlobal("FramesAgo46y"))
			SetGlobal("FramesAgo46y", GetGlobal("FramesAgo45y"))
			SetGlobal("FramesAgo45y", GetGlobal("FramesAgo44y"))

			SetGlobal("FramesAgo44y", GetGlobal("FramesAgo43y"))
			SetGlobal("FramesAgo43y", GetGlobal("FramesAgo42y"))
			SetGlobal("FramesAgo42y", GetGlobal("FramesAgo41y"))
			SetGlobal("FramesAgo41y", GetGlobal("FramesAgo40y"))
			SetGlobal("FramesAgo40y", GetGlobal("FramesAgo39y"))
			SetGlobal("FramesAgo39y", GetGlobal("FramesAgo38y"))
			SetGlobal("FramesAgo38y", GetGlobal("FramesAgo37y"))
			SetGlobal("FramesAgo37y", GetGlobal("FramesAgo36y"))
			SetGlobal("FramesAgo36y", GetGlobal("FramesAgo35y"))
			SetGlobal("FramesAgo35y", GetGlobal("FramesAgo34y"))
			SetGlobal("FramesAgo34y", GetGlobal("FramesAgo33y"))
			SetGlobal("FramesAgo33y", GetGlobal("FramesAgo32y"))
			SetGlobal("FramesAgo32y", GetGlobal("FramesAgo31y"))
			SetGlobal("FramesAgo31y", GetGlobal("FramesAgo30y"))
			SetGlobal("FramesAgo30y", GetGlobal("FramesAgo29y"))
			SetGlobal("FramesAgo29y", GetGlobal("FramesAgo28y"))

			SetGlobal("FramesAgo28y", GetGlobal("FramesAgo27y"))
			SetGlobal("FramesAgo27y", GetGlobal("FramesAgo26y"))
			SetGlobal("FramesAgo26y", GetGlobal("FramesAgo25y"))
			SetGlobal("FramesAgo25y", GetGlobal("FramesAgo24y"))
			SetGlobal("FramesAgo24y", GetGlobal("FramesAgo23y"))
			SetGlobal("FramesAgo23y", GetGlobal("FramesAgo22y"))
			SetGlobal("FramesAgo22y", GetGlobal("FramesAgo21y"))
			SetGlobal("FramesAgo21y", GetGlobal("FramesAgo20y"))
			SetGlobal("FramesAgo20y", GetGlobal("FramesAgo19y"))
			SetGlobal("FramesAgo19y", GetGlobal("FramesAgo18y"))
			SetGlobal("FramesAgo18y", GetGlobal("FramesAgo17y"))
			SetGlobal("FramesAgo17y", GetGlobal("FramesAgo16y"))
			SetGlobal("FramesAgo16y", GetGlobal("FramesAgo15y"))
			SetGlobal("FramesAgo15y", GetGlobal("FramesAgo14y"))
			SetGlobal("FramesAgo14y", GetGlobal("FramesAgo13y"))
			SetGlobal("FramesAgo13y", GetGlobal("FramesAgo12y"))

			SetGlobal("FramesAgo12y", GetGlobal("FramesAgo11y"))
			SetGlobal("FramesAgo11y", GetGlobal("FramesAgo10y"))
			SetGlobal("FramesAgo10y", GetGlobal("FramesAgo9y"))
			SetGlobal("FramesAgo9y", GetGlobal("FramesAgo8y"))
			SetGlobal("FramesAgo8y", GetGlobal("FramesAgo7y"))
			SetGlobal("FramesAgo7y", GetGlobal("FramesAgo6y"))
			SetGlobal("FramesAgo6y", GetGlobal("FramesAgo5y"))
			SetGlobal("FramesAgo5y", GetGlobal("FramesAgo4y"))
			SetGlobal("FramesAgo4y", GetGlobal("FramesAgo3y"))
			SetGlobal("FramesAgo3y", GetGlobal("FramesAgo2y"))
			SetGlobal("FramesAgo2y", GetGlobal("FramesAgo1y"))
			SetGlobal("FramesAgo1y", playerY2)


			SetGlobal("FramesAgo60x", GetGlobal("FramesAgo59x"))
			SetGlobal("FramesAgo59x", GetGlobal("FramesAgo58x"))
			SetGlobal("FramesAgo58x", GetGlobal("FramesAgo57x"))
			SetGlobal("FramesAgo57x", GetGlobal("FramesAgo56x"))
			SetGlobal("FramesAgo56x", GetGlobal("FramesAgo55x"))
			SetGlobal("FramesAgo55x", GetGlobal("FramesAgo54x"))
			SetGlobal("FramesAgo54x", GetGlobal("FramesAgo53x"))
			SetGlobal("FramesAgo53x", GetGlobal("FramesAgo52x"))
			SetGlobal("FramesAgo52x", GetGlobal("FramesAgo51x"))
			SetGlobal("FramesAgo51x", GetGlobal("FramesAgo50x"))
			SetGlobal("FramesAgo50x", GetGlobal("FramesAgo49x"))
			SetGlobal("FramesAgo49x", GetGlobal("FramesAgo48x"))
			SetGlobal("FramesAgo48x", GetGlobal("FramesAgo47x"))
			SetGlobal("FramesAgo47x", GetGlobal("FramesAgo46x"))
			SetGlobal("FramesAgo46x", GetGlobal("FramesAgo45x"))
			SetGlobal("FramesAgo45x", GetGlobal("FramesAgo44x"))

			SetGlobal("FramesAgo44x", GetGlobal("FramesAgo43x"))
			SetGlobal("FramesAgo43x", GetGlobal("FramesAgo42x"))
			SetGlobal("FramesAgo42x", GetGlobal("FramesAgo41x"))
			SetGlobal("FramesAgo41x", GetGlobal("FramesAgo40x"))
			SetGlobal("FramesAgo40x", GetGlobal("FramesAgo39x"))
			SetGlobal("FramesAgo39x", GetGlobal("FramesAgo38x"))
			SetGlobal("FramesAgo38x", GetGlobal("FramesAgo37x"))
			SetGlobal("FramesAgo37x", GetGlobal("FramesAgo36x"))
			SetGlobal("FramesAgo36x", GetGlobal("FramesAgo35x"))
			SetGlobal("FramesAgo35x", GetGlobal("FramesAgo34x"))
			SetGlobal("FramesAgo34x", GetGlobal("FramesAgo33x"))
			SetGlobal("FramesAgo33x", GetGlobal("FramesAgo32x"))
			SetGlobal("FramesAgo32x", GetGlobal("FramesAgo31x"))
			SetGlobal("FramesAgo31x", GetGlobal("FramesAgo30x"))
			SetGlobal("FramesAgo30x", GetGlobal("FramesAgo29x"))
			SetGlobal("FramesAgo29x", GetGlobal("FramesAgo28x"))

			SetGlobal("FramesAgo28x", GetGlobal("FramesAgo27x"))
			SetGlobal("FramesAgo27x", GetGlobal("FramesAgo26x"))
			SetGlobal("FramesAgo26x", GetGlobal("FramesAgo25x"))
			SetGlobal("FramesAgo25x", GetGlobal("FramesAgo24x"))
			SetGlobal("FramesAgo24x", GetGlobal("FramesAgo23x"))
			SetGlobal("FramesAgo23x", GetGlobal("FramesAgo22x"))
			SetGlobal("FramesAgo22x", GetGlobal("FramesAgo21x"))
			SetGlobal("FramesAgo21x", GetGlobal("FramesAgo20x"))
			SetGlobal("FramesAgo20x", GetGlobal("FramesAgo19x"))
			SetGlobal("FramesAgo19x", GetGlobal("FramesAgo18x"))
			SetGlobal("FramesAgo18x", GetGlobal("FramesAgo17x"))
			SetGlobal("FramesAgo17x", GetGlobal("FramesAgo16x"))
			SetGlobal("FramesAgo16x", GetGlobal("FramesAgo15x"))
			SetGlobal("FramesAgo15x", GetGlobal("FramesAgo14x"))
			SetGlobal("FramesAgo14x", GetGlobal("FramesAgo13x"))
			SetGlobal("FramesAgo13x", GetGlobal("FramesAgo12x"))

			SetGlobal("FramesAgo12x", GetGlobal("FramesAgo11x"))
			SetGlobal("FramesAgo11x", GetGlobal("FramesAgo10x"))
			SetGlobal("FramesAgo10x", GetGlobal("FramesAgo9x"))
			SetGlobal("FramesAgo9x", GetGlobal("FramesAgo8x"))
			SetGlobal("FramesAgo8x", GetGlobal("FramesAgo7x"))
			SetGlobal("FramesAgo7x", GetGlobal("FramesAgo6x"))
			SetGlobal("FramesAgo6x", GetGlobal("FramesAgo5x"))
			SetGlobal("FramesAgo5x", GetGlobal("FramesAgo4x"))
			SetGlobal("FramesAgo4x", GetGlobal("FramesAgo3x"))
			SetGlobal("FramesAgo3x", GetGlobal("FramesAgo2x"))
			SetGlobal("FramesAgo2x", GetGlobal("FramesAgo1x"))
			SetGlobal("FramesAgo1x", playerX2)

			if GetGlobal("FramesAgo60y")<Player.y then
				Player.MoveTo(Player.x,Player.y-0.65,false)
				elseif GetGlobal("FramesAgo60y")>Player.y then
				Player.MoveTo(Player.x,Player.y+0.65,false)
			end
			Player.MoveTo(Player.x,Player.y,false)

			if GetGlobal("FramesAgo60x")<Player.x then
				Player.MoveTo(Player.x-0.65,Player.y,false)
				elseif GetGlobal("FramesAgo60x")>Player.x then
				Player.MoveTo(Player.x+0.65,Player.y,false)
			end

			if GetGlobal("LastHitY")<Player.y then
				Player.MoveTo(Player.x,Player.y-0.1,false)
				elseif GetGlobal("LastHitY")>Player.y then
				Player.MoveTo(Player.x,Player.y+0.1,false)
			end
			Player.MoveTo(Player.x,Player.y,false)

			if GetGlobal("LastHitX")<Player.x then
				Player.MoveTo(Player.x-0.1,Player.y,false)
				elseif GetGlobal("LastHitX")>Player.x then
				Player.MoveTo(Player.x+0.1,Player.y,false)
			end

			if 0<Player.y then
				Player.MoveTo(Player.x,Player.y-0.25,false)
				elseif 0>Player.y then
				Player.MoveTo(Player.x,Player.y+0.25,false)
			end
			Player.MoveTo(Player.x,Player.y,false)

			if 0<Player.x then
				Player.MoveTo(Player.x-0.25,Player.y,false)
				elseif 0>Player.x then
				Player.MoveTo(Player.x+0.25,Player.y,false)
			end
		end --else
		if Encounter.GetVar("diff") == 15 then
			if Encounter.GetVar("movefast")==true then
			speed=4
			else speed=3
			end
			SetGlobal("FramesAgo60y", GetGlobal("FramesAgo59y"))
			SetGlobal("FramesAgo59y", GetGlobal("FramesAgo58y"))
			SetGlobal("FramesAgo58y", GetGlobal("FramesAgo57y"))
			SetGlobal("FramesAgo57y", GetGlobal("FramesAgo56y"))
			SetGlobal("FramesAgo56y", GetGlobal("FramesAgo55y"))
			SetGlobal("FramesAgo55y", GetGlobal("FramesAgo54y"))
			SetGlobal("FramesAgo54y", GetGlobal("FramesAgo53y"))
			SetGlobal("FramesAgo53y", GetGlobal("FramesAgo52y"))
			SetGlobal("FramesAgo52y", GetGlobal("FramesAgo51y"))
			SetGlobal("FramesAgo51y", GetGlobal("FramesAgo50y"))
			SetGlobal("FramesAgo50y", GetGlobal("FramesAgo49y"))
			SetGlobal("FramesAgo49y", GetGlobal("FramesAgo48y"))
			SetGlobal("FramesAgo48y", GetGlobal("FramesAgo47y"))
			SetGlobal("FramesAgo47y", GetGlobal("FramesAgo46y"))
			SetGlobal("FramesAgo46y", GetGlobal("FramesAgo45y"))
			SetGlobal("FramesAgo45y", GetGlobal("FramesAgo44y"))

			SetGlobal("FramesAgo44y", GetGlobal("FramesAgo43y"))
			SetGlobal("FramesAgo43y", GetGlobal("FramesAgo42y"))
			SetGlobal("FramesAgo42y", GetGlobal("FramesAgo41y"))
			SetGlobal("FramesAgo41y", GetGlobal("FramesAgo40y"))
			SetGlobal("FramesAgo40y", GetGlobal("FramesAgo39y"))
			SetGlobal("FramesAgo39y", GetGlobal("FramesAgo38y"))
			SetGlobal("FramesAgo38y", GetGlobal("FramesAgo37y"))
			SetGlobal("FramesAgo37y", GetGlobal("FramesAgo36y"))
			SetGlobal("FramesAgo36y", GetGlobal("FramesAgo35y"))
			SetGlobal("FramesAgo35y", GetGlobal("FramesAgo34y"))
			SetGlobal("FramesAgo34y", GetGlobal("FramesAgo33y"))
			SetGlobal("FramesAgo33y", GetGlobal("FramesAgo32y"))
			SetGlobal("FramesAgo32y", GetGlobal("FramesAgo31y"))
			SetGlobal("FramesAgo31y", GetGlobal("FramesAgo30y"))
			SetGlobal("FramesAgo30y", GetGlobal("FramesAgo29y"))
			SetGlobal("FramesAgo29y", GetGlobal("FramesAgo28y"))

			SetGlobal("FramesAgo28y", GetGlobal("FramesAgo27y"))
			SetGlobal("FramesAgo27y", GetGlobal("FramesAgo26y"))
			SetGlobal("FramesAgo26y", GetGlobal("FramesAgo25y"))
			SetGlobal("FramesAgo25y", GetGlobal("FramesAgo24y"))
			SetGlobal("FramesAgo24y", GetGlobal("FramesAgo23y"))
			SetGlobal("FramesAgo23y", GetGlobal("FramesAgo22y"))
			SetGlobal("FramesAgo22y", GetGlobal("FramesAgo21y"))
			SetGlobal("FramesAgo21y", GetGlobal("FramesAgo20y"))
			SetGlobal("FramesAgo20y", GetGlobal("FramesAgo19y"))
			SetGlobal("FramesAgo19y", GetGlobal("FramesAgo18y"))
			SetGlobal("FramesAgo18y", GetGlobal("FramesAgo17y"))
			SetGlobal("FramesAgo17y", GetGlobal("FramesAgo16y"))
			SetGlobal("FramesAgo16y", GetGlobal("FramesAgo15y"))
			SetGlobal("FramesAgo15y", GetGlobal("FramesAgo14y"))
			SetGlobal("FramesAgo14y", GetGlobal("FramesAgo13y"))
			SetGlobal("FramesAgo13y", GetGlobal("FramesAgo12y"))

			SetGlobal("FramesAgo12y", GetGlobal("FramesAgo11y"))
			SetGlobal("FramesAgo11y", GetGlobal("FramesAgo10y"))
			SetGlobal("FramesAgo10y", GetGlobal("FramesAgo9y"))
			SetGlobal("FramesAgo9y", GetGlobal("FramesAgo8y"))
			SetGlobal("FramesAgo8y", GetGlobal("FramesAgo7y"))
			SetGlobal("FramesAgo7y", GetGlobal("FramesAgo6y"))
			SetGlobal("FramesAgo6y", GetGlobal("FramesAgo5y"))
			SetGlobal("FramesAgo5y", GetGlobal("FramesAgo4y"))
			SetGlobal("FramesAgo4y", GetGlobal("FramesAgo3y"))
			SetGlobal("FramesAgo3y", GetGlobal("FramesAgo2y"))
			SetGlobal("FramesAgo2y", GetGlobal("FramesAgo1y"))
			SetGlobal("FramesAgo1y", Player.y)


			SetGlobal("FramesAgo60x", GetGlobal("FramesAgo59x"))
			SetGlobal("FramesAgo59x", GetGlobal("FramesAgo58x"))
			SetGlobal("FramesAgo58x", GetGlobal("FramesAgo57x"))
			SetGlobal("FramesAgo57x", GetGlobal("FramesAgo56x"))
			SetGlobal("FramesAgo56x", GetGlobal("FramesAgo55x"))
			SetGlobal("FramesAgo55x", GetGlobal("FramesAgo54x"))
			SetGlobal("FramesAgo54x", GetGlobal("FramesAgo53x"))
			SetGlobal("FramesAgo53x", GetGlobal("FramesAgo52x"))
			SetGlobal("FramesAgo52x", GetGlobal("FramesAgo51x"))
			SetGlobal("FramesAgo51x", GetGlobal("FramesAgo50x"))
			SetGlobal("FramesAgo50x", GetGlobal("FramesAgo49x"))
			SetGlobal("FramesAgo49x", GetGlobal("FramesAgo48x"))
			SetGlobal("FramesAgo48x", GetGlobal("FramesAgo47x"))
			SetGlobal("FramesAgo47x", GetGlobal("FramesAgo46x"))
			SetGlobal("FramesAgo46x", GetGlobal("FramesAgo45x"))
			SetGlobal("FramesAgo45x", GetGlobal("FramesAgo44x"))

			SetGlobal("FramesAgo44x", GetGlobal("FramesAgo43x"))
			SetGlobal("FramesAgo43x", GetGlobal("FramesAgo42x"))
			SetGlobal("FramesAgo42x", GetGlobal("FramesAgo41x"))
			SetGlobal("FramesAgo41x", GetGlobal("FramesAgo40x"))
			SetGlobal("FramesAgo40x", GetGlobal("FramesAgo39x"))
			SetGlobal("FramesAgo39x", GetGlobal("FramesAgo38x"))
			SetGlobal("FramesAgo38x", GetGlobal("FramesAgo37x"))
			SetGlobal("FramesAgo37x", GetGlobal("FramesAgo36x"))
			SetGlobal("FramesAgo36x", GetGlobal("FramesAgo35x"))
			SetGlobal("FramesAgo35x", GetGlobal("FramesAgo34x"))
			SetGlobal("FramesAgo34x", GetGlobal("FramesAgo33x"))
			SetGlobal("FramesAgo33x", GetGlobal("FramesAgo32x"))
			SetGlobal("FramesAgo32x", GetGlobal("FramesAgo31x"))
			SetGlobal("FramesAgo31x", GetGlobal("FramesAgo30x"))
			SetGlobal("FramesAgo30x", GetGlobal("FramesAgo29x"))
			SetGlobal("FramesAgo29x", GetGlobal("FramesAgo28x"))

			SetGlobal("FramesAgo28x", GetGlobal("FramesAgo27x"))
			SetGlobal("FramesAgo27x", GetGlobal("FramesAgo26x"))
			SetGlobal("FramesAgo26x", GetGlobal("FramesAgo25x"))
			SetGlobal("FramesAgo25x", GetGlobal("FramesAgo24x"))
			SetGlobal("FramesAgo24x", GetGlobal("FramesAgo23x"))
			SetGlobal("FramesAgo23x", GetGlobal("FramesAgo22x"))
			SetGlobal("FramesAgo22x", GetGlobal("FramesAgo21x"))
			SetGlobal("FramesAgo21x", GetGlobal("FramesAgo20x"))
			SetGlobal("FramesAgo20x", GetGlobal("FramesAgo19x"))
			SetGlobal("FramesAgo19x", GetGlobal("FramesAgo18x"))
			SetGlobal("FramesAgo18x", GetGlobal("FramesAgo17x"))
			SetGlobal("FramesAgo17x", GetGlobal("FramesAgo16x"))
			SetGlobal("FramesAgo16x", GetGlobal("FramesAgo15x"))
			SetGlobal("FramesAgo15x", GetGlobal("FramesAgo14x"))
			SetGlobal("FramesAgo14x", GetGlobal("FramesAgo13x"))
			SetGlobal("FramesAgo13x", GetGlobal("FramesAgo12x"))

			SetGlobal("FramesAgo12x", GetGlobal("FramesAgo11x"))
			SetGlobal("FramesAgo11x", GetGlobal("FramesAgo10x"))
			SetGlobal("FramesAgo10x", GetGlobal("FramesAgo9x"))
			SetGlobal("FramesAgo9x", GetGlobal("FramesAgo8x"))
			SetGlobal("FramesAgo8x", GetGlobal("FramesAgo7x"))
			SetGlobal("FramesAgo7x", GetGlobal("FramesAgo6x"))
			SetGlobal("FramesAgo6x", GetGlobal("FramesAgo5x"))
			SetGlobal("FramesAgo5x", GetGlobal("FramesAgo4x"))
			SetGlobal("FramesAgo4x", GetGlobal("FramesAgo3x"))
			SetGlobal("FramesAgo3x", GetGlobal("FramesAgo2x"))
			SetGlobal("FramesAgo2x", GetGlobal("FramesAgo1x"))
			SetGlobal("FramesAgo1x", Player.x)

			if GetGlobal("FramesAgo60y")<Player.y then
				Player.MoveTo(Player.x,Player.y-1,false)
				elseif GetGlobal("FramesAgo60y")>Player.y then
				Player.MoveTo(Player.x,Player.y+1,false)
			end
			Player.MoveTo(Player.x,Player.y,false)

			if GetGlobal("FramesAgo60x")<Player.x then
				Player.MoveTo(Player.x-1,Player.y,false)
				elseif GetGlobal("FramesAgo60x")>Player.x then
				Player.MoveTo(Player.x+1,Player.y,false)
			end
		end --else
		if Encounter.GetVar("diff") == 14 then
			if Encounter.GetVar("movefast")==true then
			speed=4
			else speed=3
			end
			if GetGlobal("LastHitY")<Player.y then
				Player.MoveTo(Player.x,Player.y-1,false)
				elseif GetGlobal("LastHitY")>Player.y then
				Player.MoveTo(Player.x,Player.y+1,false)
			end
			Player.MoveTo(Player.x,Player.y,false)

			if GetGlobal("LastHitX")<Player.x then
				Player.MoveTo(Player.x-1,Player.y,false)
				elseif GetGlobal("LastHitX")>Player.x then
				Player.MoveTo(Player.x+1,Player.y,false)
			end
		end --else
		if Encounter.GetVar("diff") == 13 then
			if Encounter.GetVar("movefast")==true then
				speed=4
			else speed=3
			end
			if 0<Player.y then
				Player.MoveTo(Player.x,Player.y-1,false)
				elseif 0>Player.y then
				Player.MoveTo(Player.x,Player.y+1,false)
			end
			Player.MoveTo(Player.x,Player.y,false)

			if 0<Player.x then
				Player.MoveTo(Player.x-1,Player.y,false)
				elseif 0>Player.x then
				Player.MoveTo(Player.x+1,Player.y,false)
			end
		end --else

		if Input.Cancel==0 then
			movespeed=speed
			else
			movespeed=speed/2
		end
		if GetGlobal("purpleSpeedTimer") > 0 then
			movespeed=movespeed/(GetGlobal("purpleSpeed")+1)
			SetGlobal("purpleSpeedTimer",GetGlobal("purpleSpeedTimer")-1)
		end
		if Input.Up==0 and Input.Down>0 then
			Player.MoveTo(Player.x,Player.y-movespeed,false)
			elseif Input.Up>0 and Input.Down==0 then
			Player.MoveTo(Player.x,Player.y+movespeed,false)
		end
		Player.MoveTo(Player.x,Player.y,false)

		if Input.Right==0 and Input.Left>0 then
			Player.MoveTo(Player.x-movespeed,Player.y,false)
			elseif Input.Right>0 and Input.Left==0 then
			Player.MoveTo(Player.x+movespeed,Player.y,false)
		end
	end
end

function isMoving()
	local moving=false

		if (Input.Up>0 and Input.Down==0) then--and Player.y<(Arena.height/2-8))
			moving=true
		end
		if (Input.Down>0 and Input.Up==0) then--and Player.y>(-Arena.height/2+8))
			moving=true
		end
		if (Input.Right>0 and Input.Left==0) then--and Player.x<(Arena.width/2-8))
			moving=true
		end
		if (Input.Left>0 and Input.Right==0) then--and Player.x>(-Arena.width/2+8))
			moving=true
		end
	return moving
end