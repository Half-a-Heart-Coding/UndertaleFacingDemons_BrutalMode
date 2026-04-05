local timer=0
local effected=2
local knifehurted=0
local soundtimer=0
local killed=false
local colortime=0
local FPL=nil
local knifetime=5
local longtime=12
local wavetimery=0
local ghosts={}
local ToCheck=Player.hp
local wons=Encounter.GetVar("wons")
local IsCursed=Encounter.GetVar("IsCursed")
local hurtedTimerThingy = 0

function DoGhost(name,side,time)
	local s="1.1.7/"
	local NEW=false
	if Encounter.GetVar("currentspr")=="1.2" then
		s="1.2/"
		NEW=true
	end
	local gh=CreateProjectileAbs(s..name,320,400,"BelowArena")
	if GetGlobal("evasion")==2 then
		gh.SetVar("delt",-100)
		else
		gh.SetVar("delt",0)
	end
	gh.sprite.SendToBottom()
	gh.sprite.alpha=0
	gh.SetVar("top",time)
	gh.SetVar("time",0)
	gh.SetVar("side",side)
	if NEW==false then
		gh.sprite.Scale(2,2)
	end
	if name=="smile" then
		gh.sprite.Scale(1.4,1.4)
	end
	table.insert(ghosts,gh)
end
	
function HeartChange(newcolor,sprite)
	Player.sprite.color=newcolor
	colortime=0
	if sprite==nil then
		FPL=CreateProjectile("ut-heart",Player.x,Player.y)
		FPL.sprite.color=newcolor
		else
		FPL=CreateProjectile(sprite,Player.x,Player.y)
		FPL.sprite.color={1,1,1}
	end
end

function c(b)
	local x=b.x
	local y=b.y
	local px=Player.x
	local py=Player.y
	local w=b.sprite.xscale*b.sprite.width/2+4
	local h=b.sprite.yscale*b.sprite.height/2+4
	local hitted=false
	if px-w<x and px+w>x and py-h<y and px+h>y then
		hitted=true
	end
	return hitted
end

function coll(b)
	local x=b.x
	local y=b.y
	local px=Player.x
	local py=Player.y
	local w=b.width/2+4
	local h=b.height/2+4
	local hitted=false
	if px-w<x and px+w>x and py-h<y and px+h>y then
		hitted=true
	end
	return hitted
end

function HurtUpd(ingo)
if #ghosts>0 then
	local count=0
	for i=1,#ghosts do
		local g=ghosts[i]
		if g.isactive then
			local delt=g.GetVar("delt")
			local time=g.GetVar("time")+1
			g.SetVar("time",time)
			local top=g.GetVar("top")
			local side=g.GetVar("side")
			g.sprite.alpha=math.sin(time*math.pi/top)
			if time-1<top/2 then
				g.MoveToAbs(delt+320+side*90*math.sin(time*math.pi/top),244+g.sprite.height/2*g.sprite.yscale)
				elseif time<top then
				g.MoveToAbs(delt+(320+180*side)-side*90*math.sin(time*math.pi/top),244+g.sprite.height/2*g.sprite.yscale)
				elseif time==top then
				g.Remove()
			end
			else
			count=count+1
		end
	end
	if count==#ghosts then
		ghosts={}
	end
end
effected=2
wavetimery=wavetimery+1
if knifetime<5 then
	knifetime=knifetime+1
end
if longtime<12 then
	longtime=longtime+1
end
if timer == 0 then
	if hurtedTimerThingy > 0 then
		hurtedTimerThingy = hurtedTimerThingy - 0.01
	end
end

if hurtedTimerThingy > 0 and GetGlobal("burn") < hurtedTimerThingy / 3 then
	SetGlobal("burn", hurtedTimerThingy / 3)
end

if hurtedTimerThingy < 0 then
	hurtedTimerThingy = 0
end

if hurtedTimerThingy > 13 then
	hurtedTimerThingy = 13
end

if Encounter.GetVar("diff") == 21 and not Encounter.GetVar("evrerythingModeEffect") == "Glass" then
	Player.name = "SHIFTY"
end

if Encounter.GetVar("diff") == 21 and Encounter.GetVar("evrerythingModeEffect") == "Glass" then
	local name2 = math.floor((hurtedTimerThingy + 0.5))
	--name2 = "[name2]"
	if name2 ~= nil then
		if name2 < 0 then
			name2 = 0
		end
		if name2 == 0 or name2 == 1 or name2 == 2 or name2 == 3 then
			Player.name = "STURDY"
		elseif name2 == 4 or name2 == 5 or name2 == 6 or name2 == 7 or name2 == 8 or name2 == 9 then
			Player.name = "FRAGI"
		elseif name2 == 10 or name2 == 11 or name2 == 12 or name2 == 13 then
			Player.name = "GLASS"
		end
	else
		if name2 == 0 then
			Player.name = "MAXEDSTURDY"
		elseif name2 == 1 then
			Player.name = "XTREMSTURDY"
		elseif name2 == 2 then
			Player.name = "VERYYSTURDY"
		elseif name2 == 3 then
			Player.name = "STURDYSTURDY"
		elseif name2 == 4 then
			Player.name = "LitleSTURDY"
		elseif name2 == 5 then
			Player.name = "MINEDSTURDY"
		elseif name2 == 6 then
			Player.name = "MINEDFRAGI"
		elseif name2 == 7 then
			Player.name = "KINDOFRAGI"
		elseif name2 == 8 then
			Player.name = "FRAGIFRAGI"
		elseif name2 == 9 then
			Player.name = "VERYYFRAGI"
		elseif name2 == 10 then
			Player.name = "XTREMFRAGI"
		elseif name2 == 11 then
			Player.name = "MAXEDFRAGI"
		elseif name2 == 12 then
			Player.name = "GLASSGLASS"
		end
	end

	--if hurtedTimerThingy == 0 then
	--	Player.lv = 60
	--end
