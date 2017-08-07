local MathUtil = require "MathUtil"
local Queue = require "Queue"

local frame = {}

local function FloodFill(data, x, y, target, newVal)
	if target == newVal then return end
	if data[y][x] ~= target then return end

	local q = Queue:New()
	q:Push({x = x, y = y})

	while true do
		local v = q:Pop()

		if v == nil then break end

		local w = {x = v.x, y = v.y}
		local e = {x = v.x, y = v.y}

		--Move pointers west and east
		while data[w.y][w.x] == target do
			w.x = w.x - 1
		end
		while data[e.y][e.x] == target do
			e.x = e.x + 1
		end

		w.x = w.x + 1
		e.x = e.x - 1

		for i = w.x, e.x do
			data[w.y][i] = newVal
			
			if data[w.y + 1] ~= nil and data[w.y + 1][i] == target then
				q:Push({x = i, y = w.y + 1})
			end

			if data[w.y - 1] ~= nil and data[w.y - 1][i] == target then
				q:Push({x = i, y = w.y - 1})
			end
		end
	end
end

local function RasterizeBorders(borders)
	local raster = {}

	for _, v in ipairs(borders) do
		table.insert(raster, {
			x = math.floor(v.x + 0.5),
			y = math.floor(v.y + 0.5)
			})
	end

	return raster
end

local function GenerateBorderFromDots(self, dots)
	local border = {}

	for i = 1, #dots do
		local d1 = dots[i]
		local d2 = dots[i + 1] or dots[1]

		for w = 0, 1, 1 / self.lerpSteps do
			table.insert(border, MathUtil:Lerp(d1, d2, w))
		end
	end

	return border
end

local function CalcMovingAvg(self, vectors)
	local movAvg = {}

	for i = 0, #vectors - 1 do
		local avgDistance = 0
		for d = -math.floor(self.windowSize / 2), math.ceil(self.windowSize / 2) do
			local v = vectors[(self.resolution + d + i) % self.resolution + 1]
			avgDistance = avgDistance + math.sqrt(v.x ^ 2 + v.y ^ 2)
		end
		avgDistance = avgDistance / self.windowSize

		local len = math.sqrt(vectors[i + 1].x ^ 2 + vectors[i + 1].y ^ 2)
		table.insert(movAvg, {
			x = vectors[i + 1].x / len * avgDistance,
			y = vectors[i + 1].y / len * avgDistance
			})
	end

	return movAvg
end

local function AdjustLength(self, v)
	local var = self.rng(-self.variance / 2, self.variance / 2)
	local w = {
		x = v.x * (self.radius + var),
		y = v.y * (self.radius + var)
	}
	return w
end

local function GenerateVectors(self)
	local vectors = {}

	for i = 0, self.resolution - 1 do
		local val = 2 * math.pi / self.resolution * i
		local v = AdjustLength(self, {
			x = math.cos(val),
			y = math.sin(val)
		})

		table.insert(vectors, v)
	end

	return vectors
end

local function Spawn(self, value)
	local vectors = GenerateVectors(self)
	local movAvg = CalcMovingAvg(self, vectors)
	local border = GenerateBorderFromDots(self, movAvg)
	local rasterizedBorders = RasterizeBorders(border)

	--Reformat
	local data = {}
	for _,v in pairs(rasterizedBorders) do
		if data[v.y] == nil then 
			data[v.y] = {}
		end

		data[v.y][v.x] = value
	end

	local blobTempVal = "blobTempVal"
	local halfSize = self.radius + self.variance

	for y = -halfSize, halfSize do
		if data[y] == nil then
			data[y] = {}
		end

		for x = -halfSize, halfSize do
			if data[y][x] == nil then
				data[y][x] = blobTempVal
			end
		end
	end

	FloodFill(data, 0, 0, blobTempVal, value)

	--Cleanup
	for y = -halfSize, halfSize do
		for x = -halfSize, halfSize do
			if data[y][x] == blobTempVal then
				data[y][x] = nil
			end
		end
	end

	return data
end

function frame:New(resolution, lerpSteps, radius, variance, windowSize)
	local blob = {}

	--Settings
	blob.resolution = resolution or 96
	blob.lerpSteps = lerpSteps or 200
	blob.radius = radius or 128
	blob.variance = variance or 128
	blob.windowSize = windowSize or 6


	blob.rng = game.create_random_generator()

	blob.Spawn = Spawn

	return blob
end

return frame