require "Libraries/colortoys"
Arena.Resize(300, 150)
-- A lightning bolt example -- vaguely modeled after something you'd expect to see in a certain final battle.
-- No screen shake though.
spawntimer = 0
timer = 0
bullets = {}
booms={}
bigbooms={}
tim={}
zigs={}
in_side=0
require "Libraries/Playermove"
require "Libraries/hurt"

state = 0

warning_gradient = Gradient.new({{1, 0, 0}, {1, 0.5, 0}, {1, 0, 0}}) -- gradient between orange and red

DoGhost("Alphys_Sprite",1,600)


function create_lightning(x, large)
	local left_right = math.random(0, 1)
	
	if left_right == 1 then
		left_right = "bolt_left"
	else
		left_right = "bolt_right"
	end
	
	local bolt = CreateProjectile(left_right, x, 0)
	bolt.sprite.color = {0, 0.5, math.random(128, 255)/255} ----------- hsv_to_rgb(math.random() * math.pi * 2, 1.0, 0.7) -- Увы, радужные молнии не в стиле Альфис
	bolt.sprite.xscale = 0.75
	bolt.sprite.yscale = 0.75
	bolt.SetVar('bullet_type', 2) -- visual_lightning
	bolt.SetVar('lifetime', 30) -- it should only last half a second visually
	bolt.SetVar('large', large)
	bolt.sprite.Set(left_right)
	if large then
		bolt.sprite.xscale = 2
		bolt.sprite.yscale = 2
		bolt.MoveTo(bolt.x, bolt.y + bolt.sprite.height)
	end
	table.insert(bullets, bolt)

	local pillar_sprite = 'bolt_pillar'
	local offset = 0
	if large then
		pillar_sprite = 'bolt_pillar_large'
		offset = 100
	end
	local pillar = CreateProjectile(pillar_sprite, x, offset)
	bolt.MoveTo(pillar.x, pillar.y)
	pillar.SetVar('bullet_type', 1) -- pillar
	pillar.SetVar('lifetime', 10) -- It only lasts ten frames.
	pillar.SetVar('large', large)

	if large then
		Audio.PlaySound('bolt')
	else
		Audio.PlaySound('bolt_high')
	end
	table.insert(bullets, pillar)
end

function update_warning(bullet)
	if not bullet.isactive then
		return
	end
	
	local life_left = bullet.GetVar('lifetime')
	bullet.SetVar('lifetime', life_left - 1)
	bullet.sprite.color = warning_gradient:getColorAt((life_left % 30) / 30)

	if life_left == 0 then
		local big = bullet.GetVar('big')
		local bolt_pillar = create_lightning(bullet.x, big)
		bullet.Remove()
		return
	end
end

function update_bolt(bullet)
	if not bullet.isactive then
		return
	end
	
	local life_left = bullet.GetVar('lifetime')
	local large = bullet.GetVar('large')
	
	bullet.SetVar('lifetime', life_left - 1)
	bullet.sprite.alpha = life_left / 30

	if large then
		bullet.sprite.xscale = (2 - life_left / 30) * 2
	else
		bullet.sprite.xscale = (2 - life_left / 30)
	end
	
	if life_left == 0 then
		bullet.Remove()
	end
end

function update_pillar(bullet)
	if not bullet.isactive then
		return
	end
	
	local life_left = bullet.GetVar('lifetime')
	
	bullet.sprite.alpha = life_left / 10
	
	if life_left > 0 then
		bullet.SetVar('lifetime', life_left - 1)
	else
		bullet.Remove()
	end
end

function update_zigzag(bullet)
	if not bullet.isactive then
		return
	end

	local vel = bullet.GetVar('speed')
	bullet.Move(0, -1*vel)

	if bullet.y < (-Arena.height / 2) then
		bullet.Remove()
	end
end

function OnHit(bullet)
	-- these bullets are just for show
	local bullet_type = bullet.GetVar('bullet_type')
	
	if bullet_type == 1 or bullet_type == 3 then
		local large = bullet.GetVar('large')
		if large then
			LongHurt(20,60)
		else
			LongHurt(15,60)
		end
	end
end

