local Player = require 'Player'

local Bullet = {}

Bullet.bullets = {}
Bullet.toRemove = {}

function Bullet.new(source)
	local bullet = {}
	bullet.w = 10
	bullet.speed = 400
	bullet.x = Player.x + Player.w / 2 - bullet.w / 2
	bullet.y = Player.y - bullet.w

	function bullet:draw()
		love.graphics.setColor(1,1,1)
		love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.w, bullet.w)
	end

	Bullet.bullets[#Bullet.bullets + 1] = bullet

	return bullet
end

function Bullet.update(dt)
	for i = 1, #Bullet.bullets do
		Bullet.bullets[i].y = Bullet.bullets[i].y - Bullet.bullets[i].speed * dt
		if Bullet.bullets[i].y < -Bullet.bullets[i].w then
			table.insert(Bullet.toRemove, Bullet.bullets[i])
		end
	end
	for i = 1, #Bullet.toRemove do
		for j = 1, #Bullet.bullets do
			if Bullet.toRemove[i] == Bullet.bullets[j] then
				table.remove(Bullet.bullets, j)
				table.remove(Bullet.toRemove, i)
			end
		end
	end
end

function Bullet.deleteAll()
	Bullet.bullets = {}
end

return Bullet
