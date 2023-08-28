local State = require 'State'
local states = require 'states'

function love.load()
	State.import(states)
	State.setCurrentState('menu')
	State.load()
end

function love.update(dt)
	State.update(dt)
end

function love.draw()
	State.draw()
end

function love.keypressed(key)
	if key == 'escape' then love.event.quit() end
	State.keypressed(key)
end

function love.mousepressed(x, y, button)
	State.mousepressed(x, y, button)
end

function CheckCollision(a, b)
  local ax2,ay2,bx2,by2 = a.x + a.w, a.y + a.w, b.x + b.w, b.y + b.w
  return a.x < bx2 and ax2 > b.x and a.y < by2 and ay2 > b.y
end
