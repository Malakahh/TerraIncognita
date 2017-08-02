local _frames = {}

local function RegisterForEvents(frame)
	if frame == nil then return end
	if _frames[frame] ~= nil then return end

	_frames[frame] = true
end

local function UnregisterForEvents(frame)
	if frame == nil then return end

	_frames[frame] = nil
end

local eventNames
local function EventHandler(event)
	local eName = eventNames[event.name]

	for f,_ in pairs(_frames) do
		if f[eName] ~= nil then
			f[eName](f, event)
		end
	end
end

script.on_event(defines.events, function (event)
	--build eventNames table
	eventNames = {}
	for k,v in pairs(defines.events) do
		eventNames[v] = k
	end

	--Call proper eventhandler, and subsequently make sure it runs for the remainder
	EventHandler(event)
	script.on_event(defines.events, EventHandler)
end)

return {
	RegisterForEvents = RegisterForEvents,
	UnregisterForEvents = UnregisterForEvents
}