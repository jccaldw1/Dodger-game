local Player = require 'Player'
local Enemy = require 'Enemy'
local Bullet = require 'Bullet'
local Button = require 'Button'
local State = require 'State'

local states = {}
--possible functions: onStart, onExit, update, draw, keypressed, mousepressed, declareGlobals
states.menu = {
	onStart = function()
		local text1 = "Start Game!"
		local font = love.graphics.newFont(24)
		local buttonw1 = font:getWidth(text1) + .1 * love.graphics.getWidth()
		local buttonh1 = font:getHeight(text1) + .1 * love.graphics.getHeight()
		local text2 = "Options"
		local buttonw2 = font:getWidth(text2) + .1 * love.graphics.getWidth()
		local buttonh2 = font:getHeight(text2) + .1 * love.graphics.getHeight()
		Button.new(
			function()
				State.change("game")
			end,
			text1,
			love.graphics.getWidth() / 2 - buttonw1 / 2,
			love.graphics.getHeight() / 2 - buttonh1 / 2 - .1 * love.graphics.getHeight(),
			buttonw1,
			buttonh1,
			{1,.5,0},
			{0,1,0}
		)

		Button.new(
			function() love.event.quit() end,
			text2,
			love.graphics.getWidth()/2 - buttonw2 / 2,
			love.graphics.getHeight() / 2 - buttonh2 / 2 + .1 * love.graphics.getHeight(),
			buttonw2,
			buttonh2,
			{1,.5,0},
			{0,1,0}
		)
	end,
	onExit = function()
		love.graphics.clear()
		Button.deleteAll()
	end,
	draw = function()
		Button.draw()
	end,
	keypressed = function(key)
		--[[if key == 'space' then
			State.change(State.mystates.game)
		end]]
	end,
	mousepressed = function(x, y, button)
		Button.ping(x, y, button)
	end
}

states.game = {
	globals = {readyTime = 3, delay = .25},
	update = function(dt)
		local globals = states.game.globals
		globals.readyTime = globals.readyTime - dt
		globals.delay = globals.delay - dt
		if globals.readyTime < 0 then
			Player.move(dt)
			Enemy.update(dt)
			Bullet.update(dt)
			for i = 1, #Enemy.list do
				if CheckCollision(Player, Enemy.list[i]) then
					State.change("game")
					break
				end
				for j = 1, #Bullet.bullets do
					if CheckCollision(Bullet.bullets[j], Enemy.list[i]) then
						table.insert(Bullet.toRemove, Bullet.bullets[j])
						table.insert(Enemy.toRemove, Enemy.list[i])
					end
				end
			end
			if love.math.random() < .1 then
				Enemy.new(-globals.readyTime + 3)
			end
		end
	end,
	draw = function()
		local globals = states.game.globals
		if globals.readyTime > 0 then
			love.graphics.setColor(1,1,1)
			love.graphics.print("Get ready! Game will start in " .. math.ceil(globals.readyTime), love.graphics.getWidth()/2, love.graphics.getHeight()/2)
		elseif globals.readyTime < 0 then
			Player.draw()
			for i = 1, #Enemy.list do
				Enemy.list[i]:draw()
			end
			for i = 1, #Bullet.bullets do
				Bullet.bullets[i]:draw()
			end
		end
	end,
	keypressed = function(key)
		local globals = states.game.globals
		if globals.readyTime < 0 then
			if key == 'space' and globals.delay < 0 then
				Bullet.new()
				globals.delay = .25
			end
		end
	end,
	onExit = function()
		local globals = states.game.globals
		Enemy.deleteAll()
		Bullet.deleteAll()
		Player.reset()
		globals.readyTime = 3; globals.delay = .25
	end
}

return states
