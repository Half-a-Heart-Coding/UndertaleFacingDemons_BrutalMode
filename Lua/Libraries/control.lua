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
local Possessed=Encounter.GetVar("Possessed")
local p1=Encounter.GetVar("PlayerHasSpared")
local p2=Encounter.GetVar("PlayerWasHurted")
local p3=Encounter.GetVar("PlayerHasFlirted")
local ghosts={}

if Possessed==true then
	SetGlobal("curse",Player.lv*4+16-Player.hp)
end
	

	
function DoGhost(name,side,time)
	local s="1.1.7/"
	local NEW=false
	if Encounter.GetVar("currentspr")=="1.2" then
		s="1.2/"
		local NEW=true
	end
	local gh=CreateProjectileAbs(s..name,320,400,"BelowArena")
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

function TimeUpd(ingo)
if #ghosts>0 then
	local count=0
	for i=1,#ghosts do
		local g=ghosts[i]
		if g.isactive then
			local time=g.GetVar("time")+1
			g.SetVar("time",time)
			local top=g.GetVar("top")
			local side=g.GetVar("side")
			g.sprite.alpha=math.sin(time*math.pi/top)
			if time-1<top/2 then
				g.MoveToAbs(320+side*90*math.sin(time*math.pi/top),244+g.sprite.height/2*g.sprite.yscale)
				else
				g.MoveToAbs((320+180*side)-side*90*math.sin(time*math.pi/top),244+g.sprite.height/2*g.sprite.yscale)
			end
			else
			count=count+1
		end
	end
	if count==#ghosts then
		ghosts={}
	end
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

wavetimery=wavetimery+1
if not GetGlobal("curse") then	
	elseif Player.lv>1 then
	local c=GetGlobal("curse")
	local w=6
	if p3>0 then
		w=3
	end
	local max=0
	if p2>0 then
		max=120
	end 
	if wavetimery%w==0 and wavetimery>max then
		if not GetGlobal("curse") then
			else
			c=c+1
			SetGlobal("curse",c)
		end
	end
	local free=(16+4*Player.lv)-Player.hp
	if c>free then
		if Player.hp>1 then
			Player.hp=Player.hp-1
			else
			SetGlobal("curse",Encounter.GetVar("MaxHP")-1)
		end
	end
	if Player.hp==1 and c==free and not Possessed then
		Arena.MoveToAndResize(320,95,565,130,true,true)
		Lower()
		Encounter.Call("Possess")
		State("NONE")
	end
	if Possessed==true then
		if wavetimery%60==0 then
			ChangeLevel(1)
		end
		if c==0 then
			Possessed=false
			Encounter.SetVar("Possessed",false)
			Encounter.SetVar("MettaViewTime",30)
		end
	end
end

if wavetimery==ingo then
	Arena.ResizeImmediate(565,130)
	Arena.MoveTo(320,95,true,true)
	Lower()
	EndWave()
end
end

function Flower(ingo)
	if not GetGlobal("curse") then
		else
		local MaxHP=16+Player.lv*4
		Player.hp=Player.hp+ingo
		if Player.hp>MaxHP then
			Player.hp=MaxHP
		end
		local free=MaxHP-Player.hp
		local c=GetGlobal("curse")
		if c>free then
			SetGlobal("curse",free)
		end
		if Player.hp==MaxHP and p1==true then
			ChangeLevel(-1)
			Player.hp=1
			if Player.lv==1 then
				Player.sprite.color={1,0,0}
				Encounter.Call("LostHadWon")
			end
		end
	end
	NewAudio.Play("Hits")
end

function ChangeLevel(ingo)
	local level=Player.lv
	local lv=level+ingo
	if lv>19 then
		lv=19
		elseif lv<1 then
		lv=1
	end
	if lv>level then
		Audio.PlaySound("blip")
	end
	local MaxHP=16+(lv*4)
	Player.lv=lv
	Encounter.SetVar("MaxHP",MaxHP)
	if ingo==-1 then
		Player.hp=1
		if Possessed then
			Possessed=false
			Encounter.SetVar("MettaViewTime",30)
			Encounter.SetVar("Possessed",false)
		end
		elseif ingo==1 then
		if not GetGlobal("curse") then
			else
			SetGlobal("curse",GetGlobal("curse")+4)
		end
	end
end
	
function Lower()
	p1=false
	p2=p2-1
	if p2<0 then
		p2=0
	end
	p3=p3-1
	if p3<0 then
		p3=0
	end
	Encounter.SetVar("PlayerHasSpared",p1)
	Encounter.SetVar("PlayerWasHurted",p2)
	Encounter.SetVar("PlayerHasFlirted",p3)
end			
	