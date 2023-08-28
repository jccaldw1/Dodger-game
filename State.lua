local State = {}

State.currentState = nil
State.mystates = {}

function State.import(states)
	for k, v in pairs(states) do
		State.mystates[k] = {
			onStart = v.onStart or function() end,
			onExit = v.onExit or function() end,
			update = v.update or function() end,
			draw = v.draw or function() end,
			keypressed = v.keypressed or function() end,
			mousepressed = v.mousepressed or function() end,
			globals = v.globals or {}
		}
	end
end

function State.load()
	assert(State.currentState, "current State is nil")
	State.currentState.onStart()
	State.declareGlobals()
end

function State.declareGlobals()
	for k, v in pairs(State.currentState.globals) do
		if k == nil then
			k = v
		end
	end
end

function State.change(toState)
	State.currentState.onExit()
	State.setCurrentState(toState)
	State.currentState.onStart()
	State.declareGlobals()
end

function State.setCurrentState(state)
	State.currentState = State.mystates[state]
end

function State.update(dt)
	State.currentState.update(dt)
end

function State.draw()
	State.currentState.draw()
end

function State.keypressed(key)
	State.currentState.keypressed(key)
end

function State.mousepressed(x, y, button)
	State.currentState.mousepressed(x, y, button)
end

return State
