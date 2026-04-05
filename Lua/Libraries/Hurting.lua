local timer=0
local knifehurted=false
local soundtimer=0
local killed=false
local colortime=0
local FPL=nil
local wavetimery=0
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

function HurtUpd(ingo)
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
knifehurted=false
if soundtimer>0 then
	soundtimer=soundtimer-1
end
end

function HurtSound()
	NewAudio.Play("Hits")
end
function Hurttime()
	return timer
end
function KnifeHurt(damage)
	local x=damage
	if x==nill then
		x=1
	end
	if Player.hp>x then
		if knifehurted==false then
			if GetGlobal("FatalFire") ~= true then
				Player.hp=Player.hp-x
			else
				if Encounter.GetVar("burnresistance") == true then
					SetGlobal("SavedBurn", GetGlobal("SavedBurn") + 1)
				else
					SetGlobal("SavedBurn", GetGlobal("SavedBurn") + 2)
				end
			end
			if damage>0 then
				HurtSound()
			end
			Encounter.Call("PlayerHurted",x)
			knifehurted=true
		end
		else FakeDeath()
	end
end

function Effects(name,ammount)
	local n=ammount
	local effect=GetGlobal(name)
	if not effect then
		else
		if Encounter.GetVar(name.."resistance")==false then
			SetGlobal(name,effect+n)
			else SetGlobal(name,effect+(n/2))
		end
	end
end

function LongHurt(damage,time)
	local t=time
	local d=damage
	if timer==0 then
		if Player.hp>d then
			if GetGlobal("FatalFire") ~= true then
				Player.hp=Player.hp-d
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
			else FakeDeath()
		end
	end
end


function FakeDeath()
	if killed==false then
		SetGlobal("Playerisdead",true)
		EndWave()
		SetGlobal("nocomment",true)
		if not battlesprites then
			else
			for i=1,#battlesprites do
				battlesprites[i].Remove()
			end
		end
		killed=true
	end
end
			
			
	