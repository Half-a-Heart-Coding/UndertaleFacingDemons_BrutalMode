Arena.Resize(128, 128)
spawntimer = 0
k10 = {}
k20 = {}
knifes1 = {}
knifes2 = {}
require "Libraries/Playermove"
require "Libraries/hurt"
Player.hp=135
function Update() 

HurtUpd(1200)
Moving()

	spawntimer = spawntimer + 1
	
	if spawntimer%75 == 0 then 
		kD = CreateProjectile('KnifeDownMutant', 200, 32)
		kU = CreateProjectile('KnifeUpMutant', -200, -32)
		kD.sprite.alpha=0
		kU.sprite.alpha=0
		kD.SetVar("time",0)
		kU.SetVar("time",0)
		kD.SetVar("fadetime",0)
		kU.SetVar("fadetime",0)
		table.insert(k10,kD)
		table.insert(k20,kU)
	end 
	
	for i=1,#k10 do
    	local k = k10[i]
		if k.isactive then
	    	k.Move(-2,0)
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<46 then
				k.sprite.alpha=math.sin(time*math.pi/90)
			end
			if k.x<-100 then
				local fade=k.GetVar("fadetime")+1
				k.SetVar("fadetime",fade)
				if fade<60 then
					k.sprite.alpha=math.cos(fade*math.pi/120)
					else
					k.Remove()
				end
			end
		end
		
		local x=k.x
		if x>50 then
			x=x-50
			elseif x<-50 then
			x=x+50
			else
			x=0
		end
		k.sprite.alpha=math.cos(x*math.pi/300)
	end
	
	for i=1,#k20 do
    	local k = k20[i]
		if k.isactive then
	    	k.Move(2,0)
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<46 then
				k.sprite.alpha=math.sin(time*math.pi/90)
			end
			if k.x>100 then
				local fade=k.GetVar("fadetime")+1
				k.SetVar("fadetime",fade)
				if fade<60 then
					k.sprite.alpha=math.cos(fade*math.pi/120)
					else
					k.Remove()
				end
			end
		end
		
		local x=k.x
		if x>50 then
			x=x-50
			elseif x<-50 then
			x=x+50
			else
			x=0
		end
		k.sprite.alpha=math.cos(x*math.pi/300)
	end

	if spawntimer%120 == 0 then 
		local k1 = CreateProjectile('KnifeLeftMutant', 100, Player.y)
		local k2 = CreateProjectile('KnifeRightMutant', -100, Player.y)
		k1.SetVar("color","knife")
		k2.SetVar("color","knife")
		k1.SetVar("side",-1)
		k2.SetVar("side",1)
		k1.SetVar("time",0)
		k2.SetVar("time",0)
		k1.SetVar("fadetime",0)
		k2.SetVar("fadetime",0)
		table.insert(knifes1,k1)
		table.insert(knifes1,k2)
	end 
	if spawntimer % 120 == 60 then  
		local k1 = CreateProjectile ('KnifeDownMutant', Player.x, 100)
		local k2 = CreateProjectile ('KnifeUpMutant', Player.x, -100)
		k1.SetVar("color","knife")
		k2.SetVar("color","knife")
		k1.SetVar("side",-1)
		k2.SetVar("side",1)
		k1.SetVar("time",0)
		k2.SetVar("time",0)
		k1.SetVar("fadetime",0)
		k2.SetVar("fadetime",0)
		table.insert(knifes2,k1)
		table.insert(knifes2,k2)
	end 
	
	for i=1,#knifes1 do
    	local k = knifes1[i]
		if k.isactive then
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<31 then
				k.sprite.alpha=math.sin(time*math.pi/60)
				elseif time<60 then
				local speed=k.GetVar("side")*(1-math.cos((time-30)*math.pi/60))*2.5
				k.Move(speed,0)	
				else
				k.Move(3*k.GetVar("side"),0)
			end
			if (k.x>0 and k.GetVar("side")==1) or (k.x<0 and k.GetVar("side")==-1) or time>60 then
				local fade=k.GetVar("fadetime")+3
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
				local speed=k.GetVar("side")*(1-math.cos((time-30)*math.pi/60))*2.5
				k.Move(0,speed)	
				else
				k.Move(0,3*k.GetVar("side"))
			end
			if (k.y>0 and k.GetVar("side")==1) or (k.y<0 and k.GetVar("side")==-1) or time>60 then
				local fade=k.GetVar("fadetime")+3
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
	KnifeHurt(99999999)
end