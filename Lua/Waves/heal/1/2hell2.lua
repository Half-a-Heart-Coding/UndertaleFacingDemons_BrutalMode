Arena.ResizeImmediate(100, 100)
spawntimer = math.random(2)*60-60-1
knifes1 = {}
knifes2 = {}
knives = {}

require "Libraries/Playermove"
require "Libraries/hurt"

if Encounter.GetVar("diff")==34 or Encounter.GetVar("diff")==35 or Encounter.GetVar("diff")==36 then
	Encounter.SetVar("SavedProg", Encounter.GetVar("SavedProg")+1)
end

function Update() 

HurtUpd(690)
Moving()
	spawntimer = spawntimer + 1
	if spawntimer < 400 then
		if spawntimer % 80 == 40 then  
			k1 = CreateProjectile ('KnifeDown', Player.x, 87)
			k2 = CreateProjectile ('KnifeUp', Player.x, -87)
			k1.SetVar("color","knife")
			k2.SetVar("color","knife")
			k1.SetVar("side",-1)
			k2.SetVar("side",1)
			k1.SetVar("time",0)
			k2.SetVar("time",0)
			k1.SetVar("fadetime",0)
			k2.SetVar("fadetime",0)
			table.insert (knifes2, k1)
			table.insert (knifes2, k2)
			if math.random(2) > 1 then
				k3 = CreateProjectile ('KnifeLeft', 87, Player.y)
				k3.SetVar("side",-1)
			else
				k3 = CreateProjectile ('KnifeRight', -87, Player.y)
				k3.SetVar("side",1)
			end
			k3.SetVar("color","knife")
			k3.SetVar("time",0)
			k3.SetVar("fadetime",0)
			table.insert (knifes1, k3)
		end 

		if spawntimer % 80 == 0 then  
			k1 = CreateProjectile ('KnifeLeft', 87, Player.y)
			k2 = CreateProjectile ('KnifeRight', -87, Player.y)
			k1.SetVar("color","knife")
			k2.SetVar("color","knife")
			k1.SetVar("side",-1)
			k2.SetVar("side",1)
			k1.SetVar("time",0)
			k2.SetVar("time",0)
			k1.SetVar("fadetime",0)
			k2.SetVar("fadetime",0)
			table.insert (knifes1, k1)
			table.insert (knifes1, k2)
			if math.random(2) > 1 then
				k3 = CreateProjectile ('KnifeDown', Player.x, 87)
				k3.SetVar("side",-1)
			else
				k3 = CreateProjectile ('KnifeUp', Player.x, -87)
				k3.SetVar("side",1)
			end
			k3.SetVar("color","knife")
			k3.SetVar("time",0)
			k3.SetVar("fadetime",0)
			table.insert (knifes2, k3)
		end 
	elseif spawntimer > 400 then
		if spawntimer % 50 == 0 then 
			k1 = CreateProjectile ('KnifeLeftDeadly', 87, Player.y)
			k2 = CreateProjectile ('KnifeRightDeadly', -87, Player.y)
			k1.SetVar("color","knife2")
			k2.SetVar("color","knife2")
			k1.SetVar("side",-1)
			k2.SetVar("side",1)
			k1.SetVar("time",0)
			k2.SetVar("time",0)
			k1.SetVar("fadetime",0)
			k2.SetVar("fadetime",0)
			table.insert (knifes1, k1)
			table.insert (knifes1, k2)

			k1 = CreateProjectile ('KnifeDownDeadly', Player.x, 87)
			k2 = CreateProjectile ('KnifeUpDeadly', Player.x, -87)
			k1.SetVar("color","knife2")
			k2.SetVar("color","knife2")
			k1.SetVar("side",-1)
			k2.SetVar("side",1)
			k1.SetVar("time",0)
			k2.SetVar("time",0)
			k1.SetVar("fadetime",0)
			k2.SetVar("fadetime",0)
			table.insert (knifes2, k1)
			table.insert (knifes2, k2)
		end 
	end
	
	for i=1,#knifes1 do
    	    local k = knifes1[i]
		if k.isactive then
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<31 then
				k.sprite.alpha=math.sin(time*math.pi/60)
				elseif time<60 then
				local speed=k.GetVar("side")*(1-math.cos((time-30)*math.pi/60))*5
				k.Move(speed,0)	
				else
				k.Move(5*k.GetVar("side"),0)
			end
			if k.x>87 or k.x<-87 then
				local fade=k.GetVar("fadetime")+1
				k.SetVar("fadetime",fade)
				if fade<60 then
					k.sprite.alpha=math.cos(fade*math.pi/120)
					else
					k.Remove()
				end
			end
		end			
	end
	
	for i=1,#knifes2 do
    	    local k = knifes2[i]
		if k.isactive then
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<31 then
				k.sprite.alpha=math.sin(time*math.pi/60)
				elseif time<60 then
				local speed=k.GetVar("side")*(1-math.cos((time-30)*math.pi/60))*5
				k.Move(0,speed)	
				else
				k.Move(0,5*k.GetVar("side"))
			end
			if k.y>87 or k.y<-87 then
				local fade=k.GetVar("fadetime")+1
				k.SetVar("fadetime",fade)
				if fade<60 then
					k.sprite.alpha=math.cos(fade*math.pi/120)
					else
					k.Remove()
				end
			end
		end			
	end
end 

function OnHit(bullet)
	if bullet.GetVar("color") == "knife2" then
		KnifeHurt(2)
	else
		KnifeHurt(1)
	end
end