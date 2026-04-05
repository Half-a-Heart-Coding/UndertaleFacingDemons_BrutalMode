spearup1 = CreateProjectile('spear', 0, -110)
speardown1 = CreateProjectile('speardown', 0, 110)
spearleft1 = CreateProjectile('spearleft', 130, 0)
spearright1 = CreateProjectile('spearright', -130, 0)
timer = 0
spearmoving = false
spearmovingdiag = false
Arena.Resize(155, 130)

collision = require "Libraries/rotational_collision"

function Update()
	timer = timer + 1
	if timer == 30 then
		spearup1.MoveTo(0, -110)
		speardown1.MoveTo(0, 110)
		spearleft1.MoveTo(130, 0)
		spearright1.MoveTo(-130, 0)
		spearmoving = true
	end
	if timer == 70 then
		spearup1.MoveTo(130, -110)
		spearup1.sprite.rotation = 45
		speardown1.MoveTo(-130, 110)
		speardown1.sprite.rotation = 45
		spearleft1.MoveTo(130, 110)
		spearleft1.sprite.rotation = 45
		spearright1.MoveTo(-130, -110)
		spearright1.sprite.rotation = 45
		spearmoving = false
	end
	if timer == 80 then
		spearmovingdiag = true
	end
	if timer == 120 then
		spearup1.MoveTo(0, -110)
		spearup1.sprite.rotation = 0
		speardown1.MoveTo(0, 110)
		speardown1.sprite.rotation = 0
		spearleft1.MoveTo(130, 0)
		spearleft1.sprite.rotation = 0
		spearright1.MoveTo(-130, 0)
		spearright1.sprite.rotation = 0
		spearmoving = false
		spearmovingdiag = false
	end
	if timer == 130 then
		spearmoving = true
	end
	if timer == 210 then 
		EndWave() 
	end

	if spearmoving == true then
		spearup1.Move(0, 7)
		speardown1.Move(0, -7)
		spearleft1.Move(-7, 0)
		spearright1.Move(7, 0)
	end
	if spearmoving == false then
		spearup1.Move(0, 0)
	end
	if spearmovingdiag == true then
		spearup1.Move(-7, 7)
		speardown1.Move(7, -7)
		spearleft1.Move(-7, -7)
		spearright1.Move(7, 7)
	end
end
			
function OnHit(spearup1)
	if collision.CheckCollision(Player, spearup1) and spearup1.sprite.alpha > 0.9 then
		Player.Hurt(10)
	end
end

function OnHit(speardown1)
	if collision.CheckCollision(Player, speardown1) and speardown1.sprite.alpha > 0.9 then
		Player.Hurt(10)
	end
end

function OnHit(spearleft1)
	if collision.CheckCollision(Player, spearleft1) and spearleft1.sprite.alpha > 0.9 then
		Player.Hurt(10)
	end
end

function OnHit(spearright1)
	if collision.CheckCollision(Player, spearright1) and spearright1.sprite.alpha > 0.9 then
		Player.Hurt(10)
	end
end