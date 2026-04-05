collision = require "Libraries/rotational_collision"
Arena.Resize(165, 140)
chasingbullet = CreateProjectile('vert_knife', Arena.width/2, Arena.height/2)
chasingbullet.SetVar('xspeed', 0)
chasingbullet.SetVar('yspeed', 0)
chasingbullet.SetVar("color","knife")
angle = 0
bones = {}
spawntimer = 0
require "Libraries/Playermove"
require "Libraries/hurt"

DoGhost("Paps_Sprite",1,600)

function CreateBones()
	bonetop = CreateProjectile('bone', Arena.width/2, Arena.height/2-8)
	bonetop.SetVar('xspeed', -1)
	bonetop.SetVar('yspeed', 0)
	bonetop.SetVar("color","bone")
	table.insert(bones, bonetop)

	bonedown = CreateProjectile('bone', -Arena.width/2, -Arena.height/2+8)
	bonedown.SetVar('xspeed', 1)
	bonedown.SetVar('yspeed', 0)
	bonedown.SetVar("color","bone")
	table.insert(bones, bonedown)

	boneright = CreateProjectile('bone', Arena.width/2-8, -Arena.height/2)
	boneright.sprite.rotation = 90
	boneright.SetVar('xspeed', 0)
	boneright.SetVar('yspeed', 1)
	boneright.SetVar("color","bone")
	table.insert(bones, boneright)
	
	boneleft = CreateProjectile('bone', -Arena.width/2+8, Arena.height/2)
	boneleft.sprite.rotation = 90
	boneleft.SetVar('xspeed', 0)
	boneleft.SetVar('yspeed', -1)
	boneleft.SetVar("color","bone")
	table.insert(bones, boneleft)

end




function Update()
HurtUpd(600)
Moving()
	spawntimer = spawntimer+1

	if(spawntimer % 10 == 0) then
		if spawntimer > 60 then
			CreateBones()
		end
	end

	local xdifference = Player.x - chasingbullet.x
	local ydifference = Player.y - chasingbullet.y
	local xspeed = chasingbullet.GetVar('xspeed') / 2 + xdifference / 100
	local yspeed = chasingbullet.GetVar('yspeed') / 2 + ydifference / 100
	local dist = math.sqrt(xdifference*xdifference + ydifference*ydifference)
	if Player.y < chasingbullet.y then
		angle = math.asin(xdifference/dist)*180/math.pi
	else
		angle = 180 - math.asin(xdifference/dist)*180/math.pi
	end
	chasingbullet.sprite.rotation = angle
	chasingbullet.Move(xspeed, yspeed)
	chasingbullet.SetVar('xspeed', xspeed)
	chasingbullet.SetVar('yspeed', yspeed)
	if collision.CheckCollision(Player, chasingbullet) then
		KnifeHurt(1)
	end


	for i=1,#bones do
		local bone = bones[i]
		local velx = bone.GetVar('xspeed')
		local vely = bone.GetVar('yspeed')
		bone.Move(velx, vely)
		if bone.x > Arena.width/2 or bone.x < -Arena.width/2 or bone.y > Arena.height/2 or bone.y < -Arena.height/2 then
			bone.sprite.alpha = 0
			--table.remove(bones, bone)
		end
	end
end



function OnHit(b)
	if b.GetVar("color")=="bone" then
		LongHurt(10,90)
	end
end