function Update()
HurtUpd(600)
Moving()
	spawntimer = spawntimer + 1
	timer = timer + 1
	if spawntimer % 10 == 0 then
			local side=math.random(2)*2-3
			if in_side>4 then
				side=-1
			end
			if in_side<-4 then
				side=1
			end
			in_side=in_side+side
			local away=1+math.random(143)
			local zigzag = CreateProjectile('zap1',side*away, 0 + Arena.height / 2 + 16)
			zigzag.SetVar('bullet_type', 3)
			zigzag.SetVar('big', false)
			zigzag.SetVar('speed', 1)
			table.insert(bullets, zigzag)
	end

	if state == 0 then
		if spawntimer % 40 == 0 then
		    local warning1 = CreateProjectile('bolt_warning', math.random() * Arena.width - Arena.width / 2, 0 - Arena.height / 2 + 16)
			warning1.SetVar('bullet_type', 0) --warning light type bullet
			warning1.SetVar('lifetime', 120)
			warning1.SetVar('big', false)
			table.insert(bullets, warning1)
		    local warning2 = CreateProjectile('bolt_warning', math.random() * Arena.width - Arena.width / 2, 0 - Arena.height / 2 + 16)
			warning2.SetVar('bullet_type', 0) --warning light type bullet
			warning2.SetVar('lifetime', 120)
			warning2.SetVar('big', false)
			table.insert(bullets, warning2)
		end
		
		
		if spawntimer == 160 then
			state = 1 -- don't make warning boxes any more.
			spawntimer = 0
		end
	end
	
	if state == 1 then
		if spawntimer == 120 then
			state = 2 --------------------------------надо бы 2, но это пока не используется.
			spawntimer = 0
		end
	end
	
	if state == 2 then
		if spawntimer==0 or spawntimer==60 then
			if spawntimer==0 then
				posy=math.random(2)*2-3
				posx=math.random(2)*2-3
			end
			local boom=CreateProjectile("bolt_warning_big",112.5*posx,37.5*posy)
			boom.sprite.Scale(1.5,1.5)
			boom.sprite.rotation=90*posx
			table.insert(booms,boom)
			posx=-posx
			posy=-posy
		end
		
		if spawntimer == 90 then
			state = 3
			spawntimer = 0
		end
	end
	for i=1,#booms do
		local b=booms[i]
			
		if b.isactive then
			if not tim[i] then
				tim[i]=1
				else tim[i]=tim[i]+1
			end
			local t=tim[i]
			if t<120 then
				if t%3==0 then
					if t%6==0 then
						b.sprite.color={1,0,0}
						else
						b.sprite.color={1,1,1}
					end
				end
				else
				local str=""
				ran=math.random(2)
				if ran==1 then
					str="_right"
					else
					str="_left"
				end
				local blow=CreateProjectile("bolt"..str,0,b.y)
				blow.sprite.Scale(2,2)	
				if b.sprite.rotation==90 then
					blow.sprite.rotation=90
					blow.MoveTo(150-201,b.y)
					else
					blow.sprite.rotation=-90
					blow.MoveTo(-150+201,b.y)
				end
				Audio.PlaySound('bolt_high')
				table.insert(bigbooms,blow)
				b.Remove()
			end
		end
	end
	for i=1,#bigbooms do
		local b=bigbooms[i]
		if b.isactive then
			if not tim[i+2] then
				tim[i+2]=1
				else
				tim[i+2]=tim[i+2]+1
			end
			local t=tim[2+i]
			if t<30 then
				b.sprite.alpha=1-math.sin(t*math.pi/60)
				b.sprite.Scale(2+2*math.sin(t*math.pi/60),2)
				if t<11 then
					if Player.y>b.y-29 and Player.y<b.y+29 then
						LongHurt(25,60)
					end
				end
				else
				b.Remove()
			end
		end
	end
    for i=1,#bullets do
        local bullet = bullets[i]
        local bullet_type = bullet.GetVar('bullet_type')
		if bullet_type == 0 then
			update_warning(bullet)
		elseif bullet_type == 1 then
			update_pillar(bullet)
		elseif bullet_type == 2 then
			update_bolt(bullet)
		elseif bullet_type == 3 then
			update_zigzag(bullet)
		end
    end
end