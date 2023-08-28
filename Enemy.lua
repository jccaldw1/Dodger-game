local Enemy = {}
Enemy.list = {}
Enemy.toRemove = {}

function Enemy.new(gameTime)
	enemy = {}
	enemy.w = math.random() * 100 + 5
	enemy.x = math.abs(math.random() * (love.graphics.getWidth() - enemy.w))
	enemy.y = -enemy.w
	enemy.speed = (1/(1/(1 + math.exp(-enemy.w/25)))) * (400 + gameTime)

	function enemy:draw()
		love.graphics.setColor(1,0,0)
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.w)
	end

	Enemy.list[#Enemy.list + 1] = enemy

	return enemy
end

function Enemy.update(dt)
	for i = 1, #Enemy.list do
		Enemy.list[i].y = Enemy.list[i].y + Enemy.list[i].speed * dt
		if Enemy.list[i].y > love.graphics.getHeight() or enemy.hit then
			table.insert(Enemy.toRemove, Enemy.list[i])
		end
	end
	for i = 1, #Enemy.toRemove do
		for j = 1, #Enemy.list do
			if Enemy.toRemove[i] == Enemy.list[j] then
				table.remove(Enemy.list, j)
				table.remove(Enemy.toRemove, i)
			end
		end
	end
end

function Enemy.deleteAll()
	Enemy.list = {}
end

return Enemy
