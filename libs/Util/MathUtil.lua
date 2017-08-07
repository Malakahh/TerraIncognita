local MathUtil = {}

function MathUtil.Clamp(val, clampMin, clampMax)
	if val == nil then return end
	clampMin = clampMin or 0
	clampMax = clampMax or 1

	if val < clampMin then
		val = clampMin
	elseif val > clampMax then
		val = clampMax
	else
		return val
	end
end

function MathUtil:Lerp(a, b, weight)
	weight = self.Clamp(weight)

	return {
		x = (1 - weight) * a.x + weight * b.x,
		y = (1 - weight) * a.y + weight * b.y
	}
end

return MathUtil