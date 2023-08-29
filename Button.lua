local Button = {}

Button.buttons = {}

function Button.new(funcToExec, text, x, y, w, h, color, textColor, shape)
	button = {
		func = funcToExec or function() end,
		text = text or "",
		x = x or 0,
		y = y or 0,
		w = w or font:getWidth(text) + .1*love.graphics.getWidth(),
	 	h = h or font:getHeight(text) + .1*love.graphics.getHeight(),
		color = color or {0,0,0},
		textColor = textColor or {0,0,0},
		shape = shape or 'r'
	}

	function button:draw()
		local font = love.graphics.newFont(24)
		love.graphics.setColor(self.color[1], self.color[2], self.color[3])
		if shape == 'r' then
			love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
		elseif shape == 'c' then
			love.graphics.ellipse("fill", self.x, self.y, self.w/2, self.h/2)
		end
		love.graphics.setColor(self.textColor[1], self.textColor[2], self.textColor[3])
		love.graphics.print(self.text, self.x + self.w/2 - font:getWidth(self.text)/4, self.y + self.h/2 - font:getHeight(self.text)/4)
	end

	Button.buttons[#Button.buttons + 1] = button

	return button
end

function Button.ping(x, y, mouseButton)
	local clickCoords = {}
	clickCoords.x = x; clickCoords.y = y; clickCoords.w = 0; clickCoords.h = 0;
	for i = 1, #Button.buttons do
		if CheckCollision(Button.buttons[i], clickCoords) and mouseButton == 1 then
			Button.buttons[i].func()
			break -- only one button can be clicked at a time
		end
	end
end

function Button.draw()
	for i = 1, #Button.buttons do
		Button.buttons[i]:draw()
	end
end

function Button.deleteAll()
	Button.buttons = {}
end

return Button
