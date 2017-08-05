local MathUtil = require "libs.Util.MathUtil"

local Perlin = {}

function Perlin:GenerateGradientGrid(xMax, yMax, seed)
	if xMax == nil or yMax == nil then return end
	if seed ~= nil then
		math.randomseed(seed)
	end

	self.gradientGrid = {}
	local x,y
	for y = 1, yMax do
		self.gradientGrid[y] = {}

		for x = 1, xMax do
			self.gradientGrid[y][x] = {
				x = math.random(-1, 1),
				y = math.random(-1, 1)
			}
		end
	end
end

function Perlin:DotGridGradient(ix, iy, x, y)
	if self.gradientGrid == nil then return end

	local dx = math.abs(x - ix)
	local dy = math.abs(y - iy)

	if self.gradientGrid[iy] == nil then
		print("iy == nil")
	elseif self.gradientGrid[iy][ix] == nil then
		print("ix == nil")
	end

	--print("x: " .. self.gradientGrid[iy][ix].x .. " y: " .. self.gradientGrid[iy][ix].y)

	return dx * self.gradientGrid[iy][ix].x + dy * self.gradientGrid[iy][ix].y
end

function Perlin:GetNoise(x, y)
	-- Determine grid cell coordinates
	local x0 = math.floor(x)
	local x1 = x0 + 1
	local y0 = math.floor(y)
	local y1 = y0 + 1

	if x0 <= 0 or y0 <= 0 or x1 > 256 or y1 > 256 then
		print("x0: " .. x0 .. ", x1: " .. x1 .. ", y0: " .. y0 .. ", y1: " .. y1)
	end

	-- Determine interpolation weights
	local wx = x - x0
	local wy = y - y0

	-- Interpolate between grid point gradients
	local n0 = self:DotGridGradient(x0, y0, x, y)
	local n1 = self:DotGridGradient(x1, y0, x, y)
	local ix0 = MathUtil:Lerp(n0, n1, wx)

	n0 = self:DotGridGradient(x0, y1, x, y)
	n1 = self:DotGridGradient(x1, y1, x, y)
	local ix1 = MathUtil:Lerp(n0, n1, wx)

	return MathUtil:Lerp(ix0, ix1, wy)
end

--Fractional Brownian Motion
function Perlin:FBM(x, y, octs)
	local val = 0
	for o = 0, octs - 1 do
		val = val + (0.5 ^ o * self:GetNoise(x * 2 ^ o, y * 2 ^ o))
	end
	return val
end

return Perlin