end

if FPL==nil then
	else
	colortime=colortime+1
	FPL.sprite.Scale(1+5*math.sin(math.pi*colortime/60),1+5*math.sin(math.pi*colortime/60))
	FPL.sprite.alpha=1-math.sin(math.pi*colortime/60)
	FPL.MoveTo(Player.x,Player.y)
	FPL.sprite.rotation=Player.sprite.rotation
	if colortime>30 then
		FPL.Remove()
		FPL=nil
		colortime=0
	end
end

if timer>0 then
	if timer%20>10 then
		Player.sprite.alpha=0.5
		else
		Player.sprite.alpha=1
	end
	timer=timer-1
	if timer<0 then
		timer=0
	end
end
if knifehurted>0 then
	if wons==0 then
		if knifehurted>1 then
			knifehurted=1
			else
			knifehurted=0
		end
		else
		knifehurted=knifehurted-1
	end
end
if soundtimer>0 then
	soundtimer=soundtimer-1
end
if wavetimery==ingo then
	SetGlobal("charaisdead",0)
	EndWave()
end
end

function HurtSound()
	NewAudio.Play("Hits")
	if Encounter.GetVar("evreythingModeEffect") == "Hell" and Encounter.GetVar("diff") == 21 then
		if GetGlobal("BlackHolePushOrPullTimer") == 0 then
			if GetGlobal("BlackHolePushOrPullMode") == 1 then
				SetGlobal("BlackHolePushOrPullMode", 0)
			else
				SetGlobal("BlackHolePushOrPullMode", 1)
			end
			SetGlobal("BlackHolePushOrPullTimer", 30)
		end
	end
	SetGlobal("LastHitX",Player.x)
	SetGlobal("LastHitY",Player.y)
	if GetGlobal("BurningMode") ~= 0 then
		if GetGlobal("BurningMode") == -2 then
			if Player.hp < 135 then
				Player.Heal(1)
			end
		else
			Effects("burn", GetGlobal("BurningMode"))
		end
	end
end
function Hurttime()
	return timer
end
function KnifeHurt(damage,mom)
	local x=damage
	--if GetGlobal("ChoclateDamage") and damage < 50 and damage > 1 then
	--	x = damage - 1
	--end
	if x==nill then
		x=1
	end
	if mom==true then
		knifetime=0
	end
	if knifetime<5 then
		if (knifehurted%2==0 and knifehurted<6 and wons==0 ) or (wons==1 and knifehurted==0) then
			if wons==0 then
				knifehurted=knifehurted+2
				else
				knifehurted=15
			end
			if Player.hp>x then
				if GetGlobal("ConfusionMode") == 1 then
					if Player.hp < 99 then
						Player.Heal(1)
					end
				elseif Encounter.GetVar("diff") == 17 and Encounter.GetVar("ghostresistance") ~= true then
					SetGlobal("burn", GetGlobal("burn") + 0.5)
				elseif GetGlobal("FatalFire") ~= true then
					Player.hp=Player.hp-x
					if Encounter.GetVar("diff") == 21 and Encounter.GetVar("evrerythingModeEffect") == "Nightmare2" then
						if Player.hp>x then
							Player.hp=Player.hp-x
							Encounter.Call("PlayerHurted",x)
						else
							FakeDeath()
						end
					end
					if  Encounter.GetVar("ghostresistance") then
						timer = 2
					end

					if Encounter.GetVar("diff") == 21 and Encounter.GetVar("evrerythingModeEffect") == "Glass" then
						hurtedTimerThingy = hurtedTimerThingy + x / 2
						if hurtedTimerThingy > 9.5 then
							Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP") - 1)
							Encounter.SetVar("everythingModeTrueMaxHp", Encounter.GetVar("MaxHP"))
						elseif hurtedTimerThingy > 3.5 then
							--SetGlobal("burn",GetGlobal("burn") + x / 2)
							if Encounter.GetVar("burnresistance") or Encounter.GetVar("curseresistance") == true then
								SetGlobal("SavedBurn", GetGlobal("SavedBurn") + x / 3)
							else
								SetGlobal("SavedBurn", GetGlobal("SavedBurn") + x / 2)
							end
							--Effects("burn", x / 2)
							--hurtedTimerThingy = hurtedTimerThingy + x
						end
					end

					if Encounter.GetVar("diff") == 19 then
						hurtedTimerThingy = hurtedTimerThingy + x
						if hurtedTimerThingy > 9.5 then
							Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP") - 1)
						end
						if hurtedTimerThingy > 3.5 then
							--SetGlobal("burn",GetGlobal("burn") + x / 2)
							if Encounter.GetVar("burnresistance") or Encounter.GetVar("curseresistance") == true then
								SetGlobal("SavedBurn", GetGlobal("SavedBurn") + x / 2)
							else
								SetGlobal("SavedBurn", GetGlobal("SavedBurn") + x)
							end
							--Effects("burn", x / 2)
							--hurtedTimerThingy = hurtedTimerThingy + x
						end
					end
				else
					if Encounter.GetVar("burnresistance") == true then
						SetGlobal("SavedBurn", GetGlobal("SavedBurn") + 1)
					else
						SetGlobal("SavedBurn", GetGlobal("SavedBurn") + 2)
					end
				end
				HurtSound()
				Encounter.Call("PlayerHurted",x)
			else 
				x = (damage - Player.hp) + 1
				Player.hp = 1
				if GetGlobal("ChoclateDamage") and GetGlobal("ChoclateDamage") == true and Encounter.GetVar("MaxHP") > x then
					Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP") - x)
					HurtSound()
					--Encounter.Call("PlayerHurted",x)
				else
					FakeDeath()
				end
			end
		end
	end
	knifetime=0
