Arena.Resize(128,128)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}
insanityLevel=45
insanityLevelTimes=120
insanityLevel2=1
insanityLevel3=120
insanityLevel4=2
insanityLevelTimes2=1
name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
--local speedOfKnive = 2.1
function SendKnife(pos,speed,name,time)
	name=name..name2
	local knife=CreateProjectile(name,pos[1],pos[2])
	knife.SetVar("time",0)
	knife.SetVar("speed",speed)
	knife.sprite.alpha=0
	knife.SetVar("top",time)
	table.insert(knifes,knife)
end

function Update()
HurtUpd(1200)
Moving()
spawntime=spawntime+1
if spawntime%90==0 and spawntime%600 < 300 then
	SendKnife({32,120},{0,-1},"KnifeLeft",240)
	SendKnife({-32,-120},{0,1},"KnifeRight",240)
end

if spawntime>=900 and spawntime%600 == 300 then
	--SendKnife({32,120},{0,-1},"KnifeLeft",240)
	--SendKnife({-32,-120},{0,1},"KnifeRight",240)
	--SendKnife({-160,32},{1.5,0},"KnifeDown",160)
	--SendKnife({160,-32},{-1.5,0},"KnifeUp",160)
	--insanityLevelTimes = insanityLevelTimes - 3
	--if spawntime>=1200 then
		insanityLevelTimes = insanityLevelTimes - 5
	--end
elseif spawntime%600 == 300 then
	insanityLevelTimes = insanityLevelTimes - 3
end

if spawntime>=900 and spawntime%600 == 0 then
	--SendKnife({32,120},{0,-1},"KnifeLeft",240)
	--SendKnife({-32,-120},{0,1},"KnifeRight",240)
	--SendKnife({-160,32},{1.5,0},"KnifeDown",160)
	---SendKnife({160,-32},{-1.5,0},"KnifeUp",160)
	--insanityLevelTimes = insanityLevelTimes - 3
	--if spawntime>=1200 then
		insanityLevelTimes = insanityLevelTimes - 5
	--end
elseif spawntime%600 == 0 then
	insanityLevelTimes = insanityLevelTimes - 3
end

if spawntime%90==0 and spawntime%600 > 300 then
	SendKnife({-160,32},{1.5,0},"KnifeDown",160)
	SendKnife({160,-32},{-1.5,0},"KnifeUp",160)
end

if spawntime%insanityLevelTimes==0 then
	local rand=math.random(4)
	Audio.PlaySound("blip")
	if rand==1 then
		SendKnife({-160,32},{2,0},"KnifeDown",160)
		elseif rand==2 then
		SendKnife({160,-32},{-2,0},"KnifeUp",160)
		elseif rand==3 then
		SendKnife({32,-160},{0,2},"KnifeLeft",160)
		else
		SendKnife({-32,160},{0,-2},"KnifeRight",160)
	end
	--insanityLevelTimes2 = insanityLevelTimes2 + 1
	--speedOfKnive = speedOfKnive + 0.0
end
--if spawntime%300==0 then
--	insanityLevel=180 - insanityLevelTimes
--	insanityLevel=insanityLevel / 4
--	insanityLevel2=84 + insanityLevelTimes
--	insanityLevel2=insanityLevel2/80
--end

--if spawntime%450==0 then
--	insanityLevel3=240 - insanityLevelTimes2
--	insanityLevel3=insanityLevel3 / 2
--	insanityLevel4=42 + insanityLevelTimes2
--	insanityLevel4=insanityLevel4/20
--end

for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local speed=k.GetVar("speed")
		k.Move(speed[1],speed[2])
		local top=k.GetVar("top")
		if time<31 then	
			k.sprite.alpha=math.sin(time*math.pi/60)
			elseif time>top-30 and time<top then
			k.sprite.alpha=math.sin((time-top+60)*math.pi/60)
			elseif time==top then
			k.Remove()
		end
	end
end



end

function OnHit()
KnifeHurt(1)
end