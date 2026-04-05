collision=require "Libraries/rotational_collision"
Arena.ResizeImmediate(500,300)
knife=CreateProjectile("KnifeRight",0,0)
knife.sprite.rotation=90

function Update()
	if collision.CheckCollision(Player,knife) then
		Player.Hurt(1,1)
	end
	if Input.Confirm>0 then
		knife.sprite.rotation=knife.sprite.rotation+5
	end
end


function OnHit()
end