end

function Effects(name,ammount)
	local n=ammount
	local effect=GetGlobal(name)
	if not effect then
		else
		if effected>0 and n>0 then
			if Encounter.GetVar(name.."resistance")==false then
				if name=="burn" or IsCursed==true then
					SetGlobal(name,effect+n)
				end
				else 
				if name=="burn" or IsCursed==true then
					SetGlobal(name,effect+n/2)
				end
			end
			effected=effected-1
		end
	end
end

function LongHurt(damage,time,trues)
	local t=time
	local d=damage
	if timer==0 then
		if Player.hp>d then
			if GetGlobal("ConfusionMode") == 1 then
				if Player.hp < 99 then
					Player.Heal(1)
				end
			elseif Encounter.GetVar("diff") == 17 and Encounter.GetVar("ghostresistance") ~= true then
					SetGlobal("burn", GetGlobal("burn") + 0.5)
			elseif GetGlobal("FatalFire") ~= true then
				Player.hp=Player.hp-d
				if Encounter.GetVar("diff") == 21 and Encounter.GetVar("evrerythingModeEffect") == "Nightmare2" then
					if Player.hp>d then
						Player.hp=Player.hp-d
						Encounter.Call("PlayerHurted",d)
					else
						FakeDeath()
					end
				end
				--if  Encounter.GetVar("ghostresistance") then
				--	timer = 2
				--end
				if Encounter.GetVar("diff") == 21 and Encounter.GetVar("evrerythingModeEffect") == "Glass" then
					hurtedTimerThingy = 13
					--if hurtedTimerThingy >= 10 then
						Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP")-math.floor((d + 1) / 2))
							Encounter.SetVar("everythingModeTrueMaxHp", Encounter.GetVar("MaxHP"))
					--end
				end

				if Encounter.GetVar("diff") == 19 then
					hurtedTimerThingy = 13
					--if hurtedTimerThingy >= 10 then
						Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP")-math.floor(d + 1))
					--end
				end
			else
				if Encounter.GetVar("burnresistance") == true then
					SetGlobal("SavedBurn", GetGlobal("SavedBurn") + 1)
				else
					SetGlobal("SavedBurn", GetGlobal("SavedBurn") + 2)
				end
			end
			Encounter.Call("PlayerHurted",d)
			if Encounter.GetVar("ghostresistance")==true then
				timer=math.floor(t/2*3)
				else
				timer=t
			end
			if damage>0 then
				HurtSound()
			end
		else	
			d = (damage - Player.hp) + 1
			Player.hp = 1
			if GetGlobal("ChoclateDamage") and GetGlobal("ChoclateDamage") == true and Encounter.GetVar("MaxHP") > d then
				Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP") - d)
				HurtSound()
				if Encounter.GetVar("ghostresistance")==true then
					timer=math.floor(t/2*3)
					else
					timer=t
				end
				--Encounter.Call("PlayerHurted",x)
			else
				FakeDeath()
			end
		end
	end
end


function FakeDeath()
	if GetGlobal("HasExtraLife") == true then
		SetGlobal("ConfusionMode", 0)
		Player.hp = 99
		SetGlobal("diffCurseChaosTimer", 0)
		SetGlobal("curse", 0)
		SetGlobal("HasExtraLife", false)
	else
		if killed==false then
			SetGlobal("Playerisdead",true)
			Arena.ResizeImmediate(565,130)
			EndWave()
			SetGlobal("nocomment",true)
			Encounter.Call("SetMusic","none")
			if not battlesprites then
				else
				for i=1,#battlesprites do
					battlesprites[i].Remove()
				end
			end
			killed=true
		end
	end
end
			
			
	