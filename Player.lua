local Player = {}

Player.w = 50
Player.x = love.graphics.getWidth() / 2 - Player.w / 2
Player.y = love.graphics.getHeight() * .8
Player.speed = 300

function Player.draw()
	love.graphics.setColor(0,1,0)
	love.graphics.rectangle("fill", Player.x, Player.y, Player.w, Player.w)
end

function Player.move(dt)
	if love.keyboard.isDown('w') and Player.y > 0 then Player.y = Player.y - Player.speed * dt end
	if love.keyboard.isDown('s') and Player.y < love.graphics.getHeight() - Player.w then Player.y = Player.y + Player.speed * dt end
	if love.keyboard.isDown('a') and Player.x > 0 then Player.x = Player.x - Player.speed * dt end
	if love.keyboard.isDown('d') and Player.x < love.graphics.getWidth() - Player.w then Player.x = Player.x + Player.speed * dt end
end

function Player.reset()
	Player.x = love.graphics.getWidth() / 2 - Player.w / 2
	Player.y = love.graphics.getHeight() * .8
end

return Player
