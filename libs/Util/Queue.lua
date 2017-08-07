local queue = {}

local function Push(self, value)
	local last = self.last + 1
	self.last = last
	self[last] = value
end

local function Pop(self)
	local first = self.first
	if first > self.last then return end
	local value = self[first]
	self[first] = nil --Garbage collection
	self.first = first + 1
	return value
end

function queue:New()
	local q = {}

	q.first = 0
	q.last = -1

	q.Push = Push
	q.Pop = Pop

	return q
end

return queue