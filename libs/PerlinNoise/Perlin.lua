local p = {}

p.size = 2097152

function p:init()
	self.perm = {}

	if self.rng == nil then
		self.rng = game.create_random_generator()
	end

	-- Create p.size shuffled numbers
	for i = 1, p.size do
	   table.insert(self.perm, self.rng(1, p.size))
	end

	-- Repeat the list
	for i = 1, p.size do
	   self.perm[i+p.size] = self.perm[i]
	end

	-- Generate p.size directions
	if self.dirs == nil then
		self.dirs = {}
		for a = 0, p.size - 1 do
		   table.insert(self.dirs, { math.cos(a * 2.0 * math.pi / p.size),
		                        math.sin(a * 2.0 * math.pi / p.size) })
		end
	end
end

function p:noise(x, y, per)
	local function surflet(grid_x, grid_y)
		local dist_x, dist_y = math.abs(x - grid_x), math.abs(y - grid_y)
		local poly_x = 1 - 6 * dist_x ^ 5 + 15 * dist_x ^ 4 - 10 * dist_x ^ 3
		local poly_y = 1 - 6 * dist_y ^ 5 + 15 * dist_y ^ 4 - 10 * dist_y ^ 3
		
		--Original
		--local hashed = self.perm[(self.perm[(math.floor(grid_x) % per) + 1] + math.floor(grid_y) % per) + 1]
		
		--Modified
		local hashed = self.perm[self.perm[math.floor(grid_x) % per + 1] + math.floor(grid_y) % per + 1]


		local grad = (x - grid_x)  * self.dirs[hashed][1] + (y - grid_y) * self.dirs[hashed][2]
		
		return poly_x * poly_y * grad
	end

	local int_x, int_y = math.floor(x), math.floor(y)
	return surflet(int_x+0, int_y+0) + surflet(int_x+1, int_y+0) +
		surflet(int_x+0, int_y+1) + surflet(int_x+1, int_y+1)
end

--Fractional Brownian Motion
function p:fBm(x, y, per, octs)
   local val = 0
   for o = 0, octs - 1 do
      val = val + (0.5 ^ o * self:noise(x * 2 ^ o, y * 2 ^ o, per * 2 ^ o))
   end
   return val
end

return p